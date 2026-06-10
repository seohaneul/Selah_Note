import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../data/daily_meditation_model.dart';
import '../../../../core/database/local_db.dart';

class MeditationRecordsSheet extends StatefulWidget {
  const MeditationRecordsSheet({Key? key}) : super(key: key);

  @override
  State<MeditationRecordsSheet> createState() => _MeditationRecordsSheetState();
}

class _MeditationRecordsSheetState extends State<MeditationRecordsSheet> {
  List<DailyMeditationModel> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final records = await LocalDb.isar.dailyMeditationModels.where().sortByCreatedAtDesc().findAll();
    if (mounted) {
      setState(() {
        _records = records;
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteRecord(Id id) async {
    await LocalDb.isar.writeTxn(() async {
      await LocalDb.isar.dailyMeditationModels.delete(id);
    });
    _loadRecords();
  }

  void _showDeleteConfirm(DailyMeditationModel record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기록 삭제'),
        content: const Text('이 묵상 조각을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteRecord(record.id);
            },
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('나의 묵상 조각들', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _records.isEmpty
                    ? const Center(child: Text('아직 저장된 조각이 없습니다.\n오늘의 묵상을 기록해 보세요!', textAlign: TextAlign.center))
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: _records.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final record = _records[index];
                          return Card(
                            elevation: 0,
                            color: Colors.grey.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${record.createdAt.year}년 ${record.createdAt.month}월 ${record.createdAt.day}일',
                                        style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () => _showDeleteConfirm(record),
                                        child: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    record.questionText,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    record.answerText,
                                    style: const TextStyle(fontSize: 15, height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
