import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateFormatExtension on String {
  /// Parses any valid date string and auto handles both `yyyy-MM-dd` and `dd-MM-yyyy`.
  DateTime parseToDateTime() {
    final cleaned = trim();

    final formats = [
      'yyyy-MM-dd HH:mm:ss',
      'dd-MM-yyyy HH:mm:ss',
      'yyyy-MM-dd',
      'dd-MM-yyyy',
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parseStrict(cleaned);
      } catch (_) {
        // continue to next format
      }
    }

    try {
      return DateTime.parse(this); // ISO or other valid format
    } catch (_) {}

    throw FormatException('Unrecognized date/time format: $this');
  }

  TimeOfDay toTimeOfDay() {
    try {
      // Expecting format: HH:mm or HH:mm:ss
      final parsed = DateFormat.Hms().parse(this); // Handles HH:mm:ss
      return TimeOfDay(hour: parsed.hour, minute: parsed.minute);
    } catch (_) {
      try {
        final parsed = DateFormat.Hm().parse(this); // Handles HH:mm
        return TimeOfDay(hour: parsed.hour, minute: parsed.minute);
      } catch (_) {
        throw FormatException('Invalid time format: $this');
      }
    }
  }

  TimeOfDay to24HourTimeOfDayFrom12Format() {
    try {
      // Parses 12-hour format like "12:00 AM", "1:30 PM"
      final parsed = DateFormat('hh:mm a').parse(this);
      return TimeOfDay(hour: parsed.hour, minute: parsed.minute);
    } catch (_) {
      throw FormatException('Invalid 12-hour time format: $this');
    }
  }

  /// Always formats to 'dd-MM-yyyy' for UI
  String formatToUiDate() {
    return DateFormat('dd-MM-yyyy').format(parseToDateTime());
  }

  /// Extracts and formats time if needed (supports both 24hr and 12hr)
  String formatToUiTime({bool is24Hour = false}) {
    try {
      // Try format: dd-MM-yyyy hh:mm a (12-hour with AM/PM)
      return DateFormat(is24Hour ? 'HH:mm' : 'hh:mm a').format(
        DateFormat('dd-MM-yyyy hh:mm a').parse(this),
      );
    } catch (_) {
      try {
        // Try format: dd-MM-yyyy HH:mm:ss (24-hour with seconds)
        return DateFormat(is24Hour ? 'HH:mm' : 'hh:mm a').format(
          DateFormat('dd-MM-yyyy HH:mm:ss').parse(this),
        );
      } catch (_) {
        try {
          // Try format: yyyy-MM-dd HH:mm:ss (if your backend ever sends this)
          return DateFormat(is24Hour ? 'HH:mm' : 'hh:mm a').format(
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(this),
          );
        } catch (_) {
          // Fallback
          final dateTime = DateTime.tryParse(this) ?? DateTime.now();
          return DateFormat(is24Hour ? 'HH:mm' : 'hh:mm a').format(dateTime);
        }
      }
    }
  }

  /// Checks if the date is today.
  ///
  /// Returns `true` if the date is today.
  /// Returns `false` if the date is not today
  bool get isDateToday {
    try {
      final today = DateTime.now();
      final given = parseToDateTime();
      return DateUtils.isSameDay(given, today);
    } catch (e, stack) {
      throw FormatException(
        'Unrecognized date format: $this',
        stack,
      );
    }
  }

  /// Checks if the date is yesterday.
  ///
  /// Returns `true` if the date is yesterday.
  /// Returns `false` if the date is not yesterday
  bool get isDateYesterday {
    try {
      final today = DateTime.now();
      final given = parseToDateTime();
      return DateUtils.isSameDay(given, today.subtract(1.days()));
    } catch (e, stack) {
      throw FormatException(
        'Unrecognized date format: $this',
        stack,
      );
    }
  }

  /// Checks if the date is tomorrow.
  ///
  /// Returns `true` if the date is tomorrow.
  /// Returns `false` if the date is not tomorrow
  bool get isDateTomorrow {
    try {
      final today = DateTime.now();
      final given = parseToDateTime();
      return DateUtils.isSameDay(given, today.add(1.days()));
    } catch (e, stack) {
      throw FormatException(
        'Unrecognized date format: $this',
        stack,
      );
    }
  }

  /// Formats to full Date + Time if needed
  String formatToUiDateTime({bool is24Hour = true}) {
    final dateTime = DateTime.tryParse(this) ?? parseToDateTime();
    return DateFormat('dd-MM-yyyy ${is24Hour ? 'HH:mm' : 'hh:mm a'}')
        .format(dateTime);
  }

  // Optional: Smart heading like Today, Yesterday, or Full Date
  String getDateHeading() {
    final today = DateTime.now();
    final given = parseToDateTime();

    if (DateUtils.isSameDay(given, today)) {
      return "Today";
    } else if (DateUtils.isSameDay(given, today.subtract(1.days()))) {
      return "Yesterday";
    } else {
      return DateFormat.yMMMMd().format(given); // eg: April 21, 2025
    }
  }
}

extension StringX on String {
  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      debugPrint('Tried to parse $this as int, but failed: $e');
      debugPrint('Falling back to double parsing..., then to int');
      try {
        return double.parse(this).toInt();
      } catch (e2) {
        debugPrint('double.parse also failed for "$this": $e2');
        rethrow; // or throw again
      }
    }
  }

  double toDouble() => double.parse(this);

  int? toIntOrNull() {
    try {
      return toInt();
    } catch (e) {
      debugPrint('Failed to parse $this as int: $e, returning null');
      return null;
    }
  }

  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

extension NumberFieldChangeValidator on String? {
  bool hasNumberChangedComparedTo(String newValue) {
    final oldVal = this?.trim();
    final newVal = newValue.trim();

    if (newVal.isEmpty) return false;
    if (oldVal == null || oldVal.isEmpty || oldVal == 'null') return true;

    final oldNumber = int.tryParse(oldVal);
    final newNumber = int.tryParse(newVal);

    if (oldNumber == null || newNumber == null) return false;

    return oldNumber != newNumber;
  }
}

// extension StringX on String {
//   /// Converts this [String] into a [DateTime] object. If [useCustomFormat] is
//   /// true, the given [pattern] is used to parse the string. Otherwise, the
//   /// string is expected to be in ISO 8601 format.
//   ///
//   /// Throws a [FormatException] if the string cannot be parsed into a
//   /// [DateTime].
//   ///
//   /// Example:
//   ///
//   ///     '2022-07-01'.parseToDateTime() // DateTime(2022, 7, 1)
//   ///     '01-07-2022'.parseToDateTime(pattern: 'dd-MM-yyyy') // DateTime(2022, 7, 1)
//   DateTime parseToDateTime({
//     String pattern = 'dd-MM-yyyy',
//     bool useCustomFormat = false,
//   }) =>
//       useCustomFormat ? DateFormat(pattern).parse(this) : DateTime.parse(this);

//   String parseToDateTimeString({
//     bool reverse = false,
//     bool useCustomFormat = false,
//     String? pattern,
//   }) =>
//       DateFormat(pattern ?? (reverse ? 'yyyy-MM-dd' : 'dd-MM-yyyy')).format(
//         parseToDateTime(
//           pattern: pattern ?? 'dd-MM-yyyy',
//           useCustomFormat: useCustomFormat,
//         ),
//       );

//   int toInt() => int.parse(this);

//   double toDouble() => double.parse(this);

//   int? toIntOrNull() => int.tryParse(this);

//   String getDateHeading() {
//     final today = DateTime.now();
//     // log("Date String: $this");
//     final given = parseToDateTime(
//       pattern: 'yyyy-MM-dd',
//       useCustomFormat: true,
//     );

//     if (given.year == today.year &&
//         given.month == today.month &&
//         given.day == today.day) {
//       return "Today";
//     } else if (given.year == today.year &&
//         given.month == today.month &&
//         given.day == today.day - 1) {
//       return "Yesterday";
//     } else {
//       return DateFormat.yMMMMd().format(given); // eg: April 21, 2025
//     }
//   }
// }
