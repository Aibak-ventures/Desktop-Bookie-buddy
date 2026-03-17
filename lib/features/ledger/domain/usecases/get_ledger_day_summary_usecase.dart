import 'package:bookie_buddy_web/features/ledger/domain/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerDaySummaryUseCase {
  final ILedgerRepository _repository;
  GetLedgerDaySummaryUseCase(this._repository);

  Future<DailySummaryModel> call({
    required String date,
    int? clientId,
  }) =>
      _repository.getLedgerDaySummary(date: date, clientId: clientId);
}
