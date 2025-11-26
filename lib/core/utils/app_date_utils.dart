import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';

class AppDateUtils {
  /// Returns the short name of the month given by [month].
  ///
  /// The month is 1-indexed, i.e. January is 1, February is 2, and so on.
  ///
  /// If [month] is 0 or negative, returns 'Jan'.
  /// If [month] is 13 or greater, returns 'Dec'.
  ///
  static String getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    if (month > 12) return months.last;
    if (month < 1) return months.first;
    return months[month - 1];
  }

  static DateTime today() => DateTime.now().dateOnly;

  static DateTime weekStart() => DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1))
      .dateOnly;

  static DateTime weekEnd() =>
      weekStart().add(const Duration(days: 6)).dateOnly;

  static DateTime monthStart() =>
      DateTime(DateTime.now().year, DateTime.now().month).dateOnly;

  static DateTime monthEnd() =>
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0).dateOnly;

  static DateTime last7Days() =>
      DateTime.now().subtract(const Duration(days: 7)).dateOnly;

  static DateTime last30Days() =>
      DateTime.now().subtract(const Duration(days: 30)).dateOnly;
}
