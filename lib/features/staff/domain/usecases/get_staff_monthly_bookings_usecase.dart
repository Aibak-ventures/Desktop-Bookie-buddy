import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class GetStaffMonthlyBookingsUseCase {
  final IStaffRepository _repository;

  GetStaffMonthlyBookingsUseCase(this._repository);

  Future<PaginationModel<BookingsModel>> call({
    required int staffId,
    required int year,
    required int month,
    int page = 1,
  }) async {
    return await _repository.getStaffMonthlyBookingsPagination(
      staffId: staffId,
      year: year,
      month: month,
      page: page,
    );
  }
}
