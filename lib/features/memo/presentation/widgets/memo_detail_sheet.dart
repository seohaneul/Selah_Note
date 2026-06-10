import 'package:flutter/material.dart';
import '../../data/memo_model.dart';
import '../../../../core/database/local_db.dart';

class MemoDetailSheet extends StatefulWidget {
  final Memo memo;
  final VoidCallback onUpdate;

  const MemoDetailSheet({
    Key? key,
    required this.memo,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<MemoDetailSheet> createState() => _MemoDetailSheetState();
}

class _MemoDetailSheetState extends State<MemoDetailSheet> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.memo.content;
  }

  Future<void> _saveMemo() async {
    final content = _contentController.text.trim();
    
    final updatedMemo = Memo(
      bookName: widget.memo.bookName,
      chapter: widget.memo.chapter,
      verse: widget.memo.verse,
      content: content.isEmpty ? widget.memo.content : content,
      createdAt: widget.memo.createdAt,
      updatedAt: DateTime.now(),
    );
    updatedMemo.id = widget.memo.id;

    await LocalDb.isar.writeTxn(() async {
      if (content.isEmpty) {
        await LocalDb.isar.memos.delete(widget.memo.id);
      } else {
        await LocalDb.isar.memos.put(updatedMemo);
      }
    });

    widget.onUpdate();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _deleteMemo() async {
    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.memos.delete(widget.memo.id);
    });
    widget.onUpdate();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.memo.bookName} ${widget.memo.chapter}:${widget.memo.verse} 묵상 메모',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '메모 내용을 입력하세요.',
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _deleteMemo,
                  tooltip: '메모 삭제',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _saveMemo,
                      child: const Text('메모 수정하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
