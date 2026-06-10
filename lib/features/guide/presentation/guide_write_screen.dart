import 'package:flutter/material.dart';
import '../data/guide_template.dart';
import '../data/selah_guide_model.dart';
import '../../../../core/database/local_db.dart';

class GuideWriteScreen extends StatefulWidget {
  final GuideTemplate template;

  const GuideWriteScreen({Key? key, required this.template}) : super(key: key);

  @override
  State<GuideWriteScreen> createState() => _GuideWriteScreenState();
}

class _GuideWriteScreenState extends State<GuideWriteScreen> {
  final TextEditingController _refController = TextEditingController();
  final List<TextEditingController> _answerControllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.template.questions.length; i++) {
      _answerControllers.add(TextEditingController());
    }
  }

  Future<void> _saveGuide() async {
    final refText = _refController.text.trim();
    final answers = _answerControllers.map((c) => c.text.trim()).toList();
    
    // 빈 답변이 하나라도 있는지 확인 (선택적)
    // if (answers.any((a) => a.isEmpty)) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('모든 질문에 답해주세요.')));
    //   return;
    // }

    final newGuide = SelahGuideModel()
      ..templateId = widget.template.templateId
      ..referenceText = refText.isEmpty ? null : refText
      ..answers = answers
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.selahGuideModels.put(newGuide);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('묵상이 저장되었습니다.')));
      Navigator.pop(context); // 가이드 메인 화면으로 돌아가기
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.template.theme),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.template.description,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            
            // 말씀 주소 입력란
            const Text('묵상할 말씀 (선택사항)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _refController,
              decoration: InputDecoration(
                hintText: '예: 요한복음 3:16',
                filled: true,
                fillColor: Colors.grey.shade50,
                prefixIcon: const Icon(Icons.menu_book),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 질문 리스트
            ...widget.template.questions.asMap().entries.map((entry) {
              final idx = entry.key;
              final q = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text('${q.step}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Text(q.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(q.content, style: const TextStyle(fontSize: 16, height: 1.4)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _answerControllers[idx],
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: '답변을 적어주세요...',
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _saveGuide,
                child: const Text('묵상 완료하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
