import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';

class GetPaymentHistoryUseCase {
  final IBookingRepository _repository;
  GetPaymentHistoryUseCase(this._repository);

  Future<List<BookingDetailsPaymentHistoryModel>> call(int bookingId) =>
      _repository.getPaymentHistory(bookingId);
}
