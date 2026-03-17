import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_payment_grouped_model/ledger_payment_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerPaymentsPaginatedUseCase {
  final ILedgerRepository _repository;
  GetLedgerPaymentsPaginatedUseCase(this._repository);

  Future<PaginationModel<LedgerPaymentsDailyModel>> call({
    int page = 1,
    int? clientId,
  }) =>
      _repository.getPaymentsPagination(page: page, clientId: clientId);
}
