import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class DeleteProductUseCase {
  final IProductRepository _repository;
  DeleteProductUseCase(this._repository);

  Future<void> call({required int productId, int? variantId}) =>
      _repository.deleteProduct(productId: productId, variantId: variantId);
}
