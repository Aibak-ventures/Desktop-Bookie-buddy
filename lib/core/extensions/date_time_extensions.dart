import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension LocalizedDate on DateTime {
  /// Formats the date with a custom or default pattern.
  /// If [reverse] is true, it forces 'yyyy-MM-dd' format.
  String format({String pattern = 'dd-MM-yyyy', bool reverse = false}) =>
      DateFormat(reverse ? 'yyyy-MM-dd' : pattern).format(this);

  /// Formats the time in HH:mm or hh:mm a format.
  /// Default is 12-hour format like '2:00 PM'
  String timeFormat({bool is24Hour = false}) =>
      DateFormat(is24Hour ? 'HH:mm' : 'hh:mm a').format(this);

  /// Formats to 'dd-MM-yyyy HH:mm' or 'dd-MM-yyyy hh:mm a'
  String fullDateTime({bool is24Hour = false}) =>
      DateFormat('dd-MM-yyyy ${is24Hour ? 'HH:mm' : 'hh:mm a'}').format(this);

  // /// Returns the date without time
  // DateTime formatToDate => DateTime(year, month, day);

  /// Smart "time ago" display
  String get timeAgo {
    final duration = DateTime.now().difference(this);
    if (duration.inDays > 1) return '${duration.inDays} days ago';
    if (duration.inHours > 1) return '${duration.inHours} hours ago';
    if (duration.inMinutes > 1) return '${duration.inMinutes} minutes ago';
    return 'Just now';
  }

  /// Smart heading: Today, Yesterday, or full formatted date
  String get smartHeading {
    final today = DateTime.now();
    final yesterday = today.subtract(1.days());

    if (DateUtils.isSameDay(this, today)) return 'Today';
    if (DateUtils.isSameDay(this, yesterday)) return 'Yesterday';

    return DateFormat('dd-MM-yyyy').format(this);
  }

  bool isSameDay(DateTime? other) => DateUtils.isSameDay(this, other);

  /// Returns the date without time
  DateTime get dateOnly => DateTime(year, month, day);

  bool get isDateToday => DateUtils.isSameDay(this, DateTime.now());

  TimeOfDay get toTimeOfDay => TimeOfDay(hour: hour, minute: minute);
}

extension QuickDateFilters on DateTime {
  /// Returns today's date (with only date part)
  DateTime get asToday => dateOnly;

  /// Start of current week (Monday)
  DateTime get weekStart => subtract(Duration(days: weekday - 1)).dateOnly;

  /// End of current week (Sunday)
  DateTime get weekEnd => weekStart.add(const Duration(days: 6)).dateOnly;

  /// Start of current month
  DateTime get monthStart => DateTime(year, month).dateOnly;

  /// End of current month
  DateTime get monthEnd => DateTime(year, month + 1, 0).dateOnly;

  /// 7 days ago
  DateTime get last7Days => subtract(const Duration(days: 7)).dateOnly;

  /// 30 days ago
  DateTime get last30Days => subtract(const Duration(days: 30)).dateOnly;
}

extension TimeX on TimeOfDay {
  /// Formats the [TimeOfDay] as a string based on the given [date] and
  /// [is24Hour] format.
  ///
  /// If [date] is provided, it uses that date; otherwise, it defaults to the
  /// current date.
  ///
  /// Returns the formatted time string in 'HH:mm:ss' format if [is24Hour] is
  /// true, otherwise in 'hh:mm:ss a' format.
  String formatToTime({
    DateTime? date,
    bool is24Hour = true,
    bool addSeconds = false,
  }) {
    final now = date != null ? date : DateTime.now();
    final newDate = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat(
      is24Hour
          ? 'HH:mm${addSeconds ? ':ss' : ''}'
          : 'hh:mm${addSeconds ? ':ss' : ''} a',
    ).format(newDate);
  }

  String formatTime12Hour() {
    final hour = hourOfPeriod == 0 ? 12 : hourOfPeriod;
    final minuteX = minute.toString().padLeft(2, '0');
    final periodX = period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minuteX $periodX';
  }

  // Clears the time by resting the minute to 0
  /// Returns a new TimeOfDay snapped to the nearest 15‑minute block
  /// (00, 15, 30, 45) relative to this time.
  TimeOfDay get clearedTime {
    const quarters = [0, 15, 30, 45];
    int snapped = quarters.first;
    int smallestDiff = 60;

    for (final q in quarters) {
      final diff = (minute + -q).abs();
      if (diff < smallestDiff) {
        smallestDiff = diff;
        snapped = q;
      }
    }

    return TimeOfDay(hour: hour, minute: snapped);
  }
}
