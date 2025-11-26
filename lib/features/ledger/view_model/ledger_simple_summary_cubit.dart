import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/invoice_enums.dart';
import 'package:bookie_buddy_web/features/ledger/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_payments_summary_model/ledger_payments_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/repository/ledger_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LedgerSimpleSummaryCubit extends Cubit<DailySummaryModel?> {
  final LedgerRepository _repository;
  LedgerSimpleSummaryCubit({required LedgerRepository repository})
      : _repository = repository,
        super(null);

  final _cacheSummary = <String, DailySummaryModel>{}; // Cache summaries

  void update() => emit(state);

  Future<void> getLedgerDaySummary(
    String date, {
    required int? clientId,
    dynamic total,
    LedgerType type = LedgerType.all,
    bool force = false,
  }) async {
    // Assert that if type is payments, total must be of type LedgerPaymentsSummaryModel
    assert(
      type != LedgerType.payments || total is LedgerPaymentsSummaryModel,
      'For payments type, total must be LedgerPaymentsSummaryModel',
    );
    // Assert that if type is not payments, total must not be LedgerPaymentsSummaryModel
    assert(
      type == LedgerType.payments || total is! LedgerPaymentsSummaryModel,
      'For non-payments type, total must not be LedgerPaymentsSummaryModel',
    );

    log('fetching summary for $date');

    final cache = _cacheSummary[date];

    if (type != LedgerType.all && total != null) {
      final model = cache ?? DailySummaryModel.fromEmpty(date: date);
      final updated = model.copyWith(
        payments: total is LedgerPaymentsSummaryModel
            ? total
            : LedgerPaymentsSummaryModel.empty(),
        bookingAmount: type.isBookings ? total : 0,
        expenses: type.isExpense ? total : 0,
        pendings: type.isPendings ? total : 0,
        securityAmount: type.isSecurity ? total : 0,
        salesAmount: type.isSales ? total : 0,
      );
      log('emitting summary without fetching data from api: ${updated}');
      emit(updated);
      return;
    }

    if (cache != null) log('already have summary for $date, summary: ${cache}');

    final daySummary = cache == null || force
        ? await _repository.getLedgerDaySummary(date: date, clientId: clientId)
        : cache; // call api only if not in cache

    if (!isClosed) emit(daySummary);

    _cacheSummary.putIfAbsent(date, () => daySummary);
  }

  void reset() {
    // if (_cacheSummary.keys.firstOrNull != null)
    //   getExpenseDaySummary(_cacheSummary.keys.first);
    emit(null);
    _cacheSummary.clear();
  }
}
