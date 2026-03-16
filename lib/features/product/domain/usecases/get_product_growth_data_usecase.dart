import 'package:bookie_buddy_web/features/product/domain/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetProductGrowthDataUseCase {
  final IProductRepository _repository;
  GetProductGrowthDataUseCase(this._repository);

  Future<List<ProductMonthlyDataModel>> call(int productId) =>
      _repository.getProductGrowthData(productId);
}
