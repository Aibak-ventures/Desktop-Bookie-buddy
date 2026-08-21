import 'package:flutter/material.dart';

import '../../../../../utils/extensions/date_time_extensions.dart';
import '../../../../../utils/extensions/string_extensions.dart';
import '../../../domain/entities/booking_details_entity/booking_details_entity.dart';

/// Resolves the pickup/return time actually worth *showing* for a booking —
/// shared by the booking details screen and the printed receipt so both
/// agree on when a time is real versus a placeholder, instead of each
/// re-deriving (and potentially disagreeing on) the same rule.
///
/// Prefers the dedicated `pickupTime`/`returnTime` fields when populated;
/// falls back to the time-of-day baked into `pickupDate`/`returnDate`
/// otherwise — but only when it isn't the sentinel default the backend
/// uses for "no time specified" (00:00 for pickup, 23:59 for return),
/// which would otherwise look like a real recorded time.
extension BookingTimeResolver on BookingDetailsEntity {
  /// Resolves the pickup time if it is actually worth *showing* for a booking
  String? get resolvedPickupTime {
    if (pickupTime.isNotNullOrEmpty) return pickupTime!.formatToUiTime();
    final pickup = pickupDate?.tryParseToDateTime()?.toTimeOfDay;
    if (pickup != null && pickup != const TimeOfDay(hour: 0, minute: 0)) {
      return pickup.formatTime12Hour();
    }
    return null;
  }

  /// Resolves the return time if it is actually worth *showing* for a booking
  String? get resolvedReturnTime {
    if (returnTime.isNotNullOrEmpty) return returnTime!.formatToUiTime();
    final ret = returnDate.tryParseToDateTime()?.toTimeOfDay;
    if (ret != null && ret != const TimeOfDay(hour: 23, minute: 59)) {
      return ret.formatTime12Hour();
    }
    return null;
  }
}
