import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const String _fontFamily = 'Inter';

  ///
  static ThemeData lightTheme() => ThemeData(
        // app bar theme
        appBarTheme: AppBarTheme(
          actionsPadding: 20.paddingOnly(right: true),
          color: AppColors.white,
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
        ),
        primaryColor: Colors.white,

        // app font
        fontFamily: _fontFamily,

        // scaffold background color
        scaffoldBackgroundColor: AppColors.white,

        // checkbox theme
        checkboxTheme: CheckboxThemeData(
          overlayColor: WidgetStateColor.resolveWith(
            (states) => Colors.white,
          ),
          fillColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? const Color(0xFF8A63FE)
                : Colors.white,
          ),
          side: const BorderSide(
            color: Color(0xFF8A63FE),
            width: 2,
          ),
        ),

        // text button theme
        textButtonTheme: TextButtonThemeData(
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
        ),

        // elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
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
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: 5.radiusBorder,
              side: BorderSide.none,
            ),
            textStyle: TextStyle(
              color: AppColors.purple,
              fontSize: 14.sp,
            ),
            iconColor: AppColors.purple,
          ),
        ),

        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: 5.radiusBorder,
              // side: BorderSide.none,
            ),
          ),
        ),
        // menuButtonTheme: MenuButtonThemeData(
        //   style: ButtonStyle(

        //   ),
        // ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.white,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: 5.radiusBorder,
          ),
        ),

        // radio button theme
        radioTheme: RadioThemeData(
          fillColor: WidgetStateColor.resolveWith(
            (states) => AppColors.purple,
          ),
        ),
        datePickerTheme: DatePickerThemeData(
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
          rangeSelectionBackgroundColor:
              AppColors.purple.withValues(alpha: 0.1),
          rangeSelectionOverlayColor: WidgetStateColor.resolveWith(
            (_) => AppColors.purple.withValues(alpha: 0.2),
          ),

          // Optional: You can also customize the year picker colors
        ),

        // dropdown menu theme
        dropdownMenuTheme: DropdownMenuThemeData(
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
            padding: WidgetStateProperty.all(
                const EdgeInsets.all(10)), // 👉 popup padding
            backgroundColor: WidgetStateProperty.all(AppColors.white),
            surfaceTintColor: WidgetStateProperty.all(AppColors.white),
          ),
        ),

        // dialog theme
        dialogTheme: DialogThemeData(
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
        ),
      );

  //Dark Theme is not complete
  static const _darkColor = Color.fromARGB(255, 48, 47, 47);

  ///
  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: _darkColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    primaryColor: _darkColor,
    fontFamily: _fontFamily,
    scaffoldBackgroundColor: _darkColor,
  );

  //--------- Helper methods ---------//

  static OutlineInputBorder _borderBuilder() {
    return OutlineInputBorder(
      borderRadius: 5.radiusBorder,
      borderSide: BorderSide(
        color: AppColors.grey400,
      ),
    );
  }
}
