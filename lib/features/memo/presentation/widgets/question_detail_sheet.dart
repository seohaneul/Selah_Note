import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../data/question_model.dart';
import '../../../../core/database/local_db.dart';

class QuestionDetailSheet extends StatefulWidget {
  final QuestionModel question;
  final VoidCallback onUpdate;

  const QuestionDetailSheet({
    Key? key, 
    required this.question,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<QuestionDetailSheet> createState() => _QuestionDetailSheetState();
}

class _QuestionDetailSheetState extends State<QuestionDetailSheet> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  late bool _isResolved;
  late List<String> _currentTags;

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.question.questionText;
    _answerController.text = widget.question.answerText ?? '';
    _isResolved = widget.question.isResolved;
    _currentTags = List.from(widget.question.bibleTags);
  }

  List<String> _extractTags(String text) {
    final List<String> tags = [];
    // 정규식: @로 시작하고 성경책 이름, 장, 절을 포함하는 패턴 (예: @요한복음 3:16)
    final RegExp tagRegExp = RegExp(r'@([가-힣]+\s*\d+:\d+)');
    final Iterable<RegExpMatch> matches = tagRegExp.allMatches(text);
    for (final match in matches) {
      if (match.groupCount >= 1) {
        tags.add(match.group(1)!);
      }
    }
    return tags;
  }

  Future<void> _saveAnswer() async {
    final questionText = _questionController.text.trim();
    if (questionText.isEmpty) return; // 질문 내용이 없으면 저장하지 않음

    final answer = _answerController.text.trim();
    
    // 새로 추출된 태그와 삭제되지 않은 기존 태그 병합
    final newTags = _extractTags(questionText);
    final combinedTags = {..._currentTags, ...newTags}.toList();
    
    final updatedQuestion = QuestionModel(
      questionText: questionText,
      answerText: answer.isEmpty ? null : answer,
      isResolved: _isResolved,
      bibleTags: combinedTags,
      createdAt: widget.question.createdAt,
      updatedAt: DateTime.now(),
    );
    if (widget.question.id != Isar.autoIncrement) {
      updatedQuestion.id = widget.question.id;
    }

    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.questionModels.put(updatedQuestion);
    });

    widget.onUpdate();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _deleteQuestion() async {
    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.questionModels.delete(widget.question.id);
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
                const Text(
                  '신앙 질문 상세',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Question Text
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.help_outline, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Text('나의 질문', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                      const Spacer(),
                    ],
                  ),
                  if (_currentTags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _currentTags.map((tag) {
                          return InputChip(
                            label: Text(tag, style: const TextStyle(fontSize: 12, color: Colors.blue)),
                            backgroundColor: Colors.blue.shade50,
                            deleteIconColor: Colors.blue,
                            onDeleted: () {
                              setState(() {
                                _currentTags.remove(tag);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _questionController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: '여기에 질문 내용을 입력하세요. (예: @요한복음 3:16 무슨 뜻일까?)',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Status Toggle
            Row(
              children: [
                const Text('해결 상태:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text('미해결'),
                  selected: !_isResolved,
                  onSelected: (val) {
                    if (val) setState(() => _isResolved = false);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('해결 완료'),
                  selected: _isResolved,
                  onSelected: (val) {
                    if (val) setState(() => _isResolved = true);
                  },
                  selectedColor: Colors.green.shade100,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Answer Field
            TextField(
              controller: _answerController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '이 질문에 대한 해답이나 묵상 결과를 적어주세요.',
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Action Buttons
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _deleteQuestion,
                  tooltip: '질문 삭제',
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
                      onPressed: _saveAnswer,
                      child: const Text('답변 저장하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
