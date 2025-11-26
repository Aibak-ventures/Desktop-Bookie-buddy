part of 'staff_list_bloc.dart';

@freezed
class StaffListEvent with _$StaffListEvent {
  const factory StaffListEvent.loadStaffs() = _LoadStaffs;
  const factory StaffListEvent.loadNextPageStaffs() = _LoadNextPageStaffs;
  const factory StaffListEvent.deleteStaff(int staffId) = _DeleteStaff;
  const factory StaffListEvent.editStaff(StaffRequestModel staff) = _EditStaff;
  const factory StaffListEvent.addStaff(StaffRequestModel staff) = _AddStaff;
  // const factory StaffListEvent.loadAllStaffs() = _LoadAllStaffs;
}
