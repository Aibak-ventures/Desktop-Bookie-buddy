import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class GetStaffsUseCase {
  final IStaffRepository _repository;

  GetStaffsUseCase(this._repository);

  Future<PaginationModel<StaffModel>> call({int page = 1}) async {
    return await _repository.getStaffs(page: page);
  }
}
