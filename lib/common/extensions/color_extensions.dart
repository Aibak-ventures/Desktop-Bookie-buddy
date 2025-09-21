import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Lighten a color by [amount] (between 0.0 and 1.0)
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0.0 and 1.0');
    
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    
    return hslLight.toColor();
  }

  /// Darken a color by [amount] (between 0.0 and 1.0)
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0.0 and 1.0');
    
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    
    return hslDark.toColor();
  }

  /// Get the hex string representation of the color
  String toHex() {
    return '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  /// Create a MaterialColor from this color
  MaterialColor toMaterialColor() {
    final int red = this.red;
    final int green = this.green;
    final int blue = this.blue;
    
    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };
    
    return MaterialColor(value, shades);
  }
}
