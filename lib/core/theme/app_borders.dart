import 'package:flutter/material.dart';

class AppBorders {
  // ---------------------------------------------------------------------------
  // Radius values — semantic names based on actual web UI usage
  // ---------------------------------------------------------------------------

  /// Text fields and compact inline elements
  static const double inputRadius = 4.0;

  /// Small elements — quantity buttons, image thumbnails, small badges
  static const double smallRadius = 6.0;

  /// Form inputs, toggle buttons, action buttons, chips
  static const double buttonRadius = 8.0;

  /// Section containers, detail panels, drawer blocks, form cards
  static const double containerRadius = 12.0;

  /// Primary cards — dashboard overview cards, main content cards
  static const double cardRadius = 16.0;

  /// Pills — fully rounded chips or avatar containers
  static const double pillRadius = 100.0;

  // ---------------------------------------------------------------------------
  // Ready-to-use BorderRadius constants
  // ---------------------------------------------------------------------------

  /// For text fields
  static const BorderRadius inputBorderRadius = BorderRadius.all(Radius.circular(inputRadius));

  /// For small elements (thumbnails, quantity controls)
  static const BorderRadius smallBorderRadius = BorderRadius.all(Radius.circular(smallRadius));

  /// For buttons and chips
  static const BorderRadius buttonBorderRadius = BorderRadius.all(Radius.circular(buttonRadius));

  /// For section containers and panels
  static const BorderRadius containerBorderRadius = BorderRadius.all(Radius.circular(containerRadius));

  /// For primary cards
  static const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(cardRadius));

  /// Top-only rounded — for bottom sheets or stacked cards
  static const BorderRadius topRoundedBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(containerRadius),
    topRight: Radius.circular(containerRadius),
  );
}
