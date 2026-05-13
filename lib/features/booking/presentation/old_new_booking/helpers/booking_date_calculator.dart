import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';

/// Centralized date/cooling-period calculations shared by the New Booking and
/// Edit Booking flows. All methods are static and side-effect free.
class BookingDateCalculator {
  /// Returns the effective pickup date used for product-availability checks.
  ///
  /// In "before" cooling mode the reserved window starts [coolingDays] before
  /// the customer's actual pickup date.
  static DateTime effectivePickupDate({
    required DateTime pickupDate,
    required CoolingPeriodMode mode,
    required int coolingDays,
    required bool isBooking,
  }) {
    if (isBooking && mode.isBefore && coolingDays > 0) {
      return pickupDate.subtract(Duration(days: coolingDays));
    }
    return pickupDate;
  }

  /// Returns the effective return date string used for product-availability checks.
  ///
  /// In "after" cooling mode the product is blocked for [coolingDays] after the
  /// customer's actual return date.
  static String effectiveReturnDateStr({
    required DateTime returnDate,
    required CoolingPeriodMode mode,
    required int coolingDays,
    required bool isBooking,
  }) {
    if (isBooking && mode.isAfter) {
      return returnDate.add(Duration(days: coolingDays)).format();
    }
    return returnDate.format();
  }

  /// Returns the UI-visible cooling-period boundary date, or null when
  /// [coolingDays] is zero (no active cooling period).
  static DateTime? coolingPeriodDate({
    required DateTime pickupDate,
    required DateTime returnDate,
    required CoolingPeriodMode mode,
    required int coolingDays,
  }) {
    if (coolingDays <= 0) return null;
    return mode.isAfter
        ? returnDate.add(Duration(days: coolingDays))
        : pickupDate.subtract(Duration(days: coolingDays));
  }
}
