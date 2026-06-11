import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../memo/data/memo_model.dart';
import '../../memo/data/question_model.dart';
import '../../bible/data/highlight_model.dart';
import '../../bible/presentation/widgets/highlight_detail_sheet.dart';
import '../../memo/presentation/widgets/question_detail_sheet.dart';
import '../../memo/presentation/widgets/memo_detail_sheet.dart';
import '../../bible/data/bible_repository.dart';
import '../../../core/database/local_db.dart'; 

class LibraryScreen extends StatefulWidget {
  final Function(String bookName, int chapter, int verse) onNavigateToBible;

  const LibraryScreen({Key? key, required this.onNavigateToBible}) : super(key: key);

  @override
  State<LibraryScreen> createState() => LibraryScreenState();
}

class LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Memo> _memos = [];
  List<QuestionModel> _questions = [];
  List<HighlightModel> _highlights = [];
  bool _isLoading = true;

  // 필터 상태
  String _sortOrder = '최신순'; // 최신순, 오래된순, 성경 순서별
  String _selectedBook = '전체 보기';
  String _questionStatus = '전체 보기'; // 전체 보기, 미해결, 해결 완료

  List<String> get _availableBooks {
    return ['전체 보기', ...BibleRepository.bookFullNames.values];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadData();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {}); // 탭 전환 시 필터 바 업데이트
    });
  }

  int _getBookOrder(String name) {
    final fullName = BibleRepository.getFullName(name) ?? name;
    final list = BibleRepository.bookFullNames.values.toList();
    final idx = list.indexOf(fullName);
    return idx == -1 ? 999 : idx;
  }

  int _compareBibleOrder(String bookA, int chapA, int verseA, String bookB, int chapB, int verseB) {
    final orderA = _getBookOrder(bookA);
    final orderB = _getBookOrder(bookB);
    if (orderA != orderB) return orderA.compareTo(orderB);
    if (chapA != chapB) return chapA.compareTo(chapB);
    return verseA.compareTo(verseB);
  }

  Future<void> loadData() async {
    setState(() => _isLoading = true);
    
    List<Memo> allMemos = await LocalDb.isar.memos.where().findAll();
    List<QuestionModel> allQuestions = await LocalDb.isar.questionModels.where().findAll();
    List<HighlightModel> allHighlights = await LocalDb.isar.highlightModels.where().findAll();

    // 1. 성경 권 별 필터링
    if (_selectedBook != '전체 보기') {
      allMemos = allMemos.where((m) => BibleRepository.getFullName(m.bookName) == _selectedBook || m.bookName == _selectedBook).toList();
      allHighlights = allHighlights.where((h) => BibleRepository.getFullName(h.bookName) == _selectedBook || h.bookName == _selectedBook).toList();
      allQuestions = allQuestions.where((q) => q.bibleTags.any((tag) => tag.startsWith(_selectedBook))).toList();
    }

    // 2. 질문 상태 필터링
    if (_questionStatus != '전체 보기') {
      final isResolvedTarget = _questionStatus == '해결 완료';
      allQuestions = allQuestions.where((q) => q.isResolved == isResolvedTarget).toList();
    }

    // 3. 정렬 (공통)
    if (_sortOrder == '성경 순서별') {
      allMemos.sort((a, b) => _compareBibleOrder(a.bookName, a.chapter, a.verse, b.bookName, b.chapter, b.verse));
      allHighlights.sort((a, b) => _compareBibleOrder(a.bookName, a.chapter, a.verse, b.bookName, b.chapter, b.verse));
      allQuestions.sort((a, b) {
        if (a.bibleTags.isEmpty || b.bibleTags.isEmpty) return 0;
        // 아주 단순화된 파싱 로직 (요한복음 3:16)
        try {
          final partsA = a.bibleTags.first.split(' ');
          final partsB = b.bibleTags.first.split(' ');
          final cvA = partsA.last.split(':');
          final cvB = partsB.last.split(':');
          return _compareBibleOrder(partsA.first, int.parse(cvA[0]), int.parse(cvA[1]), partsB.first, int.parse(cvB[0]), int.parse(cvB[1]));
        } catch (_) {
          return a.createdAt.compareTo(b.createdAt);
        }
      });
    } else {
      final ascending = _sortOrder == '오래된순';
      allMemos.sort((a, b) => ascending ? a.createdAt.compareTo(b.createdAt) : b.createdAt.compareTo(a.createdAt));
      allHighlights.sort((a, b) => ascending ? a.createdAt.compareTo(b.createdAt) : b.createdAt.compareTo(a.createdAt));
      allQuestions.sort((a, b) => ascending ? a.createdAt.compareTo(b.createdAt) : b.createdAt.compareTo(a.createdAt));
    }

    if (mounted) {
      setState(() {
        _memos = allMemos;
        _questions = allQuestions;
        _highlights = allHighlights;
        _isLoading = false;
      });
    }
  }

  void _showMemoOptions(Memo memo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MemoDetailSheet(
        memo: memo,
        onUpdate: loadData,
      ),
    );
  }

  void _showHighlightOptions(HighlightModel highlight) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HighlightDetailSheet(
        highlight: highlight,
        onUpdate: loadData,
      ),
    );
  }

  void openHighlightDetail(HighlightModel highlight) {
    _tabController.animateTo(2); // 형광펜 탭으로 이동
    _showHighlightOptions(highlight);
  }

  // --- UI 렌더링 ---
  @override
  Widget build(BuildContext context) {
    final isQuestionTab = _tabController.index == 1;

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
      body: Column(
        children: [
          // 드롭다운 필터 바
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // 정렬 옵션
                  _buildDropdown(
                    value: _sortOrder,
                    items: const ['최신순', '오래된순', '성경 순서별'],
                    onChanged: (val) {
                      setState(() => _sortOrder = val!);
                      loadData();
                    },
                  ),
                  const SizedBox(width: 8),
                  // 권 별 필터
                  _buildDropdown(
                    value: _selectedBook,
                    items: _availableBooks,
                    onChanged: (val) {
                      setState(() => _selectedBook = val!);
                      loadData();
                    },
                  ),
                  const SizedBox(width: 8),
                  // 질문 상태 필터 (질문 탭에서만 보임)
                  if (isQuestionTab)
                    _buildDropdown(
                      value: _questionStatus,
                      items: const ['전체 보기', '미해결', '해결 완료'],
                      onChanged: (val) {
                        setState(() => _questionStatus = val!);
                        loadData();
                      },
                    ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMemoList(),
                      _buildQuestionList(),
                      _buildHighlightList(),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: isQuestionTab
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => QuestionDetailSheet(
                    question: QuestionModel(
                      questionText: '',
                      isResolved: false,
                      bibleTags: const [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    onUpdate: loadData,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('새 질문 작성'),
            )
          : null,
    );
  }

  Widget _buildDropdown({required String value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          icon: const Icon(Icons.arrow_drop_down, size: 20),
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          onChanged: onChanged,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${BibleRepository.getFullName(memo.bookName) ?? memo.bookName} ${memo.chapter}장 ${memo.verse}절',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.menu_book, size: 20),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => widget.onNavigateToBible(memo.bookName, memo.chapter, memo.verse),
                        tooltip: '성경 말씀 보기',
                      ),
                    ],
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
    if (_questions.isEmpty) return const Center(child: Text('해당되는 질문이 없습니다.'));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _questions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final q = _questions[index];
        return Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            title: Row(
              children: [
                Icon(q.isResolved ? Icons.check_circle : Icons.help_outline, 
                     color: q.isResolved ? Colors.green : Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    q.questionText,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => QuestionDetailSheet(
                        question: q,
                        onUpdate: loadData,
                      ),
                    );
                  },
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (q.bibleTags.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        children: q.bibleTags.map((tag) => ActionChip(
                          label: Text(tag, style: const TextStyle(fontSize: 12)),
                          avatar: const Icon(Icons.menu_book, size: 14),
                          onPressed: () {
                            try {
                              final parts = tag.split(' ');
                              final cv = parts[1].split(':');
                              widget.onNavigateToBible(parts[0], int.parse(cv[0]), int.parse(cv[1]));
                            } catch (_) {}
                          },
                        )).toList(),
                      ),
                      const SizedBox(height: 12),
                    ],
                    const Divider(),
                    const SizedBox(height: 8),
                    if (q.answerText != null && q.answerText!.isNotEmpty) ...[
                      const Text('나의 답변', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text(q.answerText!, style: const TextStyle(fontSize: 15, height: 1.5)),
                    ] else ...[
                      const Text('아직 작성된 답변이 없습니다.', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHighlightList() {
    if (_highlights.isEmpty) return const Center(child: Text('저장된 형광펜 기록이 없습니다.'));
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
                        '${BibleRepository.getFullName(hl.bookName) ?? hl.bookName} ${hl.chapter}장 ${hl.verse}절',
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
