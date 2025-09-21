part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  logging,
  loggedIn,
  logoutLoading,
  logout,
  invalidCredentials,
  error,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStatus status,
    String? message,
    String? phone,
    EventStatus? eventStatus,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(
      status: AuthStatus.initial,
      eventStatus: EventStatus.none,
  );
}
