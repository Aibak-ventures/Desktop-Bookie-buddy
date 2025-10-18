part of 'staff_search_cubit.dart';

@freezed
class StaffSearchState with _$StaffSearchState {
  const factory StaffSearchState({
    @Default([]) List<StaffModel> staffs,
    StaffModel? selectedStaff,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _StaffSearchState;
}
