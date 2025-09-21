part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(String phone, String password) = LoginEvent;
  const factory AuthEvent.logout() = LogoutEvent;
  const factory AuthEvent.resetState() = ResetStateEvent;
}
