import 'package:flutter/material.dart';

class AppColors {
  // ========== PRIMARY BRAND COLOR ==========
  // Main brand purple - standardized across entire app
  static const primary = Color(0xFF8A63FE);
  static const purple = Color(0xFF8A63FE); // Alias for backward compatibility

  // Purple variations
  static const primaryDark = Color(0xFF6132E4);
  static const primaryLight = Color(0xFFEBE4FF);
  static const primaryLightShade = Color(0xFFF6F4FF);
  static const primaryBorder = Color(0xFFE0D9FF);

  // Legacy purple colors (kept for backward compatibility - will be phased out)
  static const purple600 = Color(0xFF4C28B8);
  static const purpleLight = Color(0xFFE7E4FF);
  static const purpleLightShade = Color(0xFFEDEEFF);

  // ========== ACCENT COLORS ==========
  static const yellow = Color(0xFFF2C849);
  static const green = Color(0xFF39A282);
  static const greenSuccess = Color(0xFF27AE60);
  static const greenSuccessLight = Color(0xFFE5FFEA);
  static const gold = Color(0xFFC8A26D);
  static const orangeVivid = Color(0xFFFF9500);
  static const aquamarineMedium = Color(0xFF00C896);

  // ========== ALERT/STATUS COLORS ==========
  static const redTomato = Color(0xFFFF3B30);
  static const red = Color(0xFFC62B2B);
  static const redError = Color(0xFFEB5757);
  static const redLight = Color(0xFFFFD8D8);
  static const green2 = Color(0xFF047500);
  static const green2Light = Color(0xFFD0FFCF);
  static const greenLight = Color(0xFFA7FF8F);

  // ========== NEUTRAL COLORS ==========
  static const white = Colors.white;
  static const black = Colors.black;
  static const black54 = Colors.black54;
  static const black87 = Colors.black87;
  static final blackShade = Colors.black.withValues(alpha: 0.8);

  // Text colors
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF2D2D2D);
  static const textTertiary = Color(0xFF6B6B6B);
  static const textQuaternary = Color(0xFF8C8C8C);

  // Grey scale
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
  static final grey50 = Colors.grey.shade50;

  // ========== BACKGROUND COLORS ==========
  static const background = Color(0xFFF7F8FA);
  static const backgroundLight = Color(0xFFF5F6FA);
  static const backgroundLightest = Color(0xFFF8F9FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceGrey = Color(0xFFF5F5F5);
  static const cardBackground = Color(0xFFFDFDFE);

  // ========== SHADOWS ==========
  static final softShadow = BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  static final lightShadow = BoxShadow(
    color: Colors.black.withOpacity(0.02),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  static final mediumShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  static final primaryShadow = BoxShadow(
    color: Color(0xFF8A63FE).withOpacity(0.3),
    blurRadius: 16,
    offset: const Offset(0, 8),
  );

  // ========== GRADIENTS ==========
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF8A63FE), Color(0xFF6132E4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
