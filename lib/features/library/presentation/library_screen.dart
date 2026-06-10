import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../memo/data/memo_model.dart';
import '../../bible/data/highlight_model.dart';
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
  List<HighlightModel> _highlights = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _loadData(); 
    });
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    _memos = await LocalDb.isar.memos.where().sortByCreatedAtDesc().findAll();
    
    // HighlightModel에는 작성일자가 없으므로 그냥 모두 가져옵니다.
    _highlights = await LocalDb.isar.highlightModels.where().findAll();
    
    setState(() => _isLoading = false);
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
                _buildHighlightList(),
              ],
            ),
    );
  }

  Widget _buildMemoList() {
    if (_memos.isEmpty) {
      return const Center(child: Text('저장된 메모가 없습니다.'));
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _memos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final memo = _memos[index];
        return Card(
          elevation: 2,
          child: ListTile(
            title: Text(
              '${memo.bookName} ${memo.chapter}장 ${memo.verse}절',
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                memo.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            onTap: () {
              widget.onNavigateToBible(memo.bookName, memo.chapter, memo.verse);
            },
          ),
        );
      },
    );
  }

  Widget _buildHighlightList() {
    if (_highlights.isEmpty) {
      return const Center(child: Text('형광펜 기록이 없습니다.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _highlights.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final highlight = _highlights[index];
        return Card(
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(highlight.colorCode),
              radius: 12,
            ),
            title: Text(
              '${highlight.bookName} ${highlight.chapter}장 ${highlight.verse}절',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              widget.onNavigateToBible(highlight.bookName, highlight.chapter, highlight.verse);
            },
          ),
        );
      },
    );
  }
}
