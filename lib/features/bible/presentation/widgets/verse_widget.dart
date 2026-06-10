import 'package:flutter/material.dart';
import '../../data/bible_model.dart';
import '../../data/highlight_model.dart';
import '../../../../core/utils/highlight_parser.dart';
import '../../../memo/presentation/widgets/memo_bottom_sheet.dart';

class VerseWidget extends StatefulWidget {
  final Verse verse;
  final int bookId;
  final int chapter;

  const VerseWidget({Key? key, required this.verse, required this.bookId, required this.chapter}) : super(key: key);

  @override
  State<VerseWidget> createState() => _VerseWidgetState();
}

class _VerseWidgetState extends State<VerseWidget> {
  List<HighlightModel> highlights = [];
  bool hasMemo = false; 

  @override
  void initState() {
    super.initState();
    // 초기 로딩용 샘플 하이라이트 추가
    if (widget.verse.verse == 1) {
      highlights.add(HighlightModel(
        bookId: widget.bookId,
        chapter: widget.chapter,
        verse: widget.verse.verse,
        startIndex: 4, 
        endIndex: 8, 
        colorCode: const Color(0x66D9A05B).value,
      ));
      hasMemo = true;
    }
  }

  void _showMemoOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MemoBottomSheet(verse: widget.verse),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMemoOptions,
      child: Container(
        color: Colors.transparent, // 터치 영역 확보용
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.verse.verse}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary, 
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (hasMemo) ...[
                    const SizedBox(height: 4),
                    Icon(Icons.edit_note_rounded, size: 18, color: Theme.of(context).colorScheme.primary),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: HighlightParser.buildVerseSpans(widget.verse.text, highlights),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
