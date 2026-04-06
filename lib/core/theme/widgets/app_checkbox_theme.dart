import 'package:flutter/material.dart';

class AppCheckboxTheme {
  static final CheckboxThemeData lightTheme = CheckboxThemeData(
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
  );
}
