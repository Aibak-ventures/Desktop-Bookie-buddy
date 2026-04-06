import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_request_entity/staff_request_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class EditStaffUseCase {
  final IStaffRepository _repository;

  EditStaffUseCase(this._repository);

  Future<StaffEntity> call(StaffRequestEntity staffData) async {
    return await _repository.editStaff(staffData);
  }
}
