import 'package:flutter/material.dart';
import '../data/bible_repository.dart';
import '../data/bible_model.dart';
import 'widgets/verse_widget.dart';
import 'widgets/chapter_selector_sheet.dart';

import '../data/highlight_model.dart';
import '../../../main.dart';
import '../../../core/theme/app_theme.dart';

class BibleScreen extends StatefulWidget {
  final Function(HighlightModel)? onNavigateToLibraryHighlight;

  const BibleScreen({Key? key, this.onNavigateToLibraryHighlight}) : super(key: key);

  @override
  State<BibleScreen> createState() => BibleScreenState();
}

class BibleScreenState extends State<BibleScreen> {
  bool isLoading = true;
  int _currentPageIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _verseKeys = {};

  void jumpToBibleVerse(String bookName, int chapter, int verse) {
    final targetIndex = BibleRepository.allChapters.indexWhere(
      (entry) => (entry.key == bookName || BibleRepository.getFullName(entry.key) == bookName) 
                 && entry.value == chapter
    );
    if (targetIndex != -1) {
      setState(() {
        _currentPageIndex = targetIndex;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToVerse(verse);
      });
    }
  }


  @override
  void initState() {
    super.initState();
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
        onVerseSelected: (index, verse) {
          setState(() {
            _currentPageIndex = index;
          });
          
          // 새 장이 렌더링된 후 해당 절로 스크롤
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToVerse(verse);
          });
        },
      ),
    );
  }

  void _scrollToVerse(int verse) {
    final key = _verseKeys[verse];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.1, // 약간 위쪽으로 여유를 줌
      );
    }
  }

  void _goToNextChapter() {
    if (_currentPageIndex < BibleRepository.allChapters.length - 1) {
      setState(() {
        _currentPageIndex++;
        // 스와이프 시 항상 맨 위로
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(0);
          }
        });
      });
    }
  }

  void _goToPrevChapter() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(0);
          }
        });
      });
    }
  }

  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('앱 테마(색감) 변경', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Color(0xFFD9A05B), radius: 16),
                title: const Text('웜 샌드 (Warm Sand)'),
                onTap: () {
                  appThemeNotifier.value = AppTheme.warmSandTheme;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Color(0xFF1A365D), radius: 16),
                title: const Text('미드나이트 네이비 (Midnight Navy)'),
                onTap: () {
                  appThemeNotifier.value = AppTheme.midnightNavyTheme;
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Color(0xFF6B8E23), radius: 16),
                title: const Text('세이지 그린 (Sage Green)'),
                onTap: () {
                  appThemeNotifier.value = AppTheme.sageGreenTheme;
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
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
    final verses = BibleRepository.getChapterVerses(currentEntry.key, currentEntry.value);

    // 각 절마다 고유한 GlobalKey 생성 (스크롤 점프용)
    _verseKeys.clear();
    for (var v in verses) {
      _verseKeys[v.verse] = GlobalKey();
    }

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _openChapterSelector,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${BibleRepository.getFullName(currentEntry.key)} ${currentEntry.value}장'),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: _showThemeSelector,
            tooltip: '테마 변경',
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < -300) {
              // 왼쪽으로 스와이프 (다음 장)
              _goToNextChapter();
            } else if (details.primaryVelocity! > 300) {
              // 오른쪽으로 스와이프 (이전 장)
              _goToPrevChapter();
            }
          }
        },
        child: Container(
          color: Colors.transparent, // GestureDetector가 빈 공간의 터치도 감지하게 함
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: verses.map((verse) {
                return Padding(
                  key: _verseKeys[verse.verse],
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: VerseWidget(
                    verse: verse,
                    onHighlightTap: widget.onNavigateToLibraryHighlight,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
