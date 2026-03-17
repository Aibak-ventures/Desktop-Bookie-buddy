import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_pendings_grouped_model/ledger_pendings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerPendingPaginatedUseCase {
  final ILedgerRepository _repository;
  GetLedgerPendingPaginatedUseCase(this._repository);

  Future<PaginationModel<LedgerPendingsDailyModel>> call({
    required int page,
    int? clientId,
  }) =>
      _repository.getPendingPagination(page: page, clientId: clientId);
}
