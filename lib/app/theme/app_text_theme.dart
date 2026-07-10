import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  static final TextTheme textTheme = TextTheme(
    displayLarge: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    displayMedium: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    headlineSmall: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleLarge: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      color: AppColors.textPrimary,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      color: AppColors.textSecondary,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      color: AppColors.textSecondary,
    ),
  );
}
