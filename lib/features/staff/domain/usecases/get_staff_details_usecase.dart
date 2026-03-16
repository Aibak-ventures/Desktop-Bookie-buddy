import 'package:bookie_buddy_web/features/staff/domain/models/staff_details_model/staff_details_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class GetStaffDetailsUseCase {
  final IStaffRepository _repository;

  GetStaffDetailsUseCase(this._repository);

  Future<StaffDetailsModel> call(int staffId) async {
    return await _repository.getStaffDetails(staffId);
  }
}
