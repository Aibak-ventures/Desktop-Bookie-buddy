import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class DeleteRefundUseCase {
  final IBookingRepository _repository;
  const DeleteRefundUseCase(this._repository);

  Future<void> call({required int bookingId, required int refundId}) =>
      _repository.deleteRefund(bookingId: bookingId, refundId: refundId);
}
