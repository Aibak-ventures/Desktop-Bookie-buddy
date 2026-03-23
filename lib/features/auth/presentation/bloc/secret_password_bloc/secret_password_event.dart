part of 'secret_password_bloc.dart';

@freezed
abstract class SecretPasswordEvent with _$SecretPasswordEvent {
  const factory SecretPasswordEvent.submitPasswordChange({
    required String oldPassword,
    required String newPassword,
  }) = _SubmitPasswordChange;
}
