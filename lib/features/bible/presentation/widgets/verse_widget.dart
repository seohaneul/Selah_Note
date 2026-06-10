import 'package:flutter/material.dart';
import '../../data/bible_model.dart';
import '../../../../core/utils/highlight_parser.dart';
import '../../../memo/presentation/widgets/memo_bottom_sheet.dart';

class VerseWidget extends StatefulWidget {
  final Verse verse;

  const VerseWidget({Key? key, required this.verse}) : super(key: key);

  @override
  State<VerseWidget> createState() => _VerseWidgetState();
}

class _VerseWidgetState extends State<VerseWidget> {
  // 샘플 하이라이트 (실제로는 DB에서 로드)
  List<HighlightData> highlights = [];
  bool hasMemo = false; // 샘플 플래그

  @override
  void initState() {
    super.initState();
    if (widget.verse.verse == 1) {
      highlights.add(HighlightData(startIndex: 4, endIndex: 8, color: Colors.orange.withOpacity(0.4)));
      hasMemo = true;
    }
  }

  void _showMemoOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => MemoBottomSheet(verse: widget.verse),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMemoOptions,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 절 번호 및 메모 아이콘
          SizedBox(
            width: 30,
            child: Column(
              children: [
                Text(
                  '${widget.verse.verse}',
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                if (hasMemo)
                  const Icon(Icons.edit_note, size: 16, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(width: 8),
          
          // 텍스트 본문 (하이라이트 적용)
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
    );
  }
}
