import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdateBookingPartialUseCase {
  final IBookingRepository _repository;
  UpdateBookingPartialUseCase(this._repository);

  Future<CustomResponseModel> call(
    int bookingId,
    Map<String, dynamic> partialData, {
    List<DocumentFileEntity>? newDocuments,
    List<String>? removedDocumentUrls,
  }) => _repository.updateBookingPartial(
    bookingId,
    partialData,
    newDocuments: newDocuments,
    removedDocumentUrls: removedDocumentUrls,
  );
}
