import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const purple = Color(0xFF5F33E2);
  static const purple600 = Color(0xFF4C28B8);
  static const purpleLight = Color(0xFFE7E4FF);
  static const purpleLightShade = Color(0xFFEDEEFF);
  static const purpleAccent = Color(0xFF8A63FE);
  static const purpleSoft = Color(0xFF6C5CE7);

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
  static const redLightOnDarkBg = Color.fromARGB(255, 255, 137, 131);
  static const green2 = Color(0xFF047500);
  static const green2Light = Color(0xFFD0FFCF);
  static const greenLight = Color(0xFFA7FF8F);

  // Neutrals / Backgrounds
  static const white = Colors.white;
  static const black = Colors.black;
  static const black54 = Colors.black54;
  static const black87 = Colors.black87;
  static final blackShade = Colors.black.withValues(alpha: 0.8);

  static const charcoal = Color(0xFF2D3436);
  static const nearBlack = Color(0xFF2D2D2D);
  static const darkGrey = Color(0xFF3E3E3E);
  static const darkSlate = Color(0xFF1F2937);
  static const offWhite = Color(0xFFF8F9FA);
  static const softGrey = Color(0xFFE9ECEF);

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
    color: Colors.black.withValues(alpha: 0.05),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  // Gradients
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [purple, purple600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
