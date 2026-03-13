import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class DeleteStaffUseCase {
  final IStaffRepository _repository;

  DeleteStaffUseCase(this._repository);

  Future<void> call(int staffId) async {
    return await _repository.deleteStaff(staffId);
  }
}
