part of 'reset_password_bloc.dart';

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.submitted() = _Submitted;
  const factory ResetPasswordState.success() = _Success;
  const factory ResetPasswordState.error(String error) = _Error;
}
