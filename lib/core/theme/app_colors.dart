import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const purple = Color(0xFF5F33E2);
  static const purple600 = Color(0xFF4C28B8);
  static const purpleLight = Color(0xFFE7E4FF);
  static const purpleLightShade = Color(0xFFEDEEFF);

  // Accent colors
  static const yellow = Color(0xFFF2C849);
  static const green = Color(0xFF39A282);
  static const gold = Color(0xFFC8A26D);
  static const orangeVivid = Color(0xFFFF9500);
  static const aquamarineMedium = Color(0xFF00C896);

  // Alert colors
  static const redTomato = Color(0xFFFF3B30);
  static const red = Color(0xFFC62B2B);
  static const redLight = Color(0xFFFFD8D8);
  static const green2 = Color(0xFF047500);
  static const green2Light = Color(0xFFD0FFCF);
  static const greenLight = Color(0xFFA7FF8F);

  // Neutrals / Backgrounds
  static const white = Colors.white;
  static const black = Colors.black;
  static const black54 = Colors.black54;
  static final blackShade = Colors.black.withValues(alpha: 0.8);

  static const grey = Color(0xFF9E9E9E);
  static const greyBorder = Color(0xFFF0F0F0);
  static final grey800 = Colors.grey.shade800;
  static final grey700 = Colors.grey.shade700;
  static final grey600 = Colors.grey.shade600;
  static final grey500 = Colors.grey.shade500;
  static final grey400 = Colors.grey.shade400;
  static final grey300 = Colors.grey.shade300;
  static final grey200 = Colors.grey.shade200;
  static final grey100 = Colors.grey.shade100;

  // Background layers for dashboard sections
  static const background = Color(0xFFF7F8FA);
  static const surface = Color(0xFFFFFFFF);
  static const cardBackground = Color(0xFFFDFDFE);

  // Shadows
  static final softShadow = BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  // Gradients
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF5F33E2), Color(0xFF4C28B8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
