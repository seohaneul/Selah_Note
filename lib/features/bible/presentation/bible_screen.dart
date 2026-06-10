import 'package:flutter/material.dart';
import '../data/bible_repository.dart';
import '../data/bible_model.dart';
import 'widgets/verse_widget.dart';
import 'widgets/chapter_selector_sheet.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  bool isLoading = true;
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _loadData();
  }

  Future<void> _loadData() async {
    await BibleRepository.loadBible();
    setState(() {
      isLoading = false;
    });
  }

  void _openChapterSelector() {
    if (BibleRepository.allChapters.isEmpty) return;
    
    final currentBook = BibleRepository.allChapters[_currentPageIndex].key;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChapterSelectorSheet(
        initialBook: currentBook,
        onChapterSelected: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (BibleRepository.allChapters.isEmpty) {
      return const Scaffold(body: Center(child: Text('성경 데이터가 없습니다.')));
    }

    final currentEntry = BibleRepository.allChapters[_currentPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _openChapterSelector,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${currentEntry.key} ${currentEntry.value}장'),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemCount: BibleRepository.allChapters.length,
        itemBuilder: (context, index) {
          final entry = BibleRepository.allChapters[index];
          final verses = BibleRepository.getChapterVerses(entry.key, entry.value);
          
          return ListView.separated(
            key: PageStorageKey<String>('${entry.key}_${entry.value}'),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            itemCount: verses.length,
            separatorBuilder: (context, idx) => const SizedBox(height: 20),
            itemBuilder: (context, idx) {
              return VerseWidget(verse: verses[idx]);
            },
          );
        },
      ),
    );
  }
}
