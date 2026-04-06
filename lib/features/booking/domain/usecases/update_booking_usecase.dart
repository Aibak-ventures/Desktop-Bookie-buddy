import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdateBookingUseCase {
  final IBookingRepository _repository;
  UpdateBookingUseCase(this._repository);

  Future<CustomResponseModel> call(
    int bookingId,
    BookingRequestEntity updatedBooking,
  ) => _repository.updateBooking(bookingId, updatedBooking);
}
