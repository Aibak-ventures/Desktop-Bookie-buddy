import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class DeleteSaleUseCase {
  final ISalesRepository _repository;

  DeleteSaleUseCase(this._repository);

  Future<void> call(int saleId) => _repository.deleteSale(saleId);
}
