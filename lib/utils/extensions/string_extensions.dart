import 'dart:developer';

import 'package:bookie_buddy_shared/core/core/common/utils/string_date_extensions.dart';
import 'package:bookie_buddy_shared/ui/utils/extensions/string_date_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';

export 'package:bookie_buddy_shared/core/utils/extensions/string_extensions.dart';
export 'package:bookie_buddy_shared/ui/utils/extensions/string_date_extensions.dart';

extension StringXDateFormatWeb on String {
  /// Parses any valid date string and auto handles both `yyyy-MM-dd` and
  /// `dd-MM-yyyy`. Delegates to the shared package's implementation (not
  /// re-exported directly) so this stays the single call surface for web
  /// while the parsing logic itself has one source of truth.
  DateTime parseToDateTime() => StringXDateFormat(this).parseToDateTime();

  DateTime? tryParseToDateTime() =>
      StringXDateFormat(this).tryParseToDateTime();

  /// Always formats to 'dd-MM-yyyy' for UI
  String formatToUiDate() => DateFormat('dd-MM-yyyy').format(parseToDateTime());

  /// Appends [pickupTime] to this formatted date string, defaulting to
  /// 00:00:00 (start of day) when the user hasn't explicitly picked a
  /// pickup time. Single source of truth for the pickup-side default used
  /// across every booking submission payload.
  String appendPickupTime(TimeOfDay? pickupTime) => appendTimeToDate(
    time: pickupTime,
    time24HourAsString: pickupTime == null ? '00:00:00' : null,
  );

  /// Appends [returnTime] to this formatted date string, defaulting to
  /// 23:59:00 (end of day) when the user hasn't explicitly picked a return
  /// time.
  String appendReturnTime(TimeOfDay? returnTime) => appendTimeToDate(
    time: returnTime,
    time24HourAsString: returnTime == null ? '23:59:00' : null,
  );

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
      final formattedTime = DateFormat(
        timeFormat,
      ).format(dateTime).toLowerCase();

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

extension StringXWaPhone on String {
  /// Strips all non-digit characters — used to build WhatsApp `wa.me` links.
  String get toWaPhone => replaceAll(RegExp(r'[^0-9]'), '');
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
}

extension StringXPhoneNumber on String {
  /// Parses the string to a PhoneNumber object. Throws FormatException if parsing fails.
  PhoneNumber parsePhoneNumber() {
    try {
      return PhoneNumber.parse(this);
    } catch (e) {
      throw FormatException('Invalid phone number format: $this', e);
    }
  }

  /// Parses the string to a PhoneNumber object, returning `null` if parsing fails.
  PhoneNumber? tryParsePhoneNumber() {
    try {
      return PhoneNumber.parse(this);
    } catch (e) {
      log('Failed to parse phone number: $this, error: $e');
      return null;
    }
  }

  /// Formats a raw e164 phone number string into a more readable format.
  String formatPhoneNumber({bool includeCountryCode = true}) {
    // Parse the raw e164 number (e.g., +919876543210)
    try {
      final phoneNumber = PhoneNumber.parse(this);
      if (includeCountryCode) {
        return '+${phoneNumber.countryCode} ${phoneNumber.formatNsn()}';
      }
      // Format it for display (e.g., +91 98765-43210)
      return phoneNumber.formatNsn();
    } catch (e) {
      return this; // If parsing fails, return the original string
    }
  }
}
