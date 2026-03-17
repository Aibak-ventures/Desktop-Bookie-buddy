import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_bookings_grouped_model/ledger_bookings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerBookingsPaginatedUseCase {
  final ILedgerRepository _repository;
  GetLedgerBookingsPaginatedUseCase(this._repository);

  Future<PaginationModel<LedgerBookingDailyModel>> call({
    int page = 1,
    int? clientId,
  }) =>
      _repository.getBookingsPagination(page: page, clientId: clientId);
}
