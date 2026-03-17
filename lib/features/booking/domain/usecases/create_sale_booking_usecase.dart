import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class CreateSaleBookingUseCase {
  final IBookingRepository _repository;
  CreateSaleBookingUseCase(this._repository);

  Future<int> call(Map<String, dynamic> saleData) =>
      _repository.createSale(saleData);
}
