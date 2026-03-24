import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetProductInfoUseCase {
  final IProductRepository _repository;
  GetProductInfoUseCase(this._repository);

  Future<ProductEntity> call(int productId) =>
      _repository.getProductInfo(productId);
}
