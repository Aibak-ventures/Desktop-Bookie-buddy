part of 'staff_deleted_list_bloc.dart';

@freezed
class StaffDeletedListEvent with _$StaffDeletedListEvent {
  const factory StaffDeletedListEvent.loadStaffs() = _LoadStaffs;
  const factory StaffDeletedListEvent.loadNextPageStaffs() =
      _LoadNextPageStaffs;
  const factory StaffDeletedListEvent.restoreStaff(int staffId) = _RestoreStaff;
}
