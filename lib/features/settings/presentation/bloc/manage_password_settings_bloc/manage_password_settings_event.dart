part of 'manage_password_settings_bloc.dart';

@freezed
sealed class ManagePasswordSettingsEvent with _$ManagePasswordSettingsEvent {
  const factory ManagePasswordSettingsEvent.load(
    List<UserPasswordSettingsModel> settings,
  ) = _Load;
  const factory ManagePasswordSettingsEvent.updateRole({
    required String newRole,
    required UserPasswordSettingsModel target,
  }) = _UpdateRole;
  const factory ManagePasswordSettingsEvent.save() = _Save;
  const factory ManagePasswordSettingsEvent.resetChanges() = _ResetChanges;
}
