// (No logging required)

import 'dart:developer';

import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_payments_summary_model/ledger_payments_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/payment_model/payment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_payment_grouped_model.freezed.dart';
part 'ledger_payment_grouped_model.g.dart';

@freezed
class LedgerPaymentGroupedModel with _$LedgerPaymentGroupedModel {
  const factory LedgerPaymentGroupedModel({
    required List<LedgerPaymentsDailyModel> dailyPayments,
  }) = _LedgerPaymentGroupedModel;

  factory LedgerPaymentGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPaymentGroupedModelFromJson(json);

  /// Custom parser for nested month -> day -> { payments summary & list } structures.
  /// Expected (new) shape:
  /// ```
  /// {
  ///   "Aug 2025": {
  ///     "2025-08-21": {
  ///       "payments": { "gpay": 19800, "cash": 0, "total": 19800 },
  ///       "items": [ { ...Payment json... }, ... ]
  ///     },
  ///     "2025-08-22": { ... }
  ///   },
  ///   "Sep 2025": { ... }
  /// }
  /// ```
  /// Minimal legacy tolerance: if a day maps directly to a List it is treated as the payment list with an empty summary.
  factory LedgerPaymentGroupedModel.fromCustomJson(Map<String, dynamic> json) {
    final daily = <LedgerPaymentsDailyModel>[];

    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map) continue; // Skip malformed month level

      for (final dayEntry in monthMap.entries) {
        final rawDayMap = dayEntry.value;
        if (rawDayMap is! Map) continue; // Skip malformed day level

        final dayMap =
            Map<String, dynamic>.from(rawDayMap as Map<Object?, Object?>);
        final rawPayments = dayMap['items'];
        final payments = <PaymentModel>[];

        if (rawPayments is List) {
          for (final b in rawPayments) {
            if (b is Map<String, dynamic>) {
              try {
                payments.add(PaymentModel.fromJson(b));
              } catch (_) {
                // Skip invalid booking silently (could log if needed)
                log('Error ledger payments grouped model: Invalid payments data: $b');
              }
            }
          }
        }

        final summaryRaw = dayMap['payments'] as Map<String, dynamic>? ?? {};
        final dateStr = dayEntry.key.toString();
        final paymentSummary = _safePaymentsSummary(summaryRaw);
        daily.add(
          LedgerPaymentsDailyModel(
            date: dateStr,
            payments: payments,
            paymentsSummary: paymentSummary,
          ),
        );
      }
    }

    // Optional: sort by date string (assumes ISO-8601 date keys)
    // daily.sort((a, b) => a.date.compareTo(b.date));

    return LedgerPaymentGroupedModel(dailyPayments: daily);
  }

  // Defensive summary parser (silent fallback on malformed input)
  static LedgerPaymentsSummaryModel _safePaymentsSummary(
      Map<String, dynamic> json) {
    try {
      return LedgerPaymentsSummaryModel.fromJson(json);
    } catch (_) {
      return LedgerPaymentsSummaryModel.empty();
    }
  }
}

@freezed
class LedgerPaymentsDailyModel with _$LedgerPaymentsDailyModel {
  const factory LedgerPaymentsDailyModel({
    required String date,
    required List<PaymentModel> payments,
    LedgerPaymentsSummaryModel? paymentsSummary,
  }) = _LedgerPaymentsDailyModel;

  factory LedgerPaymentsDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPaymentsDailyModelFromJson(json);
}
