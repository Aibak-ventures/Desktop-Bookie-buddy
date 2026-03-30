import 'package:bookie_buddy_web/features/booking/domain/entities/desktop_booking_item_entity/desktop_booking_item_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/status_counts_entity/status_counts_entity.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class LoadDesktopBookingsPaginationUseCase {
  final IBookingRepository _repository;
  LoadDesktopBookingsPaginationUseCase(this._repository);

  Future<
    ({
      PaginationModel<DesktopBookingItemEntity> pagination,
      StatusCountsEntity? statusCounts,
    })
  >
  call({
    required String status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
    String? nextPageUrl,
  }) => _repository.loadDesktopBookingsPagination(
    status: status,
    startDate: startDate,
    endDate: endDate,
    searchQuery: searchQuery,
    page: page,
    nextPageUrl: nextPageUrl,
  );
}