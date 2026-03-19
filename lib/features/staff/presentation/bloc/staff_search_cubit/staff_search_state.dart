part of 'staff_search_cubit.dart';

@freezed
class StaffSearchState with _$StaffSearchState {
  const factory StaffSearchState({
    @Default([]) List<StaffEntity> staffs,
    StaffEntity? selectedStaff,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _StaffSearchState;
}
