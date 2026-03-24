import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class GetBookingUseCase {
  final IBookingRepository _repository;
  GetBookingUseCase(this._repository);

  Future<BookingDetailsEntity> call(int bookingId) =>
      _repository.getBooking(bookingId);
}
