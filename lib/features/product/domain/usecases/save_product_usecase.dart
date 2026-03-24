import 'package:bookie_buddy_web/features/product/domain/entities/product_request_entity/product_request_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class SaveProductUseCase {
  final IProductRepository _repository;
  SaveProductUseCase(this._repository);

  Future<void> call({required ProductRequestEntity product}) =>
      _repository.saveProduct(product: product);
}
