import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';

class CreateSaleBookingUseCase {
  final IBookingRepository _repository;
  CreateSaleBookingUseCase(this._repository);
  //TODO: Change the parameter type to a more specific one instead of Map<String, dynamic>
  Future<int> call(Map<String, dynamic> saleData) =>
      _repository.createSale(saleData);
}
