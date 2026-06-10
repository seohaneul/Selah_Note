import 'package:flutter/material.dart';
import '../../features/bible/presentation/bible_screen.dart';
import '../../features/library/presentation/library_screen.dart';
import '../../features/bible/data/highlight_model.dart';

import '../../features/guide/presentation/today_meditation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<BibleScreenState> _bibleScreenKey = GlobalKey<BibleScreenState>();
  final GlobalKey<LibraryScreenState> _libraryScreenKey = GlobalKey<LibraryScreenState>();

  void _onNavigateToBible(String bookName, int chapter, int verse) {
    setState(() {
      _currentIndex = 0;
    });
    // 약간의 딜레이를 주어 탭 전환 후 성경 화면이 활성화될 시간을 확보합니다.
    Future.delayed(const Duration(milliseconds: 100), () {
      _bibleScreenKey.currentState?.jumpToBibleVerse(bookName, chapter, verse);
    });
  }

  void _onNavigateToLibraryHighlight(HighlightModel highlight) {
    setState(() {
      _currentIndex = 2; // 보관함 탭은 이제 2번 인덱스
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _libraryScreenKey.currentState?.openHighlightDetail(highlight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          BibleScreen(key: _bibleScreenKey, onNavigateToLibraryHighlight: _onNavigateToLibraryHighlight),
          const TodayMeditationScreen(), // 새로 추가된 가이드 화면
          LibraryScreen(key: _libraryScreenKey, onNavigateToBible: _onNavigateToBible),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 2) {
            _libraryScreenKey.currentState?.loadData();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: '성경',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '오늘의 묵상',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: '보관함',
          ),
        ],
      ),
    );
  }
}
