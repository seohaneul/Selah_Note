import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/database/local_db.dart';
import 'core/presentation/home_screen.dart';

// 전역 테마 상태
final ValueNotifier<ThemeData> appThemeNotifier = ValueNotifier(AppTheme.warmSandTheme);

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
    return ValueListenableBuilder<ThemeData>(
      valueListenable: appThemeNotifier,
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'Selah Note',
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}
