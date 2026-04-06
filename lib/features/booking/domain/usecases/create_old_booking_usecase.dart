import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class CreateOldBookingUseCase {
  final IBookingRepository _repository;
  CreateOldBookingUseCase(this._repository);

  Future<void> call(BookingRequestEntity bookingData) =>
      _repository.createOldBooking(bookingData);
}
