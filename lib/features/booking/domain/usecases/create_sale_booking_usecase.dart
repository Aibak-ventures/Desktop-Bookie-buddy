import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';

class CreateSaleBookingUseCase {
  final IBookingRepository _repository;
  CreateSaleBookingUseCase(this._repository);
  Future<int> call(SalesRequestEntity saleData) =>
      _repository.createSale(saleData);
}
