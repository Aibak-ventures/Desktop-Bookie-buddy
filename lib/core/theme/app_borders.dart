import 'package:flutter/material.dart';

class AppBorders {
  // Radius for individual corners
  static const double radius5 = 5.0;
  static const double radius9 = 9.0;
  static const double radius20 = 20.0;

  // Full BorderRadius constants for reuse
  static const BorderRadius smallBorderRadius = BorderRadius.all(
    Radius.circular(radius5),
  );

  static const BorderRadius mediumBorderRadius = BorderRadius.all(
    Radius.circular(radius9),
  );

  static const BorderRadius largeBorderRadius = BorderRadius.all(
    Radius.circular(radius20),
  );

  // More complex border radius for specific corners
  static const BorderRadius topRounded = BorderRadius.only(
    topLeft: Radius.circular(radius9),
    topRight: Radius.circular(radius9),
  );
}
