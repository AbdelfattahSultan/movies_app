import 'package:flutter/material.dart';
import 'package:movies_app/core/config/app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0XFF121312),
  );
}
