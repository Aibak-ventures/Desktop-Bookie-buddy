import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetMatchingProductsFromAnotherShopUseCase {
  final IProductRepository _repository;
  GetMatchingProductsFromAnotherShopUseCase(this._repository);

  Future<PaginationModel<ProductEntity>> call({
    required int fromVariantId,
    required int toShopId,
    int page = 1,
  }) => _repository.getMatchingProductsFromAnotherShop(
    fromVariantId: fromVariantId,
    toShopId: toShopId,
    page: page,
  );
}
