import 'dart:typed_data';

import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class GetInvoicePdfBytesUseCase {
  final IBookingRepository _repository;
  GetInvoicePdfBytesUseCase(this._repository);

  Future<Uint8List> call(int bookingId) =>
      _repository.getInvoicePdfBytes(bookingId);
}
