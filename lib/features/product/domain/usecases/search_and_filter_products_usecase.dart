import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class SearchAndFilterProductsUseCase {
  final IProductRepository _repository;
  SearchAndFilterProductsUseCase(this._repository);

  Future<PaginationModel<ProductModel>> call({
    int? serviceId,
    required String? query,
    required String? type,
    required int? startPrice,
    required int? endPrice,
    int page = 1,
    bool includeInStockOnly = true,
  }) =>
      _repository.searchAndFilterProducts(
        serviceId: serviceId,
        query: query,
        type: type,
        startPrice: startPrice,
        endPrice: endPrice,
        page: page,
        includeInStockOnly: includeInStockOnly,
      );
}
