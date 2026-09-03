import 'package:bookie_buddy_shared/core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// Color is a Flutter type, doesn't belong in the pure-Dart shared package
// (see bookie_buddy_ui's theme/status_ui_extensions.dart for the same
// split on mobile's side) — kept here with web's own exact values
// (`cancelled` uses Colors.red, not mobile's AppColors.redTomato — a real,
// pre-existing difference, preserved rather than silently unified).
extension DeliveryStatusColorX on DeliveryStatus {
  Color get color => switch (this) {
    DeliveryStatus.booked => AppColors.orangeVivid,
    DeliveryStatus.readyToDeliver => AppColors.aquamarineMedium,
    DeliveryStatus.delivered => const Color.fromARGB(255, 0, 149, 255),
    DeliveryStatus.returned => AppColors.purple,
    DeliveryStatus.cancelled => Colors.red,
  };
}
