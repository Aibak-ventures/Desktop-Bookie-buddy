part of 'staff_deleted_list_bloc.dart';

enum StaffDeletedListStatus {
  updating,
  loaded,
  success,
  failure;

  bool get isUpdating => this == updating;
  bool get isLoaded => this == loaded;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

@freezed
class StaffDeletedListState with _$StaffDeletedListState {
  const factory StaffDeletedListState.loading() = _Loading;
  const factory StaffDeletedListState.loaded({
    required List<StaffModel> staffs,
    String? nextPageUrl,
    @Default(false) bool isPaginating,
    @Default(StaffDeletedListStatus.loaded) StaffDeletedListStatus status,
    String? message,
  }) = _Loaded;
  const factory StaffDeletedListState.error(String message) = _Error;
}
