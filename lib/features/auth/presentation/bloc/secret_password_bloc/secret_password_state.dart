part of 'secret_password_bloc.dart';

@freezed
abstract class SecretPasswordState with _$SecretPasswordState {
  const factory SecretPasswordState.initial() = _Initial;
  const factory SecretPasswordState.loading() = _Loading;
  const factory SecretPasswordState.success() = _Success;
  const factory SecretPasswordState.failure(String message) = _Failure;
}
