import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.blue;
  static const Color secondary = Color(0xFF4ECDC4);
  static const Color background = Color(0xFFE6F1F8);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF2E4053);
  static const Color textSecondary = Color(0xFF566573);
  static const Color rating = Colors.orange;
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF2E85CC), Color(0xFF2F8CD8), Color(0xA706B8D7)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double borderRadius = 12.0;
}
