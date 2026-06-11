import 'package:flutter/material.dart';

class AppTheme {
  // 1. ☕ 웜 샌드 (Warm Sand)
  static ThemeData get warmSandTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD9A05B), // 따뜻한 골드/오렌지
        brightness: Brightness.light,
        surface: const Color(0xFFFAF8F5),   // 연한 베이지 바탕
        onSurface: const Color(0xFF3E2723), // 딥 브라운 텍스트
        primary: const Color(0xFFD9A05B),
      ),
      scaffoldBackgroundColor: const Color(0xFFFAF8F5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF3E2723)),
        titleTextStyle: TextStyle(
          color: Color(0xFF3E2723),
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 19, height: 1.8, color: Color(0xFF3E2723), letterSpacing: 0.3), 
        bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF5D4037)),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFEBEBEB), thickness: 1),
    );
  }

  // 2. 🌌 미드나이트 네이비 (Midnight Navy)
  static ThemeData get midnightNavyTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD4AF37), // 골드 포인트
        brightness: Brightness.light,
        surface: const Color(0xFFF8F9FA),   // 스노우 화이트
        onSurface: const Color(0xFF1A365D), // 네이비 블루 텍스트
        primary: const Color(0xFF2C3E50),   // 깊은 네이비
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF1A365D)),
        titleTextStyle: TextStyle(
          color: Color(0xFF1A365D),
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 19, height: 1.8, color: Color(0xFF1A365D), letterSpacing: 0.3), 
        bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFE0E0E0), thickness: 1),
    );
  }

  // 3. 🌿 세이지 그린 (Sage Green)
  static ThemeData get sageGreenTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6B8E23), // 세이지 그린
        brightness: Brightness.light,
        surface: const Color(0xFFF9FBF9),   // 오프 화이트
        onSurface: const Color(0xFF2E3B22), // 짙은 녹색 텍스트
        primary: const Color(0xFF6B8E23),
      ),
      scaffoldBackgroundColor: const Color(0xFFF9FBF9),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF2E3B22)),
        titleTextStyle: TextStyle(
          color: Color(0xFF2E3B22),
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 19, height: 1.8, color: Color(0xFF2E3B22), letterSpacing: 0.3), 
        bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF4A5D23)),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFE8ECE8), thickness: 1),
    );
  }
}

