import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class SearchAllProductsUseCase {
  final IProductRepository _repository;
  SearchAllProductsUseCase(this._repository);

  Future<PaginationModel<ProductEntity>> call({
    required String? query,
    required int page,
    bool includeInStockOnly = true,
  }) => _repository.searchAllProducts(
    query: query,
    page: page,
    includeInStockOnly: includeInStockOnly,
  );
}
