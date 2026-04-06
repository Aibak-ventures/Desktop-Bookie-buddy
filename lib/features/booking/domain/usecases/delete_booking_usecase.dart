import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class DeleteBookingUseCase {
  final IBookingRepository _repository;
  DeleteBookingUseCase(this._repository);

  Future<void> call(int bookingId) => _repository.deleteBooking(bookingId);
}
