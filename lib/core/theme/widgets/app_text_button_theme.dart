import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButtonTheme {
  static final TextButtonThemeData lightTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: 5.radiusBorder,
      ),
      iconColor: AppColors.purple,
      textStyle: TextStyle(
        color: AppColors.purple,
        fontSize: 14.sp,
      ),
    ),
  );
}
