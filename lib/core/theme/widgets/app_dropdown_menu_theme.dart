import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropdownMenuTheme {
  static final lightTheme = DropdownMenuThemeData(
    textStyle: TextStyle(
      color: AppColors.black,
      fontSize: 16.sp,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColors.purple.lighten(0.2),
      focusedBorder: _borderBuilder()
        ..borderSide.copyWith(color: AppColors.blackShade),
      enabledBorder: _borderBuilder(),
      border: _borderBuilder(),
    ),
    menuStyle: MenuStyle(
      padding:
          WidgetStateProperty.all(const EdgeInsets.all(10)), // 👉 popup padding
      backgroundColor: WidgetStateProperty.all(AppColors.white),
      surfaceTintColor: WidgetStateProperty.all(AppColors.white),
    ),
  );

  static OutlineInputBorder _borderBuilder() {
    return OutlineInputBorder(
      borderRadius: 5.radiusBorder,
      borderSide: BorderSide(
        color: AppColors.grey400,
      ),
    );
  }
}
