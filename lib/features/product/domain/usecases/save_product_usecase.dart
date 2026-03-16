import 'package:bookie_buddy_web/features/product/domain/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class SaveProductUseCase {
  final IProductRepository _repository;
  SaveProductUseCase(this._repository);

  Future<void> call({required ProductRequestModel product}) =>
      _repository.saveProduct(product: product);
}
