import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetProductsPaginatedUseCase {
  final IProductRepository _repository;
  GetProductsPaginatedUseCase(this._repository);

  Future<PaginationModel<ProductModel>> call({
    int? serviceId,
    required int page,
    bool includeInStockOnly = true,
  }) =>
      _repository.getProductsPaginated(
        serviceId: serviceId,
        page: page,
        includeInStockOnly: includeInStockOnly,
      );
}
