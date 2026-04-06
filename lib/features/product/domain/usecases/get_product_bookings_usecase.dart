import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetProductBookingsUseCase {
  final IProductRepository _repository;
  GetProductBookingsUseCase(this._repository);

  Future<PaginationModel<BookingEntity>> call({
    required int productId,
    int page = 1,
    String? status,
  }) => _repository.getProductBookings(
    productId: productId,
    page: page,
    status: status,
  );
}
