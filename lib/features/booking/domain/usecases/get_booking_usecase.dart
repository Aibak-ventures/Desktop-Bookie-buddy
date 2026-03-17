import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class GetBookingUseCase {
  final IBookingRepository _repository;
  GetBookingUseCase(this._repository);

  Future<BookingDetailsModel> call(int bookingId) =>
      _repository.getBooking(bookingId);
}
