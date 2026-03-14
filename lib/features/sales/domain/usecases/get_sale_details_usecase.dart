import 'package:bookie_buddy_web/features/sales/domain/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class GetSaleDetailsUseCase {
  final ISalesRepository _repository;

  GetSaleDetailsUseCase(this._repository);

  Future<SaleDetailsModel> call(int saleId) => _repository.getSaleDetails(saleId);
}
