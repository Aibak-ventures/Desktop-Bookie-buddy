import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class DeleteSecurityRefundedPaymentUseCase {
  final IBookingRepository _repository;
  const DeleteSecurityRefundedPaymentUseCase(this._repository);

  Future<void> call({required int refundId}) =>
      _repository.deleteSecurityRefundedPayment(refundId: refundId);
}
