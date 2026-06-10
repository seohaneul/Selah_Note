import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../memo/data/memo_model.dart';
import '../../memo/data/question_model.dart';
import '../../bible/data/highlight_model.dart';
import '../../memo/presentation/widgets/question_detail_sheet.dart';
import '../../../core/database/local_db.dart'; 

class LibraryScreen extends StatefulWidget {
  final Function(String bookName, int chapter, int verse) onNavigateToBible;

  const LibraryScreen({Key? key, required this.onNavigateToBible}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Memo> _memos = [];
  List<QuestionModel> _questions = [];
  List<HighlightModel> _highlights = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _loadData(); 
    });
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    _memos = await LocalDb.isar.memos.where().sortByCreatedAtDesc().findAll();
    _questions = await LocalDb.isar.questionModels.where().sortByCreatedAtDesc().findAll();
    _highlights = await LocalDb.isar.highlightModels.where().sortByCreatedAtDesc().findAll();
    
    setState(() => _isLoading = false);
  }

  void _showMemoOptions(Memo memo) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text('성경으로 이동'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onNavigateToBible(memo.bookName, memo.chapter, memo.verse);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('메모 삭제', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  await LocalDb.isar.writeTxn(() async {
                    await LocalDb.isar.memos.delete(memo.id);
                  });
                  Navigator.pop(context);
                  _loadData();
                },
              ),
            ],
          ),
        );
      }
    );
  }

  void _showHighlightOptions(HighlightModel highlight) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text('성경으로 이동'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onNavigateToBible(highlight.bookName, highlight.chapter, highlight.verse);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('형광펜 삭제', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  await LocalDb.isar.writeTxn(() async {
                    await LocalDb.isar.highlightModels.delete(highlight.id);
                  });
                  Navigator.pop(context);
                  _loadData();
                },
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 보관함'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '메모'),
            Tab(text: '질문(Q&A)'),
            Tab(text: '형광펜'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildMemoList(),
                _buildQuestionList(),
                _buildHighlightList(),
              ],
            ),
    );
  }

  Widget _buildMemoList() {
    if (_memos.isEmpty) return const Center(child: Text('저장된 메모가 없습니다.'));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _memos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final memo = _memos[index];
        return InkWell(
          onTap: () => _showMemoOptions(memo),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${memo.bookName} ${memo.chapter}장 ${memo.verse}절',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(memo.content),
                  const SizedBox(height: 8),
                  Text(
                    memo.createdAt.toString().split('.')[0],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionList() {
    if (_questions.isEmpty) return const Center(child: Text('등록된 질문이 없습니다.'));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _questions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final q = _questions[index];
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => QuestionDetailSheet(
                question: q,
                onUpdate: _loadData,
              ),
            );
          },
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(q.isResolved ? Icons.check_circle : Icons.help_outline, 
                           color: q.isResolved ? Colors.green : Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          q.questionText,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  if (q.bibleTags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children: q.bibleTags.map((tag) => Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 12)),
                        padding: EdgeInsets.zero,
                      )).toList(),
                    ),
                  ],
                  if (q.answerText != null && q.answerText!.isNotEmpty) ...[
                    const Divider(),
                    const Text('답변:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    Text(q.answerText!),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHighlightList() {
    if (_highlights.isEmpty) return const Center(child: Text('형광펜 기록이 없습니다.'));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _highlights.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final hl = _highlights[index];
        return InkWell(
          onTap: () => _showHighlightOptions(hl),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(backgroundColor: Color(hl.colorCode), radius: 8),
                      const SizedBox(width: 8),
                      Text(
                        '${hl.bookName} ${hl.chapter}장 ${hl.verse}절',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border(left: BorderSide(color: Color(hl.colorCode), width: 4)),
                    ),
                    child: Text(
                      hl.highlightedText.isEmpty ? '(텍스트 정보 없음)' : hl.highlightedText,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  if (hl.comment != null && hl.comment!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(hl.comment!),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
