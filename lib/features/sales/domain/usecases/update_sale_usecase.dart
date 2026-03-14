import 'package:bookie_buddy_web/features/sales/domain/models/sales_request_model/sales_request_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class UpdateSaleUseCase {
  final ISalesRepository _repository;

  UpdateSaleUseCase(this._repository);

  Future<void> call(SalesRequestModel salesRequest) =>
      _repository.updateSale(salesRequest);
}
