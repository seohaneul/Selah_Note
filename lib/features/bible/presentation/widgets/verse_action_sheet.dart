import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/bible_model.dart';
import '../../../memo/presentation/widgets/memo_bottom_sheet.dart';

class VerseActionSheet extends StatelessWidget {
  final Verse verse;
  final VoidCallback onActionCompleted;

  const VerseActionSheet({
    Key? key,
    required this.verse,
    required this.onActionCompleted,
  }) : super(key: key);

  void _copyVerse(BuildContext context) {
    Clipboard.setData(ClipboardData(text: '${verse.bookName} ${verse.chapter}:${verse.verse} ${verse.text}'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('말씀이 복사되었습니다.')),
    );
    Navigator.pop(context);
  }

  void _openMemoSheet(BuildContext context) {
    Navigator.pop(context); // 액션 시트 닫기
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MemoBottomSheet(verse: verse),
    ).then((_) => onActionCompleted());
  }

  void _addBookmark(BuildContext context) {
    // TODO: 북마크 DB 연동
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('북마크가 추가되었습니다. (DB 연동 준비중)')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${verse.bookName} ${verse.chapter}장 ${verse.verse}절',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('메모 적기 / 질문 남기기'),
              onTap: () => _openMemoSheet(context),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_add_outlined),
              title: const Text('북마크 추가'),
              onTap: () => _addBookmark(context),
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('말씀 복사하기'),
              onTap: () => _copyVerse(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
