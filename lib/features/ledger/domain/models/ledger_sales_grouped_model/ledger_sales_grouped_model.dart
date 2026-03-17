import 'dart:developer';

import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_sale_model/ledger_sale_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_sales_grouped_model.freezed.dart';
part 'ledger_sales_grouped_model.g.dart';

/// ❌ IMPORTANT CHANGE
/// This model is NO LONGER used directly by UI.
/// UI uses List<LedgerSaleDailyModel>
/// This class is only a helper to parse nested API data.
@freezed
class LedgerSalesGroupedModel with _$LedgerSalesGroupedModel {
  const factory LedgerSalesGroupedModel({
    required List<LedgerSaleDailyModel> dailySales,
  }) = _LedgerSalesGroupedModel;

  factory LedgerSalesGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSalesGroupedModelFromJson(json);

  /// ✅ FIXED: Converts API response into FLAT daily list
  static List<LedgerSaleDailyModel> fromCustomJson(
    Map<String, dynamic> json,
  ) {
    final daily = <LedgerSaleDailyModel>[];

    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map) continue;

      for (final dayEntry in monthMap.entries) {
        final rawDayMap = dayEntry.value;
        if (rawDayMap is! Map) continue;

        final dayMap = Map<String, dynamic>.from(rawDayMap);

        // ✅ FIX 1: map `items` → LedgerSaleModel
        final rawSales = dayMap['items'];
        final sales = <LedgerSaleModel>[];

        if (rawSales is List) {
          for (final item in rawSales) {
            try {
              sales.add(
                LedgerSaleModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              );
            } catch (e) {
              log('LedgerSale parse error: $e');
            }
          }
        }

        // ✅ FIX 2: correct total key
        final total = (dayMap['total_expense'] as num?)?.toInt() ?? 0;

        daily.add(
          LedgerSaleDailyModel(
            date: dayEntry.key.toString(), // "09-12-2025"
            total: total,
            sales: sales,
          ),
        );
      }
    }

    return daily;
  }
}

@freezed
class LedgerSaleDailyModel with _$LedgerSaleDailyModel {
  const factory LedgerSaleDailyModel({
    required String date,
    @Default(0) int total,
    @Default(<LedgerSaleModel>[]) List<LedgerSaleModel> sales,
  }) = _LedgerSaleDailyModel;

  factory LedgerSaleDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSaleDailyModelFromJson(json);
}
