import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckboxTheme {
  static final CheckboxThemeData lightTheme = CheckboxThemeData(
    overlayColor: WidgetStateColor.resolveWith((states) => Colors.white),
    fillColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.purpleAccent
          : Colors.white,
    ),
    side: const BorderSide(color: AppColors.purpleAccent, width: 2),
  );
}
