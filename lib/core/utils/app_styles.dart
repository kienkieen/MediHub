import 'package:flutter/material.dart';

class AppStyles {
  // Colors
  static const Color primaryColor = Colors.blue;
  static const Color textDarkColor = Color(0xFF333333);
  static const Color textMediumColor = Color(0xFF7F8C8D);
  static const Color dividerColor = Color(0xFFEEEEEE);
  
  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  static const TextStyle sectionHeaderStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: textDarkColor,
  );
  
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  
  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  
  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16),
    side: const BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}