import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../../data/bible_model.dart';
import '../../../memo/presentation/widgets/memo_bottom_sheet.dart';
import '../../../memo/presentation/widgets/question_detail_sheet.dart';
import '../../../memo/data/memo_model.dart';
import '../../../memo/data/question_model.dart';
import '../../../../core/database/local_db.dart';

class VerseActionSheet extends StatefulWidget {
  final Verse verse;
  final VoidCallback onActionCompleted;

  const VerseActionSheet({
    Key? key,
    required this.verse,
    required this.onActionCompleted,
  }) : super(key: key);

  @override
  State<VerseActionSheet> createState() => _VerseActionSheetState();
}

class _VerseActionSheetState extends State<VerseActionSheet> {
  List<Memo> _memos = [];
  List<QuestionModel> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final memos = await LocalDb.isar.memos.filter()
      .bookNameEqualTo(widget.verse.bookName)
      .chapterEqualTo(widget.verse.chapter)
      .verseEqualTo(widget.verse.verse)
      .sortByCreatedAtDesc()
      .findAll();

    final String tagPattern = '${widget.verse.bookName} ${widget.verse.chapter}:${widget.verse.verse}';
    final questions = await LocalDb.isar.questionModels.filter()
      .bibleTagsElementStartsWith(tagPattern)
      .sortByCreatedAtDesc()
      .findAll();

    if (mounted) {
      setState(() {
        _memos = memos;
        _questions = questions;
        _isLoading = false;
      });
    }
  }

  void _copyVerse(BuildContext context) {
    Clipboard.setData(ClipboardData(text: '${widget.verse.bookName} ${widget.verse.chapter}:${widget.verse.verse} ${widget.verse.text}'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('말씀이 복사되었습니다.')),
    );
    Navigator.pop(context);
  }

  void _openMemoSheet(BuildContext context, {Memo? existingMemo, QuestionModel? existingQuestion}) {
    Navigator.pop(context); 
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MemoBottomSheet(
        verse: widget.verse, 
        initialMemo: existingMemo,
        initialQuestion: existingQuestion,
      ),
    ).then((_) => widget.onActionCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
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
                  '${widget.verse.bookName} ${widget.verse.chapter}장 ${widget.verse.verse}절',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                )
              else ...[
                // 기존 메모 표시
                ..._memos.map((memo) => ListTile(
                  leading: const Icon(Icons.note, color: Colors.blue),
                  title: Text(memo.content, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: const Text('묵상 메모', style: TextStyle(fontSize: 12)),
                  onTap: () => _openMemoSheet(context, existingMemo: memo),
                )),
                
                // 기존 질문 표시
                ..._questions.map((q) => ListTile(
                  leading: Icon(q.isResolved ? Icons.check_circle : Icons.help_outline, 
                               color: q.isResolved ? Colors.green : Colors.orange),
                  title: Text(q.questionText, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: const Text('신앙 질문', style: TextStyle(fontSize: 12)),
                  onTap: () => _openMemoSheet(context, existingQuestion: q),
                )),
                
                if (_memos.isNotEmpty || _questions.isNotEmpty)
                  const Divider(height: 1),
                  
                ListTile(
                  leading: const Icon(Icons.edit_note, color: Colors.black87),
                  title: const Text('새 묵상/질문 작성하기', style: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () => _openMemoSheet(context),
                ),
              ],
              
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('말씀 복사하기'),
                onTap: () => _copyVerse(context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
