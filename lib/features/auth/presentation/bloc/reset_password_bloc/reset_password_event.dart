part of 'reset_password_bloc.dart';

@freezed
abstract class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.resetPassword({
    required String oldPassword,
    required String newPassword,
    @Default(false) bool logoutFromAllDevices,
  }) = _ResetPassword;
}
