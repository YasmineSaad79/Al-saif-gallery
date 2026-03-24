import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Color(0xFF5AAAF9),
        cursorColor: Color(0xFF1976D2),
        selectionHandleColor: Color(0xFF1976D2),
      ),
      useMaterial3: true,
    );
  }
}




