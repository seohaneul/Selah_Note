import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/bible/presentation/bible_screen.dart';
import 'core/database/local_db.dart';

void main() async {
  // DB 등 비동기 초기화를 위해 Flutter 엔진 바인딩
  WidgetsFlutterBinding.ensureInitialized();
  
  // 로컬 데이터베이스(Isar 등) 초기화
  await LocalDb.initialize();

  runApp(const SelahNoteApp());
}

class SelahNoteApp extends StatelessWidget {
  const SelahNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selah Note',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // 앱의 첫 화면을 성경 본문 뷰어로 설정
      home: const BibleScreen(),
    );
  }
}
