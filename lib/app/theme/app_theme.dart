import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      surfaceContainerHighest: AppColors.scaffoldBackground,
    ),
    textTheme: AppTextTheme.textTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.primary,
    ),
    textTheme: AppTextTheme.textTheme,
  );
}
