import 'package:bookie_buddy_web/features/staff/domain/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_request_model/staff_request_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class AddStaffUseCase {
  final IStaffRepository _repository;

  AddStaffUseCase(this._repository);

  Future<StaffModel> call(StaffRequestModel staffData) async {
    return await _repository.addStaff(staffData);
  }
}
