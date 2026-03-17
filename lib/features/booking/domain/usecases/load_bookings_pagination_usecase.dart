import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class LoadBookingsPaginationUseCase {
  final IBookingRepository _repository;
  LoadBookingsPaginationUseCase(this._repository);

  Future<PaginationModel<BookingsModel>> call({
    required LoadBookingType status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
  }) =>
      _repository.loadBookingsPagination(
        status: status,
        startDate: startDate,
        endDate: endDate,
        searchQuery: searchQuery,
        page: page,
      );
}
