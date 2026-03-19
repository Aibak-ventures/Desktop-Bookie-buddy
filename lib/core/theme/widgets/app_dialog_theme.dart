import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialogTheme {
  static final lightTheme = DialogThemeData(
    backgroundColor: AppColors.white,
    titleTextStyle: TextStyle(
      fontSize: 20.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w400,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16.sp,
      color: AppColors.black54,
    ),
  );
}
