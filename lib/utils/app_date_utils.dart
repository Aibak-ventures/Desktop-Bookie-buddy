import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

class AppDateUtils {
  // --- TODAY ---
  static DateTime today() => DateTime.now().dateOnly;

  // --- THIS WEEK ---
  static DateTime thisWeekStart() {
    final t = today();
    return t.subtract(Duration(days: t.weekday - 1));
  }

  static DateTime thisWeekEnd() => thisWeekStart().add(const Duration(days: 6));

  // --- LAST 7 DAYS ---
  static DateTime last7Days() {
    final t = today();
    // Subtract 6 days to include today in the 7-day range
    return t.subtract(const Duration(days: 6));
  }

  // --- THIS MONTH ---
  static DateTime thisMonthStart() {
    final t = today();
    return DateTime(t.year, t.month); // Implicitly day 1
  }

  static DateTime thisMonthEnd() {
    final t = today();
    return DateTime(t.year, t.month + 1, 0);
  }

  // --- LAST 30 DAYS ---
  static DateTime last30Days() {
    final t = today();
    // Subtract 29 days to include today in the 30-day range
    return t.subtract(const Duration(days: 29));
  }

  // --- LAST MONTH ---
  static DateTime lastMonthStart() {
    final t = today();
    return DateTime(t.year, t.month - 1);
  }

  static DateTime lastMonthEnd() {
    final t = today();
    return DateTime(t.year, t.month, 0);
  }

  // --- THIS QUARTER ---
  /// ### What is a Quarter?
  /// A "quarter" is simply one-fourth of a year. Since a year has 12 months, a quarter consists of exactly 3 months.
  ///
  /// In a standard calendar year, they are broken down like this:
  ///
  /// - Q1: January, February, March (Months 1, 2, 3)
  ///
  /// - Q2: April, May, June (Months 4, 5, 6)
  ///
  /// - Q3: July, August, September (Months 7, 8, 9)
  ///
  /// - Q4: October, November, December (Months 10, 11, 12)
  ///
  /// Calculates the starting month (1, 4, 7, or 10) for any given date's quarter
  static int _getQuarterStartMonth(DateTime date) {
    return ((date.month - 1) ~/ 3) * 3 + 1;
  }

  static DateTime thisQuarterStart() {
    final t = today();

    return DateTime(t.year, _getQuarterStartMonth(t));
  }

  static DateTime thisQuarterEnd() {
    final t = today();
    // Add 3 months to start month, and set day to 0 to get the last day of the quarter
    return DateTime(t.year, _getQuarterStartMonth(t) + 3, 0);
  }

  // --- THIS YEAR ---
  static DateTime thisYearStart() {
    final t = today();
    return DateTime(t.year); // Implicitly month 1, day 1
  }

  static DateTime thisYearEnd() {
    final t = today();
    return DateTime(t.year, 12, 31);
  }

  //

  /// Calculates the time difference in hours between two DateTime objects, optionally considering specific times of day.
  static int timeDifferenceInHours({
    required DateTime fromDate,
    required DateTime toDate,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
  }) {
    if (fromTime != null) {
      fromDate = fromDate.dateOnly.add(
        Duration(hours: fromTime.hour, minutes: fromTime.minute),
      );
    }
    if (toTime != null) {
      toDate = toDate.dateOnly.add(
        Duration(hours: toTime.hour, minutes: toTime.minute),
      );
    }
    return toDate.difference(fromDate).inHours;
  }

  /// Calculates the date difference in days between two DateTime objects, optionally considering specific times of day.
  static int dateDifferenceInDaysUsingTime({
    required DateTime fromDate,
    required DateTime toDate,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
  }) {
    // Combine date + time
    if (fromTime != null) {
      fromDate = fromDate.dateOnly.add(
        Duration(hours: fromTime.hour, minutes: fromTime.minute),
      );
    }

    if (toTime != null) {
      toDate = toDate.dateOnly.add(
        Duration(hours: toTime.hour, minutes: toTime.minute),
      );
    }

    if (!toDate.isAfter(fromDate)) return 0;

    final hours = toDate.difference(fromDate).inMinutes / 60;

    // Ceiling division → booking style day count
    return (hours / 24).ceil();
  }

  static int? calculateDurationInHours({
    required DateTime fromDate,
    required DateTime toDate,
    required TimeOfDay? fromTime,
    required TimeOfDay? toTime,
    bool enforceFullHour = false,
  }) {
    // Require both times
    if (fromTime == null || toTime == null) return null;

    final fromDateTime = DateTime(
      fromDate.year,
      fromDate.month,
      fromDate.day,
      fromTime.hour,
      fromTime.minute,
    );

    final toDateTime = DateTime(
      toDate.year,
      toDate.month,
      toDate.day,
      toTime.hour,
      toTime.minute,
    );

    // Prevent negative duration
    if (!toDateTime.isAfter(fromDateTime)) return 0;

    final totalMinutes = toDateTime.difference(fromDateTime).inMinutes;

    // Optional hourly-rental validation
    if (enforceFullHour && totalMinutes % 60 != 0) {
      return null;
    }

    return totalMinutes ~/ 60;
  }
}
