part of 'add_button_default_action_cubit.dart';

enum AddButtonDefaultActionStatus {
  initial,
  saving,
  success,
  failure;

  bool get isSaving => this == saving;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

@freezed
class AddButtonDefaultActionState with _$AddButtonDefaultActionState {
  const factory AddButtonDefaultActionState({
    required AddButtonDefaultAction action,
    required AddButtonDefaultActionStatus status,
    String? error,
    DateTime? lastSavedAt,
  }) = _AddButtonDefaultActionState;

  factory AddButtonDefaultActionState.initial({
    required AddButtonDefaultAction initialAction,
  }) => AddButtonDefaultActionState(
    action: initialAction,
    status: AddButtonDefaultActionStatus.initial,
  );
}
