import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

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
    final base = (isBooking && mode.isBefore && coolingDays > 0)
        ? pickupDate.subtract(Duration(days: coolingDays))
        : pickupDate;
    // Availability can only be evaluated from today onward, so a past pickup
    // date is clamped to today for the check. The real (possibly back-dated)
    // pickup date is still sent in the booking payload itself.
    return isBooking ? clampToTodayForAvailability(base) : base;
  }

  /// Returns the pickup time to use for availability/search checks.
  ///
  /// [pickupTime] only describes the customer's actual pickup instant — once
  /// [effectivePickupDate] has shifted the date away from that (cooling
  /// "before" offset, or clamped to today because it fell in the past),
  /// attaching that clock time to the shifted date is meaningless. In that
  /// case this returns null so the check defaults to start-of-day instead.
  ///
  /// Deliberately does NOT compare the final (shifted-then-clamped) date
  /// back to [pickupDate] — a shift and a clamp can cancel out and land
  /// back on the same calendar day (e.g. pickup is today and the "before"
  /// offset pushes into the past, which then clamps back to today), which
  /// would falsely look like "no adjustment happened" despite one occurring.
  /// Instead this checks each adjustment directly.
  static TimeOfDay? effectivePickupTime({
    required DateTime pickupDate,
    required TimeOfDay? pickupTime,
    required CoolingPeriodMode mode,
    required int coolingDays,
    required bool isBooking,
  }) {
    if (!isBooking) return pickupTime;
    final hasCoolingShift = mode.isBefore && coolingDays > 0;
    if (hasCoolingShift) return null;
    final today = DateTime.now().dateOnly;
    final wasClamped = pickupDate.dateOnly.isBefore(today);
    return wasClamped ? null : pickupTime;
  }

  /// Clamps a past [date] to today for availability checks. Future dates are
  /// returned unchanged. The original date is still used in the booking payload.
  static DateTime clampToTodayForAvailability(DateTime date) {
    final today = DateTime.now().dateOnly;
    return date.dateOnly.isBefore(today) ? today : date;
  }

  /// String form of [effectivePickupDate], mirroring [effectiveReturnDateStr].
  static String effectivePickupDateStr({
    required DateTime pickupDate,
    required CoolingPeriodMode mode,
    required int coolingDays,
    required bool isBooking,
  }) => effectivePickupDate(
        pickupDate: pickupDate,
        mode: mode,
        coolingDays: coolingDays,
        isBooking: isBooking,
      ).format();

  /// Returns the effective return date used for product-availability checks.
  ///
  /// In "after" cooling mode the product is blocked for [coolingDays] after the
  /// customer's actual return date.
  static DateTime effectiveReturnDate({
    required DateTime returnDate,
    required CoolingPeriodMode mode,
    required int coolingDays,
    required bool isBooking,
  }) {
    return (isBooking && mode.isAfter)
        ? returnDate.add(Duration(days: coolingDays))
        : returnDate;
  }

  /// String form of [effectiveReturnDate].
  static String effectiveReturnDateStr({
    required DateTime returnDate,
    required CoolingPeriodMode mode,
    required int coolingDays,
    required bool isBooking,
  }) => effectiveReturnDate(
        returnDate: returnDate,
        mode: mode,
        coolingDays: coolingDays,
        isBooking: isBooking,
      ).format();

  /// Returns the return time to use for availability/search checks.
  ///
  /// [returnTime] only describes the customer's actual return instant — once
  /// [effectiveReturnDate] has shifted the date away from that (cooling
  /// "after" offset), attaching that clock time to the shifted date is
  /// meaningless. In that case this returns null so the check defaults to
  /// end-of-day instead.
  static TimeOfDay? effectiveReturnTime({
    required DateTime returnDate,
    required TimeOfDay? returnTime,
    required CoolingPeriodMode mode,
    required int coolingDays,
    required bool isBooking,
  }) {
    final effectiveDate = effectiveReturnDate(
      returnDate: returnDate,
      mode: mode,
      coolingDays: coolingDays,
      isBooking: isBooking,
    );
    return effectiveDate.dateOnly == returnDate.dateOnly ? returnTime : null;
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

  /// Inverse of [coolingPeriodDate]: derives the number of cooling days from
  /// a previously-stored cooling boundary date. Used when re-hydrating an
  /// existing booking (the API returns only the boundary date, not the day
  /// count).
  static int coolingPeriodDaysFromDate({
    required DateTime pickupDate,
    required DateTime returnDate,
    required DateTime coolingDate,
    required CoolingPeriodMode mode,
  }) {
    return mode.isBefore
        ? pickupDate.difference(coolingDate).inDays.abs()
        : coolingDate.difference(returnDate).inDays.abs();
  }
}
