import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color accentColor = Color(0xFF20C997);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.large,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.title,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.large,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.medium,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.body,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: Color(0xFF16213E),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFFE0E0E0),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF16213E),
        foregroundColor: Color(0xFFE0E0E0),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.large,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE0E0E0),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.title,
          fontWeight: FontWeight.w700,
          color: Color(0xFFE0E0E0),
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.large,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE0E0E0),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.medium,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE0E0E0),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: AppFontSizes.body,
          fontWeight: FontWeight.w400,
          color: Color(0xFFB0B0B0),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small,
        ),
      ),
    );
  }
}
