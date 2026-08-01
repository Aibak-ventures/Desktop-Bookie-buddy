import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdateSecurityRefundUseCase {
  final IBookingRepository _repository;
  const UpdateSecurityRefundUseCase(this._repository);

  Future<void> call({
    required int bookingId,
    int? refundAmount,
    int? deductionAmount,
    required int accountId,
    String? note,
  }) => _repository.updateSecurityRefund(
    bookingId: bookingId,
    refundAmount: refundAmount,
    deductionAmount: deductionAmount,
    accountId: accountId,
    note: note,
  );
}
