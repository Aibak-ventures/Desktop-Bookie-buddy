import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class GetStaffMonthlySalesUseCase {
  final IStaffRepository _repository;

  GetStaffMonthlySalesUseCase(this._repository);

  Future<PaginationModel<SaleModel>> call({
    required int staffId,
    required int year,
    required int month,
    int page = 1,
  }) async {
    return await _repository.getStaffMonthlySalesPagination(
      staffId: staffId,
      year: year,
      month: month,
      page: page,
    );
  }
}
