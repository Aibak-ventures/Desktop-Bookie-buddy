import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/features/wallet/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/wallet/repository/ledger_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LedgerSimpleSummaryCubit extends Cubit<DailySummaryModel?> {
  final LedgerRepository _repository = getIt.get<LedgerRepository>();
  LedgerSimpleSummaryCubit() : super(null);

  final _cacheSummary = <String, DailySummaryModel>{}; // Cache summaries

  void update() => emit(state);

  Future<void> getLedgerDaySummary(
    String date, {
    required int? clientId,
    bool force = false,
  }) async {
    log('fetching summary for $date');

    final cache = _cacheSummary[date];
    if (cache != null) log('already have summary for $date, summary: ${cache}');

    final daySummary = cache == null || force
        ? await _repository.getLedgerDaySummary(
            date: date,
            clientId: clientId,
          )
        : cache; // call api only if not in cache

    emit(daySummary);

    _cacheSummary.putIfAbsent(date, () => daySummary);
  }

  void reset() {
    // if (_cacheSummary.keys.firstOrNull != null)
    //   getExpenseDaySummary(_cacheSummary.keys.first);
    emit(null);
    _cacheSummary.clear();
  }
}
