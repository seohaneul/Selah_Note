import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD9A05B), // Premium gold/orange
        brightness: Brightness.light,
        surface: const Color(0xFFFAFAFA),
        onSurface: const Color(0xFF2C2C2C),
      ),
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF2C2C2C)),
        titleTextStyle: TextStyle(
          color: Color(0xFF2C2C2C),
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 19, 
          height: 1.8, 
          color: Color(0xFF2C2C2C),
          letterSpacing: 0.3,
        ), 
        bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFEBEBEB),
        thickness: 1,
      ),
    );
  }
}
