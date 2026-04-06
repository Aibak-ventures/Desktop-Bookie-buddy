import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButtonTheme {
  static final lightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: 5.radiusBorder,
        side: BorderSide.none,
      ),
      textStyle: TextStyle(
        color: AppColors.white,
        fontSize: 14.sp,
      ),
      iconColor: AppColors.white,
    ),
  );
}
