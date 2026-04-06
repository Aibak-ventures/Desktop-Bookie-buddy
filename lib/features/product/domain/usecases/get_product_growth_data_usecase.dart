import 'package:bookie_buddy_web/features/product/domain/entities/product_monthly_data_entity/product_monthly_data_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetProductGrowthDataUseCase {
  final IProductRepository _repository;
  GetProductGrowthDataUseCase(this._repository);

  Future<List<ProductMonthlyDataEntity>> call(int productId) =>
      _repository.getProductGrowthData(productId);
}
