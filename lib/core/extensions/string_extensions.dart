import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart' as colorpicker;
import 'package:intl/intl.dart';

extension StringXDateFormat on String {
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

    throw FormatException(
      'Unrecognized date/time format: $this. Tried formats: ${formats.join(', ')}',
    );
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
  String formatToUiDate() => DateFormat('dd-MM-yyyy').format(parseToDateTime());

  /// Appends time to date in '${date}T${HH:mm:ss}' format
  String appendTimeToDate({
    String? time24HourAsString,
    TimeOfDay? time,
    bool includeIfNull = false,
  }) {
    String? time24Hour;
    if (time24HourAsString != null) {
      time24Hour = time24HourAsString;
    } else if (time != null) {
      final hourStr = time.hour.toString().padLeft(2, '0');
      final minuteStr = time.minute.toString().padLeft(2, '0');
      time24Hour = '$hourStr:$minuteStr:00';
    } else if (includeIfNull) {
      time24Hour = '00:00:00';
    }

    if (includeIfNull || time24HourAsString != null || time != null) {
      return '${this}T${time24Hour}';
    } else {
      return this;
    }
  }

  /// Extracts and formats time if needed (supports both 24hr and 12hr)
  String formatToUiTime({bool is24Hour = false}) {
    try {
      // Try format: dd-MM-yyyy hh:mm a (12-hour with AM/PM)
      return DateFormat(
        is24Hour ? 'HH:mm' : 'hh:mm a',
      ).format(DateFormat('dd-MM-yyyy hh:mm a').parse(this));
    } catch (_) {
      try {
        // Try format: dd-MM-yyyy HH:mm:ss (24-hour with seconds)
        return DateFormat(
          is24Hour ? 'HH:mm' : 'hh:mm a',
        ).format(DateFormat('dd-MM-yyyy HH:mm:ss').parse(this));
      } catch (_) {
        try {
          // Try format: yyyy-MM-dd HH:mm:ss (if your backend ever sends this)
          return DateFormat(
            is24Hour ? 'HH:mm' : 'hh:mm a',
          ).format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(this));
        } catch (e) {
          log('Failed to parse time: $this, error: $e');
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
      throw FormatException('Unrecognized date format: $this', stack);
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
      throw FormatException('Unrecognized date format: $this', stack);
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
      throw FormatException('Unrecognized date format: $this', stack);
    }
  }

  /// Formats to full Date + Time if needed
  String formatToUiDateTime({bool is24Hour = true}) {
    final dateTime = DateTime.tryParse(this) ?? parseToDateTime();
    return DateFormat(
      'dd-MM-yyyy ${is24Hour ? 'HH:mm' : 'hh:mm a'}',
    ).format(dateTime);
  }

  // Optional: Smart heading like Today, Yesterday, or Full Date
  String getDateHeading() {
    final today = DateTime.now();
    final given = parseToDateTime();

    if (DateUtils.isSameDay(given, today)) {
      return 'Today';
    } else if (DateUtils.isSameDay(given, today.subtract(1.days()))) {
      return 'Yesterday';
    } else {
      return DateFormat.yMMMMd().format(given); // eg: April 21, 2025
    }
  }

  /// Formats date/time with relative day labels like "Today, 8am" or "Tomorrow, 10pm"
  /// Falls back to date format for dates beyond tomorrow
  String formatToRelativeDateTime({bool is24Hour = false}) {
    try {
      final dateTime = parseToDateTime();
      final today = DateTime.now();
      final timeFormat = is24Hour ? 'HH:mm' : 'h:mma';
      final formattedTime =
          DateFormat(timeFormat).format(dateTime).toLowerCase();

      if (DateUtils.isSameDay(dateTime, today)) {
        return 'Today, $formattedTime';
      } else if (DateUtils.isSameDay(dateTime, today.add(1.days()))) {
        return 'Tomorrow, $formattedTime';
      } else if (DateUtils.isSameDay(dateTime, today.subtract(1.days()))) {
        return 'Yesterday, $formattedTime';
      } else {
        // For dates beyond tomorrow, show date + time
        return '${DateFormat('dd MMM').format(dateTime)}, $formattedTime';
      }
    } catch (e) {
      log('Failed to format relative date/time: $this, error: $e');
      return this;
    }
  }
}

/// Extension methods for String to parse numbers and handle nullability.
extension StringX on String {
  /// Parses the string to an integer.
  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return double.parse(this).toInt();
    }
  }

  /// Parses the string to an integer, returning `null` if parsing fails.
  int? toIntOrNull() {
    try {
      return toInt();
    } catch (e) {
      return null;
    }
  }

  /// Parses the string to a double.
  double toDouble() => double.parse(this);

  /// Parses the string to a double, returning `null` if parsing fails.
  double? toDoubleOrNull() {
    try {
      return double.parse(this);
    } catch (e) {
      debugPrint('Failed to parse $this as double: $e, returning null');
      return null;
    }
  }

  /// Parses the string to a double, returning [defaultValue] if parsing fails.
  double toDoubleOrDefault([double defaultValue = 0]) =>
      toDoubleOrNull() ?? defaultValue;

  /// Parses the string to an integer, returning [defaultValue] if parsing fails.
  int toIntOrDefault([int defaultValue = 0]) => toIntOrNull() ?? defaultValue;

  ///  Splits the string into chunks of words with a maximum of [length] words each.
  List<String> splitByWords([int length = 6]) {
    final split = this.split(' ');
    if (split.isEmpty) return [];

    final List<String> result = [];
    for (var i = 0; i < split.length; i += length) {
      result.add(
        split
            .sublist(i, i + length > split.length ? split.length : i + length)
            .join(' '),
      );
    }
    return result;
  }

  /// Gets the initial letters of the words in the string. return empty string if no words.
  ///
  /// eg: "John Doe" => "JD"
  String get getInitialLetters {
    final parts = trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '';
    }
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  /// Converts various types to double. Defaults to 0.0 if conversion fails.
  ///
  /// eg:
  /// ```
  /// StringX.toDoubleFromString("12.34") => 12.34
  static double toDoubleFromString(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return value.toDoubleOrDefault();
    } else {
      return 0.0;
    }
  }

  /// Converts various types to int.
  ///
  /// eg:
  /// ```
  /// StringX.toIntFromString("123") => 123
  /// ```
  static int toIntFromString(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return value.toIntOrDefault();
    } else {
      return 0;
    }
  }
}

extension StringXNullable on String? {
  /// Checks if the string is null.
  bool get isNull => this == null;

  /// Checks if the string is not null.
  bool get isNotNull => this != null;

  /// Checks if the string is null or empty after trimming.
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  /// Checks if the string is not null and not empty after trimming.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Checks if the string is not empty or not equal to [value].
  bool isNotEmptyOr(dynamic value) => this != value;

  // Returns an empty string if the string is null or returns the string itself.
  String orEmpty() => this ?? '';

  /// Returns 'N/A' if the string is null or empty, otherwise returns the string itself.
  String orNA() => isNullOrEmpty ? 'N/A' : this!;

  /// Returns the provided [fallback] if the string is null or empty, otherwise returns the string itself.
  String orFallback(String fallback) => isNullOrEmpty ? fallback : this!;

  /// Returns `null` if the string is null or empty after trimming, otherwise returns the string itself.
  String? get nullIfEmpty => isNullOrEmpty ? null : this;

  /// Parses the string to an integer, returning `null` if parsing fails.
  int? toIntOrNull() {
    try {
      if (this == null) return null;
      return int.tryParse(this!);
    } catch (e) {
      debugPrint('Failed to parse $this as int: $e, returning null');
      return null;
    }
  }

  /// Capitalizes the first letter of the string.
  String capitalizeFirstLetter() {
    if (isNullOrEmpty) return this ?? '';
    return '${this![0].toUpperCase()}${this!.substring(1)}';
  }

  /// Sanitizes the string by masking part of it with asterisks(*).
  String sanitizeString({int visibleStart = 4, int visibleEnd = 4}) {
    final text = this ?? '';
    if (text.length <= visibleStart + visibleEnd) return '***';
    final start = text.substring(0, visibleStart);
    final end = text.substring(text.length - visibleEnd);
    return '$start...$end';
  }
}

extension StringXNumberFieldChangeValidator on String? {
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

extension StringColorXNullable on String? {
  /// Converts a hex string to a Color object.
  ///
  /// Supports formats like '#RRGGBB', 'RRGGBB', '#AARRGGBB', 'AARRGGBB'.
  Color? toColor({Color? defaultColor}) {
    if (this == null || this!.isEmpty) {
      return defaultColor;
    }
    // toColor extension method from colorpicker package
    return this!.toColor() ?? defaultColor;
  }

  // Color? toColor() {
  //   if (this == null || this!.isEmpty) {
  //     return null;
  //   }
  //   String hex = this!.trim().toUpperCase().replaceAll('#', '');
  //   if (hex.length == 6) {
  //     hex = 'FF$hex'; // Add full opacity if alpha not provided
  //   } else if (hex.length != 8) {
  //     return null; // Invalid format
  //   }
  //   final intVal = int.parse(hex, radix: 16);
  //   return Color(intVal);
  // }
}
