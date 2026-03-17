import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdateBookingUseCase {
  final IBookingRepository _repository;
  UpdateBookingUseCase(this._repository);

  Future<CustomResponseModel> call(
    int bookingId,
    RequestBookingModel updatedBooking,
  ) =>
      _repository.updateBooking(bookingId, updatedBooking);
}
