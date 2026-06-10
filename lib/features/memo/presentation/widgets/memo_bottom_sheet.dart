import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../../../core/database/local_db.dart';
import '../../../bible/data/bible_model.dart';
import '../../data/memo_model.dart';
import '../../data/question_model.dart';

class MemoBottomSheet extends StatefulWidget {
  final Verse verse;
  final Memo? initialMemo;
  final QuestionModel? initialQuestion;

  const MemoBottomSheet({
    Key? key, 
    required this.verse,
    this.initialMemo,
    this.initialQuestion,
  }) : super(key: key);

  @override
  State<MemoBottomSheet> createState() => _MemoBottomSheetState();
}

class _MemoBottomSheetState extends State<MemoBottomSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _memoController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  
  Memo? _existingMemo;
  QuestionModel? _existingQuestion;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2, 
      vsync: this,
      initialIndex: widget.initialQuestion != null ? 1 : 0,
    );
    
    _existingMemo = widget.initialMemo;
    _existingQuestion = widget.initialQuestion;
    
    if (_existingMemo != null) {
      _memoController.text = _existingMemo!.content;
    }
    if (_existingQuestion != null) {
      _questionController.text = _existingQuestion!.questionText;
    }
  }

  Future<void> _saveData() async {
    final isMemoTab = _tabController.index == 0;

    await LocalDb.isar.writeTxn(() async {
      if (isMemoTab) {
        final text = _memoController.text.trim();
        if (text.isEmpty && _existingMemo != null) {
          await LocalDb.isar.memos.delete(_existingMemo!.id);
        } else if (text.isNotEmpty) {
          final newMemo = Memo(
            bookName: widget.verse.bookName,
            chapter: widget.verse.chapter,
            verse: widget.verse.verse,
            content: text,
            createdAt: _existingMemo?.createdAt ?? DateTime.now(),
            updatedAt: DateTime.now(),
          );
          if (_existingMemo != null) newMemo.id = _existingMemo!.id;
          await LocalDb.isar.memos.put(newMemo);
        }
      } else {
        // Question Tab
        final text = _questionController.text.trim();
        if (text.isEmpty && _existingQuestion != null) {
          await LocalDb.isar.questionModels.delete(_existingQuestion!.id);
        } else if (text.isNotEmpty) {
          final tag = '${widget.verse.bookName} ${widget.verse.chapter}:${widget.verse.verse}';
          final newQuestion = QuestionModel(
            questionText: text,
            answerText: _existingQuestion?.answerText,
            isResolved: _existingQuestion?.isResolved ?? false,
            bibleTags: _existingQuestion?.bibleTags ?? [tag],
            createdAt: _existingQuestion?.createdAt ?? DateTime.now(),
            updatedAt: DateTime.now(),
          );
          if (_existingQuestion != null) newQuestion.id = _existingQuestion!.id;
          await LocalDb.isar.questionModels.put(newQuestion);
        }
      }
    });

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.verse.bookName} ${widget.verse.chapter}:${widget.verse.verse}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: '묵상 메모'),
              Tab(text: '신앙 질문'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTextField(_memoController, '이 구절을 읽고 깨달은 점을 적어보세요.'),
                _buildTextField(_questionController, '이 구절에서 이해가 안 가거나 궁금한 점을 적어보세요.'),
              ],
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
              onPressed: _saveData,
              child: const Text('저장하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
