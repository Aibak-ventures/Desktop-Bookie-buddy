import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_sales_grouped_model/ledger_sales_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerSalesPaginatedUseCase {
  final ILedgerRepository _repository;
  GetLedgerSalesPaginatedUseCase(this._repository);

  Future<PaginationModel<LedgerSaleDailyModel>> call({
    int page = 1,
    int? clientId,
  }) =>
      _repository.getSalesPagination(page: page, clientId: clientId);
}
