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
}

extension StringX on String {
  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return double.parse(this).toInt();
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

  int toIntOrDefault([int defaultValue = 0]) => toIntOrNull() ?? defaultValue;

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
}

extension NullableStringX on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String orEmpty() => this ?? '';

  String orNA() => isNotNullOrEmpty ? 'N/A' : this!;

  String orFallback(String fallback) => isNullOrEmpty ? fallback : this!;

  String? get nullIfEmpty => isNullOrEmpty ? null : this;

  String capitalizeFirstLetter() {
    if (isNullOrEmpty) return this ?? '';
    return '${this![0].toUpperCase()}${this!.substring(1)}';
  }
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
