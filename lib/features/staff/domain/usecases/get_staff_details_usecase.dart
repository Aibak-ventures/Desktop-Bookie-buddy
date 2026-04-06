import 'package:bookie_buddy_web/features/staff/domain/entities/staff_details_entity/staff_details_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class GetStaffDetailsUseCase {
  final IStaffRepository _repository;

  GetStaffDetailsUseCase(this._repository);

  Future<StaffDetailsEntity> call(int staffId) async {
    return await _repository.getStaffDetails(staffId);
  }
}
