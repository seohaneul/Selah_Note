import 'package:flutter/material.dart';
import '../data/selah_guide_model.dart';
import '../data/guide_template.dart';
import '../../../../core/database/local_db.dart';

class GuideDetailSheet extends StatefulWidget {
  final SelahGuideModel guide;
  final VoidCallback onUpdate;

  const GuideDetailSheet({
    Key? key,
    required this.guide,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<GuideDetailSheet> createState() => _GuideDetailSheetState();
}

class _GuideDetailSheetState extends State<GuideDetailSheet> {
  late GuideTemplate _template;
  final TextEditingController _refController = TextEditingController();
  final List<TextEditingController> _answerControllers = [];

  @override
  void initState() {
    super.initState();
    _template = GuideTemplate.getById(widget.guide.templateId);
    _refController.text = widget.guide.referenceText ?? '';
    
    for (int i = 0; i < _template.questions.length; i++) {
      final text = i < widget.guide.answers.length ? widget.guide.answers[i] : '';
      _answerControllers.add(TextEditingController(text: text));
    }
  }

  Future<void> _saveGuide() async {
    final refText = _refController.text.trim();
    final answers = _answerControllers.map((c) => c.text.trim()).toList();

    widget.guide.referenceText = refText.isEmpty ? null : refText;
    widget.guide.answers = answers;
    widget.guide.updatedAt = DateTime.now();

    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.selahGuideModels.put(widget.guide);
    });

    widget.onUpdate();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _deleteGuide() async {
    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.selahGuideModels.delete(widget.guide.id);
    });
    widget.onUpdate();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('${_template.theme} 기록', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 16.0),
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20, right: 20, top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('묵상한 말씀', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _refController,
                    decoration: InputDecoration(
                      hintText: '말씀을 입력하세요',
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
                  ..._template.questions.asMap().entries.map((entry) {
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: _deleteGuide,
                        tooltip: '묵상 삭제',
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: _saveGuide,
                            child: const Text('수정 저장하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
