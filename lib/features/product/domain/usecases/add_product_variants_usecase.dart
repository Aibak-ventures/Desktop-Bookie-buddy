import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class AddProductVariantsUseCase {
  final IProductRepository _repository;
  AddProductVariantsUseCase(this._repository);

  Future<void> call({
    required int productId,
    required String attribute,
    required int stock,
  }) =>
      _repository.addProductVariants(
        productId: productId,
        attribute: attribute,
        stock: stock,
      );
}
