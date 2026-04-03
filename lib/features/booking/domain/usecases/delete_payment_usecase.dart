import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class DeletePaymentUseCase {
  final IBookingRepository _repository;
  DeletePaymentUseCase(this._repository);

  Future<void> call(int paymentId) => _repository.deletePayment(paymentId);
}
