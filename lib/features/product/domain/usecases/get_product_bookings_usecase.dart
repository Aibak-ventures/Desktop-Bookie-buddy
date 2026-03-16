import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetProductBookingsUseCase {
  final IProductRepository _repository;
  GetProductBookingsUseCase(this._repository);

  Future<PaginationModel<BookingsModel>> call({
    required int productId,
    int page = 1,
    String? status,
  }) =>
      _repository.getProductBookings(
        productId: productId,
        page: page,
        status: status,
      );
}
