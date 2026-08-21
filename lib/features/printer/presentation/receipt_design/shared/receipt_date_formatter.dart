import 'dart:developer';

import 'package:intl/intl.dart';

import '../../../../../utils/extensions/string_extensions.dart';

const _logName = 'ReceiptDateFormatter';

/// Generic date/time formatting for receipts — not tied to any one
/// receipt type's domain (booking, sale, ...), just "how a date/time
/// string looks once printed", so any receipt builder can share it
/// instead of re-deriving its own copy.
class ReceiptDateFormatter {
  const ReceiptDateFormatter._();

  /// Always DD/MM/YYYY on the printed receipt, independent of the app-wide
  /// dd-MM-yyyy UI format.
  static String formatDate(String date) =>
      DateFormat('dd/MM/yyyy').format(date.parseToDateTime());

  /// Extracts a time from [date] only when one is genuinely encoded in it —
  /// `null` otherwise. Deliberately *not* `date.formatToUiTime(tryParse:
  /// true)` directly: on a date-only string (no time component at all —
  /// which a field like a booking's `bookedDate`/`created_at` could
  /// legitimately be), that silently falls through to `DateTime.tryParse`
  /// (parses a bare date as midnight) and finally to `DateTime.now()` —
  /// i.e. it fabricates a plausible-looking but *wrong* time instead of
  /// failing. Requiring a literal `:` first means a date-only string never
  /// reaches `formatToUiTime` at all, so a customer-facing invoice never
  /// prints a time that was never actually recorded.
  static String? safeTime(String date) {
    if (!date.contains(':')) return null;
    try {
      return date.formatToUiTime();
    } catch (e) {
      log('Failed to extract a time from "$date": $e', name: _logName);
      return null;
    }
  }

  /// Date, plus a time only when one is actually available — no filler
  /// placeholder printed when there isn't.
  static String dateAndMaybeTime(String date, String? time) {
    final formattedDate = formatDate(date);
    if (time == null || time.trim().isEmpty) return formattedDate;
    return '$formattedDate, $time';
  }
}
