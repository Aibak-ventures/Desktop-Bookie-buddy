import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class AddBookingUseCase {
  final IBookingRepository _repository;
  AddBookingUseCase(this._repository);

  Future<int> call(RequestBookingModel bookingData) =>
      _repository.addBooking(bookingData);
}
