import 'dart:developer';

import 'package:bookie_buddy_web/features/ledger/models/pending_model/ledger_pending_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_pendings_grouped_model.freezed.dart';
part 'ledger_pendings_grouped_model.g.dart';

@freezed
class LedgerPendingsGroupedModel with _$LedgerPendingsGroupedModel {
  const factory LedgerPendingsGroupedModel({
    required List<LedgerPendingsDailyModel> dailyPendings,
  }) = _LedgerPendingsGroupedModel;

  factory LedgerPendingsGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPendingsGroupedModelFromJson(json);

  factory LedgerPendingsGroupedModel.fromCustomJson(Map<String, dynamic> json) {
    final daily = <LedgerPendingsDailyModel>[];

    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map) continue; // Skip malformed month level

      for (final dayEntry in monthMap.entries) {
        final rawDayMap = dayEntry.value;
        if (rawDayMap is! Map) continue; // Skip malformed day level

        final dayMap =
            Map<String, dynamic>.from(rawDayMap as Map<Object?, Object?>);
        final rawPendings = dayMap['items'];
        final pendings = <LedgerPendingModel>[];

        if (rawPendings is List) {
          for (final b in rawPendings) {
            if (b is Map<String, dynamic>) {
              try {
                pendings.add(LedgerPendingModel.fromJson(b));
              } catch (_) {
                // Skip invalid pending silently (could log if needed)
                log('Error ledger pending grouped model: Invalid pending data: $b');
              }
            }
          }
        }

        final total = (dayMap['total_pending'] as num?)?.toInt() ?? 0;
        final dateStr = dayEntry.key.toString();

        daily.add(
          LedgerPendingsDailyModel(
            date: dateStr,
            total: total,
            pendings: pendings,
          ),
        );
      }
    }

    // Optional: sort by date string (assumes ISO-8601 date keys)
    // daily.sort((a, b) => a.date.compareTo(b.date));

    return LedgerPendingsGroupedModel(dailyPendings: daily);
  }
}

@freezed
class LedgerPendingsDailyModel with _$LedgerPendingsDailyModel {
  const factory LedgerPendingsDailyModel({
    required String date,
    @JsonKey(name: 'total_pending', defaultValue: 0) required int total,
    required List<LedgerPendingModel> pendings,
  }) = _LedgerPendingsDailyModel;

  factory LedgerPendingsDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPendingsDailyModelFromJson(json);
}
