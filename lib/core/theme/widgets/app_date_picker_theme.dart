import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDatePickerTheme {
  static final lightTheme = DatePickerThemeData(
    backgroundColor: AppColors.white, // White background

    dayForegroundColor: WidgetStateColor.resolveWith(
      (states) {
        // Selected date text color
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        } else if (states.contains(WidgetState.disabled)) {
          return AppColors.grey;
        }
        // Default day text color
        return AppColors.black;
      },
    ),

    dayBackgroundColor: WidgetStateColor.resolveWith(
      (states) {
        // Selected date background color
        if (states.contains(WidgetState.selected)) {
          return AppColors.purple;
        }
        return Colors.transparent; // Normal days no background
      },
    ),

    todayForegroundColor: WidgetStateColor.resolveWith(
      (states) {
        return AppColors.purple; // Today text color
      },
    ),

    todayBackgroundColor: WidgetStateColor.resolveWith(
      (states) {
        return AppColors.purple
            .withValues(alpha: 0.15); // Today circle light purple
      },
    ),

    headerForegroundColor: AppColors.black, // Header text color

    // Action button colors (OK/Cancel)
    rangeSelectionBackgroundColor: AppColors.purple.withValues(alpha: 0.1),
    rangeSelectionOverlayColor: WidgetStateColor.resolveWith(
      (_) => AppColors.purple.withValues(alpha: 0.2),
    ),

    // Optional: You can also customize the year picker colors
  );
}
