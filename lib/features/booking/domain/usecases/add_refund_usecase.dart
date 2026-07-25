import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class AddRefundUseCase {
  final IBookingRepository _repository;
  const AddRefundUseCase(this._repository);

  Future<void> call({
    required int bookingId,
    required int amount,
    required int accountId,
    String? refundReason,
  }) => _repository.addRefund(
    bookingId: bookingId,
    amount: amount,
    accountId: accountId,
    refundReason: refundReason,
  );
}
