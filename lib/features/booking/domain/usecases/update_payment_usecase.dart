import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdatePaymentUseCase {
  final IBookingRepository _repository;
  UpdatePaymentUseCase(this._repository);

  Future<void> call({
    required int bookingId,
    required int amount,
    required PaymentMethod paymentMethod,
  }) =>
      _repository.updatePayment(
        bookingId: bookingId,
        amount: amount,
        paymentMethod: paymentMethod,
      );
}
