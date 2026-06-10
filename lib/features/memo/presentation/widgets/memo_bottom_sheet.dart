import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../../../core/database/local_db.dart';
import '../../../bible/data/bible_model.dart';
import '../../data/memo_model.dart';

class MemoBottomSheet extends StatefulWidget {
  final Verse verse;

  const MemoBottomSheet({Key? key, required this.verse}) : super(key: key);

  @override
  State<MemoBottomSheet> createState() => _MemoBottomSheetState();
}

class _MemoBottomSheetState extends State<MemoBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  String _selectedStatus = 'general';
  Memo? _existingMemo;

  @override
  void initState() {
    super.initState();
    _loadMemo();
  }

  Future<void> _loadMemo() async {
    final memo = await LocalDb.isar.memos.filter()
      .bookNameEqualTo(widget.verse.bookName)
      .chapterEqualTo(widget.verse.chapter)
      .verseEqualTo(widget.verse.verse)
      .findFirst();

    if (memo != null && mounted) {
      setState(() {
        _existingMemo = memo;
        _controller.text = memo.content;
        _selectedStatus = memo.status;
      });
    }
  }

  Future<void> _saveMemo() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _existingMemo == null) {
      Navigator.pop(context);
      return;
    }

    final newMemo = Memo(
      bookName: widget.verse.bookName,
      chapter: widget.verse.chapter,
      verse: widget.verse.verse,
      content: text,
      status: _selectedStatus,
      createdAt: _existingMemo?.createdAt ?? DateTime.now(),
    );

    if (_existingMemo != null) {
      newMemo.id = _existingMemo!.id; // Update
    }

    await LocalDb.isar.writeTxn(() async {
      if (text.isEmpty && _existingMemo != null) {
        await LocalDb.isar.memos.delete(_existingMemo!.id);
      } else {
        await LocalDb.isar.memos.put(newMemo);
      }
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.verse.bookName} ${widget.verse.chapter}:${widget.verse.verse} 묵상',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatusChip('일반 묵상', 'general'),
                const SizedBox(width: 8),
                _buildStatusChip('풀리지 않은 질문', 'unresolved_question'),
                const SizedBox(width: 8),
                _buildStatusChip('해답을 찾은 질문', 'resolved_question'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: '이 구절을 읽고 깨달은 점이나 질문을 적어보세요.',
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _saveMemo,
              child: const Text('저장하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, String value) {
    final isSelected = _selectedStatus == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) setState(() => _selectedStatus = value);
      },
      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black54,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
