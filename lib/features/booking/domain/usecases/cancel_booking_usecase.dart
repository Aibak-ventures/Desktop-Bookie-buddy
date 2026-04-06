import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class CancelBookingUseCase {
  final IBookingRepository _repository;
  CancelBookingUseCase(this._repository);

  Future<void> call({
    required int bookingId,
    int? refundAmount,
    PaymentMethod? paymentMethod,
  }) =>
      _repository.cancelBooking(
        bookingId: bookingId,
        refundAmount: refundAmount,
        paymentMethod: paymentMethod,
      );
}
