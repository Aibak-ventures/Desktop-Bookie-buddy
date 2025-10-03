import 'dart:developer';

import 'package:bookie_buddy_web/features/ledger/models/ledger_booking_model/ledger_booking_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_bookings_grouped_model.freezed.dart';
part 'ledger_bookings_grouped_model.g.dart';

@freezed
class LedgerBookingsGroupedModel with _$LedgerBookingsGroupedModel {
  const factory LedgerBookingsGroupedModel({
    required List<LedgerBookingDailyModel> dailyBookings,
  }) = _LedgerBookingsGroupedModel;

  factory LedgerBookingsGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerBookingsGroupedModelFromJson(json);

  factory LedgerBookingsGroupedModel.fromCustomJson(Map<String, dynamic> json) {
    final daily = <LedgerBookingDailyModel>[];

    // Expecting shape: { "July 2024": { "20-07-2024": { total: X, bookings: [...] }, ... }, ... }
    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map) continue; // Skip malformed month level

      for (final dayEntry in monthMap.entries) {
        final rawDayMap = dayEntry.value;
        if (rawDayMap is! Map) continue; // Skip malformed day level

        final dayMap =
            Map<String, dynamic>.from(rawDayMap as Map<Object?, Object?>);
        final rawBookings = dayMap['bookings'];
        final bookings = <LedgerBookingModel>[];

        if (rawBookings is List) {
          for (final b in rawBookings) {
            if (b is Map<String, dynamic>) {
              try {
                bookings.add(LedgerBookingModel.fromJson(b));
              } catch (_) {
                // Skip invalid booking silently (could log if needed)
                log('Error ledger booking grouped model: Invalid booking data: $b');
              }
            }
          }
        }

        final total = (dayMap['total'] as num?)?.toInt() ?? 0;
        final dateStr = dayEntry.key.toString();

        daily.add(
          LedgerBookingDailyModel(
            date: dateStr,
            total: total,
            bookings: bookings,
          ),
        );
      }
    }

    // Optional: sort by date string (assumes ISO-8601 date keys)
    // daily.sort((a, b) => a.date.compareTo(b.date));

    return LedgerBookingsGroupedModel(dailyBookings: daily);
  }
}

@freezed
class LedgerBookingDailyModel with _$LedgerBookingDailyModel {
  const factory LedgerBookingDailyModel({
    required String date,
    @JsonKey(name: 'total', defaultValue: 0) required int total,
    required List<LedgerBookingModel> bookings,
  }) = _LedgerBookingDailyModel;

  factory LedgerBookingDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerBookingDailyModelFromJson(json);
}
