import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdateBookingStatusUseCase {
  final IBookingRepository _repository;
  UpdateBookingStatusUseCase(this._repository);

  Future<void> call(int bookingId, BookingStatus bookingStatus) =>
      _repository.updateBookingStatus(bookingId, bookingStatus);
}
