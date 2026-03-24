import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class GetPaymentHistoryUseCase {
  final IBookingRepository _repository;
  GetPaymentHistoryUseCase(this._repository);

  Future<List<BookingPaymentHistoryEntity>> call(int bookingId) =>
      _repository.getPaymentHistory(bookingId);
}
