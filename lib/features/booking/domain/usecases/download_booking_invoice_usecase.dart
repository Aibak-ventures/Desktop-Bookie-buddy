import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class DownloadBookingInvoiceUseCase {
  final IBookingRepository _repository;
  DownloadBookingInvoiceUseCase(this._repository);

  Future<String> call({
    required int bookingId,
    required String fileName,
  }) =>
      _repository.downloadBookingInvoice(
        bookingId: bookingId,
        fileName: fileName,
      );
}
