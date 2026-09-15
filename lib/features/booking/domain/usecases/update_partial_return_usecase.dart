import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdatePartialReturnUseCase {
  final IBookingRepository _repository;
  const UpdatePartialReturnUseCase(this._repository);

  Future<CustomResponseModel> call({
    required int bookingId,
    required List<int> returnedProductIds,
    required List<int> notReturnedProductIds,
    required String? newReturnDate,
  }) => _repository.updatePartialReturn(
    bookingId: bookingId,
    returnedProductIds: returnedProductIds,
    notReturnedProductIds: notReturnedProductIds,
    newReturnDate: newReturnDate,
  );
}
