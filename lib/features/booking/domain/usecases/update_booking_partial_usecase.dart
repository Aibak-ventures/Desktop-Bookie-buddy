import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/document_file_model.dart';

class UpdateBookingPartialUseCase {
  final IBookingRepository _repository;
  UpdateBookingPartialUseCase(this._repository);

  Future<CustomResponseModel> call(
    int bookingId,
    Map<String, dynamic> partialData, {
    List<DocumentFile>? newDocuments,
    List<String>? removedDocumentUrls,
  }) =>
      _repository.updateBookingPartial(
        bookingId,
        partialData,
        newDocuments: newDocuments,
        removedDocumentUrls: removedDocumentUrls,
      );
}
