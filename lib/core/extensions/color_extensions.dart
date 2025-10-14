import 'package:flutter/material.dart';

extension ColorX on Color {
  /// Lightens the color by a specified [amount].
  ///
  /// The [amount] should be a value between 0 and 1, where
  ///
  /// `0.0` = same color, `1.0` = pure white
  ///
  /// Returns a new [Color] that is a linear interpolation between this color
  /// and white.
  Color lighten([double amount = 0.7]) => Color.lerp(this, Colors.white, amount)!;
}
