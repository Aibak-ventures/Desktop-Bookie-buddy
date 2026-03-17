import 'package:bookie_buddy_web/features/booking/domain/models/desktop_booking_model/desktop_booking_item_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/desktop_booking_model/status_counts_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class LoadDesktopBookingsPaginationUseCase {
  final IBookingRepository _repository;
  LoadDesktopBookingsPaginationUseCase(this._repository);

  Future<
      ({
        PaginationModel<DesktopBookingItemModel> pagination,
        StatusCountsModel? statusCounts,
      })> call({
    required String status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
  }) =>
      _repository.loadDesktopBookingsPagination(
        status: status,
        startDate: startDate,
        endDate: endDate,
        searchQuery: searchQuery,
        page: page,
      );
}
