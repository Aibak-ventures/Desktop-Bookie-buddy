import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_expense_grouped_model/ledger_expense_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerExpensePaginatedUseCase {
  final ILedgerRepository _repository;
  GetLedgerExpensePaginatedUseCase(this._repository);

  Future<PaginationModel<LedgerExpenseDailyModel>> call({
    required int page,
    int? clientId,
  }) =>
      _repository.getExpensePagination(page: page, clientId: clientId);
}
