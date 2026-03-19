import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppRadioTheme {
  static final lightTheme = RadioThemeData(
    fillColor: WidgetStateColor.resolveWith(
      (states) => AppColors.purple,
    ),
  );
}
