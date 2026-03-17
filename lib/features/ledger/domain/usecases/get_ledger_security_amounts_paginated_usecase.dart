import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_security_amount_grouped_model/ledger_security_amount_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerSecurityAmountsPaginatedUseCase {
  final ILedgerRepository _repository;
  GetLedgerSecurityAmountsPaginatedUseCase(this._repository);

  Future<PaginationModel<LedgerSecurityAmountDailyModel>> call({
    required int page,
    int? clientId,
  }) =>
      _repository.getSecurityAmountsPagination(page: page, clientId: clientId);
}
