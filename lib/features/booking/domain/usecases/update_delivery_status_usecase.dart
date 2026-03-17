import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class UpdateDeliveryStatusUseCase {
  final IBookingRepository _repository;
  UpdateDeliveryStatusUseCase(this._repository);

  Future<void> call(int bookingId, DeliveryStatus deliveryStatus) =>
      _repository.updateDeliveryStatus(bookingId, deliveryStatus);
}
