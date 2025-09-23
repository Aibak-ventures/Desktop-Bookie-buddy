part of 'client_save_bloc.dart';

@freezed
class ClientSaveState with _$ClientSaveState {
  const factory ClientSaveState.initial() = _Initial;
  const factory ClientSaveState.saving() = _Saving;
  const factory ClientSaveState.success(
    String message,
    ClientModel client,
  ) = _Success;
  const factory ClientSaveState.failure(String message) = _Failure;
}
