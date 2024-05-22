import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF075BA9);
  static Color grey = const Color(0xffE0E0E0);
  static const Color black = Color(0xFF171616);
  static const Color white = Color(0xFFF5F5F5);
  static LinearGradient gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff1788EF),
      primaryColor,
    ],
  );
  static LinearGradient disableGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xff1788EF).withOpacity(0.5),
      primaryColor.withOpacity(0.5),
    ],
  );
}
