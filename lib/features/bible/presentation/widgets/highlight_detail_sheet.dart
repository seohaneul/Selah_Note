import 'package:flutter/material.dart';
import '../../data/highlight_model.dart';
import '../../../../core/database/local_db.dart';

class HighlightDetailSheet extends StatefulWidget {
  final HighlightModel highlight;
  final VoidCallback onUpdate;

  const HighlightDetailSheet({
    Key? key,
    required this.highlight,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<HighlightDetailSheet> createState() => _HighlightDetailSheetState();
}

class _HighlightDetailSheetState extends State<HighlightDetailSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commentController.text = widget.highlight.comment ?? '';
  }

  Future<void> _saveComment() async {
    final comment = _commentController.text.trim();
    
    final updatedHighlight = HighlightModel(
      bookName: widget.highlight.bookName,
      chapter: widget.highlight.chapter,
      verse: widget.highlight.verse,
      startIndex: widget.highlight.startIndex,
      endIndex: widget.highlight.endIndex,
      colorCode: widget.highlight.colorCode,
      highlightedText: widget.highlight.highlightedText,
      comment: comment.isEmpty ? null : comment,
      createdAt: widget.highlight.createdAt,
    );
    updatedHighlight.id = widget.highlight.id;

    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.highlightModels.put(updatedHighlight);
    });

    widget.onUpdate();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _deleteHighlight() async {
    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.highlightModels.delete(widget.highlight.id);
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
                  '${widget.highlight.bookName} ${widget.highlight.chapter}:${widget.highlight.verse} 형광펜',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(left: BorderSide(color: Color(widget.highlight.colorCode), width: 4)),
              ),
              child: Text(
                widget.highlight.highlightedText.isEmpty ? '(텍스트 정보 없음)' : widget.highlight.highlightedText,
                style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: '이 형광펜에 대한 코멘트나 메모를 적어주세요.',
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
                  onPressed: _deleteHighlight,
                  tooltip: '형광펜 지우기',
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
                      onPressed: _saveComment,
                      child: const Text('코멘트 저장하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
