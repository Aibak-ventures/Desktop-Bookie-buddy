import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAppBarTheme {
  static final lightTheme = AppBarTheme(
    actionsPadding: 20.paddingOnly(right: true),
    backgroundColor: AppColors.white,
    centerTitle: false,
    surfaceTintColor: AppColors.white,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      fontSize: 22.sp,
      color: AppColors.black,
    ),
  );
}
