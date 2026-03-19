import 'package:bookie_buddy_web/core/theme/widgets/app_app_bar_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_checkbox_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_date_picker_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_dialog_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_dropdown_menu_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_elevated_button_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_icon_button_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_outlined_button_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_popup_menu_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_radio_theme.dart';
import 'package:bookie_buddy_web/core/theme/widgets/app_text_button_theme.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const String _fontFamily = 'Inter';

  ///
  static ThemeData lightTheme() => ThemeData(
        // app bar theme
        appBarTheme: AppAppBarTheme.lightTheme,

        // primary color
        primaryColor: Colors.white,

        // app font
        fontFamily: _fontFamily,

        // scaffold background color
        scaffoldBackgroundColor: AppColors.white,

        // checkbox theme
        checkboxTheme: AppCheckboxTheme.lightTheme,

        // text button theme
        textButtonTheme: AppTextButtonTheme.lightTheme,

        // elevated button theme
        elevatedButtonTheme: AppElevatedButtonTheme.lightTheme,

        // outlined button theme
        outlinedButtonTheme: AppOutlinedButtonTheme.lightTheme,

        // icon button theme
        iconButtonTheme: AppIconButtonTheme.lightTheme,

        // popup menu theme
        popupMenuTheme: AppPopupMenuTheme.lightTheme,

        // radio button theme
        radioTheme: AppRadioTheme.lightTheme,

        // date picker theme
        datePickerTheme: AppDatePickerTheme.lightTheme,

        // dropdown menu theme
        dropdownMenuTheme: AppDropdownMenuTheme.lightTheme,

        // dialog theme
        dialogTheme: AppDialogTheme.lightTheme,
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
}
