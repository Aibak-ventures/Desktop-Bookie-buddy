import 'dart:developer';

import 'package:bookie_buddy_web/features/ledger/models/ledger_sale_model/ledger_sale_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_sales_grouped_model.freezed.dart';
part 'ledger_sales_grouped_model.g.dart';

@freezed
class LedgerSalesGroupedModel with _$LedgerSalesGroupedModel {
  const factory LedgerSalesGroupedModel({
    required List<LedgerSaleDailyModel> dailySales,
  }) = _LedgerSalesGroupedModel;

  factory LedgerSalesGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSalesGroupedModelFromJson(json);

  factory LedgerSalesGroupedModel.fromCustomJson(Map<String, dynamic> json) {
    final daily = <LedgerSaleDailyModel>[];

    // Expecting shape: { "July 2024": { "20-07-2024": { total: X, sales: [...] }, ... }, ... }
    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map) continue; // Skip malformed month level

      for (final dayEntry in monthMap.entries) {
        final rawDayMap = dayEntry.value;
        if (rawDayMap is! Map) continue; // Skip malformed day level

        final dayMap = Map<String, dynamic>.from(
          rawDayMap as Map<Object?, Object?>,
        );
        final rawSales = dayMap['items'];
        final sales = <LedgerSaleModel>[];

        if (rawSales is List) {
          for (final b in rawSales) {
            if (b is Map<String, dynamic>) {
              try {
                sales.add(LedgerSaleModel.fromJson(b));
              } catch (_) {
                // Skip invalid sale silently (could log if needed)
                log('Error ledger sale grouped model: Invalid sale data: $b');
              }
            }
          }
        }

        final total = (dayMap['total_expense'] as num?)?.toInt() ?? 0;
        final dateStr = dayEntry.key.toString();

        daily.add(
          LedgerSaleDailyModel(date: dateStr, total: total, sales: sales),
        );
      }
    }

    // Optional: sort by date string (assumes ISO-8601 date keys)
    // daily.sort((a, b) => a.date.compareTo(b.date));

    return LedgerSalesGroupedModel(dailySales: daily);
  }
}

@freezed
class LedgerSaleDailyModel with _$LedgerSaleDailyModel {
  const factory LedgerSaleDailyModel({
    required String date,
    @JsonKey(name: 'total', defaultValue: 0) required int total,
    required List<LedgerSaleModel> sales,
  }) = _LedgerSaleDailyModel;

  factory LedgerSaleDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSaleDailyModelFromJson(json);
}
