part of 'staff_list_bloc.dart';

enum StaffListStatus {
  updating,
  success,
  failure;

  bool get isUpdating => this == updating;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}


@freezed
class StaffListState with _$StaffListState {
  const factory StaffListState.loading() = _Loading;
  const factory StaffListState.loaded({
    required List<StaffModel> staffs,
    String? nextPageUrl,
    @Default(false) bool isPaginating,
    @Default(StaffListStatus.success) StaffListStatus status,
    String? message,
  }) = _Loaded;
  const factory StaffListState.error(String message) = _Error;
}
