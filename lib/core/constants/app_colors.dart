import 'package:flutter/material.dart';

class AppColors {
  static const Color oldnavy = Color.fromARGB(255, 11, 1, 40);
  static const Color navy = Color(0xFF004987);
  static const Color oldnavyAccent = Color.fromARGB(255, 16, 2, 62);
  static const Color navyAccent = Color(0xFF006DB2);

  static const Color black = Color(0xFF000000);
  static const Color blackAccent = Color(0xFF333333);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF0000);
  static const Color orange = Color.fromARGB(255, 255, 94, 0);
  static const Color green = Color(0xFF00AA00);
  static const Color yellow = Color.fromARGB(255, 232, 247, 74);

  static const Color redAccent = Color.fromARGB(255, 255, 52, 72);

  static const Color grey = Color(0xFFD1D1D1);
  static const Color greyAccent = Color(0xFFF4F4F4);

  static const Color darkGray = Color.fromARGB(255, 183, 183, 183);
  static const Color borderGray = Color(0xFF707070);

  static const Color textGrey = Color(0xFFA89E9E);

  static const Color transparent = Colors.transparent;

  static MaterialColor _createMaterialColor(Color color) {
    Map<int, Color> swatch = {
      50: color.withValues(alpha: 0.05),
      100: color.withValues(alpha: 0.1),
      200: color.withValues(alpha: 0.2),
      300: color.withValues(alpha: 0.3),
      400: color.withValues(alpha: 0.4),
      500: color.withValues(alpha: 0.5),
      600: color.withValues(alpha: 0.6),
      700: color.withValues(alpha: 0.7),
      800: color.withValues(alpha: 0.8),
      900: color.withValues(alpha: 0.9),
    };
    return MaterialColor(color.toARGB32(), swatch);
  }

  static final MaterialColor lightMaterialColor = _createMaterialColor(black);
  static final MaterialColor darkMaterialColor = _createMaterialColor(white);
}
