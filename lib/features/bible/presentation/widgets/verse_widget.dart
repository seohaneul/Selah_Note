import 'package:flutter/material.dart';
import 'verse_action_sheet.dart';
import 'package:isar/isar.dart';
import '../../data/bible_model.dart';
import '../../data/highlight_model.dart';
import '../../../../core/utils/highlight_parser.dart';
import '../../../../core/database/local_db.dart';
import '../../../memo/presentation/widgets/memo_bottom_sheet.dart';
import '../../../memo/data/memo_model.dart';

class VerseWidget extends StatefulWidget {
  final Verse verse;
  final Function(HighlightModel)? onHighlightTap;

  const VerseWidget({
    Key? key, 
    required this.verse,
    this.onHighlightTap,
  }) : super(key: key);

  @override
  State<VerseWidget> createState() => _VerseWidgetState();
}

class _VerseWidgetState extends State<VerseWidget> {
  List<HighlightModel> highlights = [];
  bool hasMemo = false; 

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final hl = await LocalDb.isar.highlightModels.filter()
      .bookNameEqualTo(widget.verse.bookName)
      .chapterEqualTo(widget.verse.chapter)
      .verseEqualTo(widget.verse.verse)
      .findAll();
      
    final memoCount = await LocalDb.isar.memos.filter()
      .bookNameEqualTo(widget.verse.bookName)
      .chapterEqualTo(widget.verse.chapter)
      .verseEqualTo(widget.verse.verse)
      .count();

    if (mounted) {
      setState(() {
        highlights = hl;
        hasMemo = memoCount > 0;
      });
    }
  }

  Future<void> _addHighlight(int start, int end) async {
    final highlight = HighlightModel(
      bookName: widget.verse.bookName,
      chapter: widget.verse.chapter,
      verse: widget.verse.verse,
      startIndex: start,
      endIndex: end,
      colorCode: const Color(0x66D9A05B).value, // 주황색 하이라이트
      highlightedText: widget.verse.text.substring(start, end),
      createdAt: DateTime.now(),
    );
    
    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.highlightModels.put(highlight);
    });
    
    _loadData();
  }

  void _showActionMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => VerseActionSheet(
        verse: widget.verse,
        onActionCompleted: _loadData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showActionMenu,
      child: Container(
        color: Colors.transparent,
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
              // 드래그 하이라이트를 위한 SelectableText
              child: SelectableText.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: HighlightParser.buildVerseSpans(
                    widget.verse.text, 
                    highlights,
                    onHighlightTap: widget.onHighlightTap,
                  ),
                ),
                onTap: _showActionMenu, // Text 자체 터치 시 팝업 띄우기
                contextMenuBuilder: (context, editableTextState) {
                  final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                  buttonItems.insert(
                    0,
                    ContextMenuButtonItem(
                      label: '형광펜',
                      onPressed: () {
                        final TextSelection selection = editableTextState.textEditingValue.selection;
                        _addHighlight(selection.start, selection.end);
                        ContextMenuController.removeAny();
                      },
                    ),
                  );
                  return AdaptiveTextSelectionToolbar.buttonItems(
                    anchors: editableTextState.contextMenuAnchors,
                    buttonItems: buttonItems,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
