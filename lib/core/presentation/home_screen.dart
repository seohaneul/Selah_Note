import 'package:flutter/material.dart';
import '../../features/bible/presentation/bible_screen.dart';
import '../../features/library/presentation/library_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<BibleScreenState> _bibleScreenKey = GlobalKey<BibleScreenState>();

  void _onNavigateToBible(String bookName, int chapter, int verse) {
    setState(() {
      _currentIndex = 0;
    });
    // 약간의 딜레이를 주어 탭 전환 후 성경 화면이 활성화될 시간을 확보합니다.
    Future.delayed(const Duration(milliseconds: 100), () {
      _bibleScreenKey.currentState?.jumpToBibleVerse(bookName, chapter, verse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          BibleScreen(key: _bibleScreenKey),
          LibraryScreen(onNavigateToBible: _onNavigateToBible),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: '성경',
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
