import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

class AppPopupMenuTheme {
  static final lightTheme = PopupMenuThemeData(
    color: AppColors.white,
    elevation: 1.5,
    shape: RoundedRectangleBorder(
      borderRadius: 5.radiusBorder,
    ),
  );
}
