import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class SendInvoiceUseCase {
  final IBookingRepository _repository;
  SendInvoiceUseCase(this._repository);

  Future<void> call(int bookingId, bool sendWhatsApp) =>
      _repository.sendInvoice(bookingId, sendWhatsApp);
}
