import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class AddBookingUseCase {
  final IBookingRepository _repository;
  AddBookingUseCase(this._repository);

  Future<int> call(BookingRequestEntity bookingData) =>
      _repository.addBooking(bookingData);
}
