import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class CancelBookingUseCase {
  final IBookingRepository _repository;
  CancelBookingUseCase(this._repository);

  Future<void> call({
    required int bookingId,
    int? refundAmount,
    int? accountId,
  }) => _repository.cancelBooking(
    bookingId: bookingId,
    refundAmount: refundAmount,
    accountId: accountId,
  );
}
