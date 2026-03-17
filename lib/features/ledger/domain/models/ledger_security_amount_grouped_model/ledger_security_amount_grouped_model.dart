import 'dart:developer';

import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_security_amount_model/ledger_security_amount_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_security_amount_grouped_model.freezed.dart';
part 'ledger_security_amount_grouped_model.g.dart';

@freezed
class LedgerSecurityAmountGroupedModel with _$LedgerSecurityAmountGroupedModel {
  const factory LedgerSecurityAmountGroupedModel({
    required List<LedgerSecurityAmountDailyModel> dailySecurityAmounts,
  }) = _LedgerSecurityAmountGroupedModel;

  factory LedgerSecurityAmountGroupedModel.fromJson(
          Map<String, dynamic> json) =>
      _$LedgerSecurityAmountGroupedModelFromJson(json);

  factory LedgerSecurityAmountGroupedModel.fromCustomJson(
      Map<String, dynamic> json) {
    final daily = <LedgerSecurityAmountDailyModel>[];

    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map) continue; // Skip malformed month level

      for (final dayEntry in monthMap.entries) {
        final rawDayMap = dayEntry.value;
        if (rawDayMap is! Map) continue; // Skip malformed day level

        final dayMap =
            Map<String, dynamic>.from(rawDayMap as Map<Object?, Object?>);
        final rawSecurityAmount = dayMap['items'];
        final securityAmounts = <LedgerSecurityAmountModel>[];

        if (rawSecurityAmount is List) {
          for (final b in rawSecurityAmount) {
            if (b is Map<String, dynamic>) {
              try {
                securityAmounts.add(LedgerSecurityAmountModel.fromJson(b));
              } catch (_) {
                // Skip invalid security amount silently (could log if needed)
                log('Error ledger security amount grouped model: Invalid security amount data: $b');
              }
            }
          }
        }

        final dateStr = dayEntry.key.toString();

        daily.add(
          LedgerSecurityAmountDailyModel(
            date: dateStr,
            items: securityAmounts,
          ),
        );
      }
    }

    // Optional: sort by date string (assumes ISO-8601 date keys)
    // daily.sort((a, b) => a.date.compareTo(b.date));

    return LedgerSecurityAmountGroupedModel(dailySecurityAmounts: daily);
  }
}

@freezed
class LedgerSecurityAmountDailyModel with _$LedgerSecurityAmountDailyModel {
  const factory LedgerSecurityAmountDailyModel({
    required String date,
    required List<LedgerSecurityAmountModel> items,
  }) = _LedgerSecurityAmountDailyModel;

  factory LedgerSecurityAmountDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSecurityAmountDailyModelFromJson(json);
}
