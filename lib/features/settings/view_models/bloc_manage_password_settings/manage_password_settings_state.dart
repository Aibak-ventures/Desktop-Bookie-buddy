part of 'manage_password_settings_bloc.dart';

enum ManagePwdSettingsStatus {
  initial,
  ready,
  saving,
  success,
  failure,
}

@freezed
class ManagePasswordSettingsState with _$ManagePasswordSettingsState {
  const factory ManagePasswordSettingsState.loaded({
    @Default(ManagePwdSettingsStatus.initial) ManagePwdSettingsStatus status,
    @Default(<UserPasswordSettingsModel>[])
    List<UserPasswordSettingsModel> settings,
    @Default(<UserPasswordSettingsModel>[])
    List<UserPasswordSettingsModel> original,
    String? error,
    String? message,
    DateTime? lastSavedAt,
  }) = _Loaded;
}

extension ManagePwdStateX on ManagePasswordSettingsState {
  bool get hasChanges =>
      !const DeepCollectionEquality().equals(settings, original);
  bool get isBusy => status == ManagePwdSettingsStatus.saving;
}
