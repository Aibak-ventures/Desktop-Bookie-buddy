import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetProductInfoUseCase {
  final IProductRepository _repository;
  GetProductInfoUseCase(this._repository);

  Future<ProductModel> call(int productId) =>
      _repository.getProductInfo(productId);
}
