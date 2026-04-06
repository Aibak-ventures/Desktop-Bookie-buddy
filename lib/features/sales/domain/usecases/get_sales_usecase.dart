import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_entity/sale_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class GetSalesUseCase {
  final ISalesRepository _repository;

  GetSalesUseCase(this._repository);

  Future<PaginationModel<SaleEntity>> call({
    required int page,
    String? search,
    String? fromDate,
    String? toDate,
  }) => _repository.getSalesPagination(
    page: page,
    search: search,
    fromDate: fromDate,
    toDate: toDate,
  );
}
