import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0XFFC7E2FF);
  static const Color backgroundColor = Color(0XFFFFFAFA);
  static const Color textColor = Colors.black87;
  static const Color hintTextColor = Colors.black54;
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle hintText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 14,
    color: AppColors.hintTextColor,
    fontStyle: FontStyle.italic,
  );
}
