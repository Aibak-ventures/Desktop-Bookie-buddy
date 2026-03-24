import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class UpdateSaleUseCase {
  final ISalesRepository _repository;

  UpdateSaleUseCase(this._repository);

  Future<void> call(SalesRequestEntity salesRequest) =>
      _repository.updateSale(salesRequest);
}
