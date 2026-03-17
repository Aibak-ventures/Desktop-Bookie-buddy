import 'package:bookie_buddy_web/features/booking/domain/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class CreateOldBookingUseCase {
  final IBookingRepository _repository;
  CreateOldBookingUseCase(this._repository);

  Future<void> call(RequestBookingModel bookingData) =>
      _repository.createOldBooking(bookingData);
}
