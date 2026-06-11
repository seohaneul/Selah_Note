import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../data/daily_questions.dart';
import '../data/daily_meditation_model.dart';
import 'dart:math';
import '../../../../core/database/local_db.dart';
import 'meditation_records_sheet.dart';

class TodayMeditationScreen extends StatefulWidget {
  const TodayMeditationScreen({Key? key}) : super(key: key);

  @override
  State<TodayMeditationScreen> createState() => _TodayMeditationScreenState();
}

class _TodayMeditationScreenState extends State<TodayMeditationScreen> {
  final TextEditingController _answerController = TextEditingController();
  late DailyQuestionData _todayQuestion;
  DailyMeditationModel? _existingMeditation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determineTodayQuestion();
    _loadExistingMeditation();
  }

  void _determineTodayQuestion() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final dayOfYear = now.difference(startOfYear).inDays + 1;
    
    // 100일 단위로 사이클을 계산하여 고정된 무작위 시드(seed) 생성
    // 이렇게 하면 매일 순서가 바뀌지 않으면서도 100일 동안 질문이 겹치지 않음
    final cycleNumber = (dayOfYear - 1) ~/ DailyQuestions.list.length; 
    final seed = now.year * 1000 + cycleNumber;
    final random = Random(seed);
    
    // 인덱스를 생성하고 무작위로 섞기
    final indices = List.generate(DailyQuestions.list.length, (i) => i);
    indices.shuffle(random);
    
    // 오늘의 날짜에 해당하는 무작위 인덱스 가져오기
    final todayIndex = (dayOfYear - 1) % DailyQuestions.list.length;
    final shuffledQuestionIndex = indices[todayIndex];
    
    _todayQuestion = DailyQuestions.list[shuffledQuestionIndex];
  }

  Future<void> _loadExistingMeditation() async {
    // 오늘 작성한 현재 질문의 기록이 있는지 확인
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final record = await LocalDb.isar.dailyMeditationModels
        .where()
        .filter()
        .questionIdEqualTo(_todayQuestion.id)
        .createdAtBetween(startOfDay, endOfDay)
        .findFirst();

    if (mounted) {
      setState(() {
        _existingMeditation = record;
        if (record != null) {
          _answerController.text = record.answerText;
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _saveMeditation() async {
    final answerText = _answerController.text.trim();
    if (answerText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('생각을 적어주세요.')));
      return;
    }

    final model = DailyMeditationModel()
      ..questionId = _todayQuestion.id
      ..tag = _todayQuestion.tag
      ..questionText = _todayQuestion.question
      ..answerText = answerText
      ..createdAt = _existingMeditation?.createdAt ?? DateTime.now()
      ..updatedAt = DateTime.now();

    if (_existingMeditation != null) {
      model.id = _existingMeditation!.id;
    }

    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.dailyMeditationModels.put(model);
    });

    if (mounted) {
      setState(() {
        _existingMeditation = model;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('오늘의 조각이 저장되었습니다.')));
    }
  }

  void _openRecords() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const MeditationRecordsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 묵상', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.history, color: Colors.black87),
            label: const Text('기록 보기', style: TextStyle(color: Colors.black87)),
            onPressed: _openRecords,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜 표시
            Text(
              '${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일',
              style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 태그 칩
            Chip(
              label: Text('#${_todayQuestion.tag}', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.blue.shade50,
              side: BorderSide.none,
            ),
            const SizedBox(height: 16),
            
            // 질문 텍스트
            Text(
              _todayQuestion.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, height: 1.4),
            ),
            const SizedBox(height: 32),
            
            if (_existingMeditation != null) ...[
              Card(
                elevation: 0,
                color: Colors.grey.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          Text('오늘의 묵상 기록 완료', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _existingMeditation!.answerText,
                        style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton.icon(
                  onPressed: _openRecords,
                  icon: const Icon(Icons.edit_note, color: Colors.grey),
                  label: const Text('수정은 우측 상단의 "기록 보기"에서 가능합니다', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ),
              ),
            ] else ...[
              // 답변 입력창
              TextField(
                controller: _answerController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: '이 질문에 대한 나의 생각이나 기도를 자유롭게 적어보세요...',
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // 저장 버튼
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: _saveMeditation,
                  child: const Text('조각 저장하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
