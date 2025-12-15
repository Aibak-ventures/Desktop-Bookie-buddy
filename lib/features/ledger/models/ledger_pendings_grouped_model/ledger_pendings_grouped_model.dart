import 'dart:developer';

import 'package:bookie_buddy_web/features/ledger/models/pending_model/ledger_pending_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_pendings_grouped_model.freezed.dart';
part 'ledger_pendings_grouped_model.g.dart';

/// ⚠️ This class is ONLY a parser helper
/// UI + Bloc must use List<LedgerPendingsDailyModel>
class LedgerPendingsGroupedModel {
  static List<LedgerPendingsDailyModel> fromCustomJson(
    Map<String, dynamic> json,
  ) {
    final daily = <LedgerPendingsDailyModel>[];

    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map) continue;

      for (final dayEntry in monthMap.entries) {
        final rawDayMap = dayEntry.value;
        if (rawDayMap is! Map) continue;

        final dayMap = Map<String, dynamic>.from(rawDayMap);
        final rawPendings = dayMap['items'];

        final pendings = <LedgerPendingModel>[];
        if (rawPendings is List) {
          for (final item in rawPendings) {
            try {
              pendings.add(
                LedgerPendingModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              );
            } catch (e) {
              log('Pending parse error: $e');
            }
          }
        }

        daily.add(
          LedgerPendingsDailyModel(
            date: dayEntry.key.toString(),
            total:
                (dayMap['total_pending'] as num?)?.toInt() ?? 0,
            pendings: pendings,
          ),
        );
      }
    }

    return daily;
  }
}

@freezed
class LedgerPendingsDailyModel with _$LedgerPendingsDailyModel {
  const factory LedgerPendingsDailyModel({
    required String date,
    @Default(0) int total,
    @Default(<LedgerPendingModel>[])
    List<LedgerPendingModel> pendings,
  }) = _LedgerPendingsDailyModel;

  factory LedgerPendingsDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPendingsDailyModelFromJson(json);
}
