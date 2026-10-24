import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class AppRadioTheme {
  static final lightTheme = RadioThemeData(
    fillColor: WidgetStateColor.resolveWith((states) => AppColors.purple),
  );
}
