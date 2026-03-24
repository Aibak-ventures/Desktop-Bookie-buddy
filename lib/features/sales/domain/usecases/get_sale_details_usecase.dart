import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class GetSaleDetailsUseCase {
  final ISalesRepository _repository;

  GetSaleDetailsUseCase(this._repository);

  Future<SaleDetailsEntity> call(int saleId) =>
      _repository.getSaleDetails(saleId);
}
