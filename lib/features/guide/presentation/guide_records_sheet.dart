import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../data/selah_guide_model.dart';
import '../data/guide_template.dart';
import '../../../../core/database/local_db.dart';
import 'guide_detail_sheet.dart';

class GuideRecordsSheet extends StatefulWidget {
  const GuideRecordsSheet({Key? key}) : super(key: key);

  @override
  State<GuideRecordsSheet> createState() => _GuideRecordsSheetState();
}

class _GuideRecordsSheetState extends State<GuideRecordsSheet> {
  List<SelahGuideModel> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final records = await LocalDb.isar.selahGuideModels.where().sortByCreatedAtDesc().findAll();
    if (mounted) {
      setState(() {
        _records = records;
        _isLoading = false;
      });
    }
  }

  void _openDetail(SelahGuideModel record) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GuideDetailSheet(
        guide: record,
        onUpdate: _loadRecords,
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
                child: Text('나의 가이드 묵상 기록', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    ? const Center(child: Text('아직 작성된 묵상 기록이 없습니다.\n셀라 가이드를 시작해 보세요!', textAlign: TextAlign.center))
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: _records.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final record = _records[index];
                          final template = GuideTemplate.getById(record.templateId);
                          
                          return InkWell(
                            onTap: () => _openDetail(record),
                            borderRadius: BorderRadius.circular(16),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Chip(
                                          label: Text(template.theme, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
                                          backgroundColor: Colors.blue.shade50,
                                          side: BorderSide.none,
                                          padding: EdgeInsets.zero,
                                        ),
                                        const Spacer(),
                                        Text(
                                          record.createdAt.toString().split('.')[0],
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    if (record.referenceText != null && record.referenceText!.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.menu_book, size: 14, color: Colors.black54),
                                          const SizedBox(width: 4),
                                          Text(record.referenceText!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                                        ],
                                      ),
                                    ],
                                    const SizedBox(height: 12),
                                    Text(
                                      record.answers.firstWhere((a) => a.isNotEmpty, orElse: () => '(내용 없음)'),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
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
