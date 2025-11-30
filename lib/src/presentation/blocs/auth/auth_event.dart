import 'package:equatable/equatable.dart';

/// Base class for all Auth events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when user attempts to login
class LoginRequested extends AuthEvent {
  final String phone;
  final String password;
  final String? deviceToken;

  const LoginRequested({
    required this.phone,
    required this.password,
    this.deviceToken,
  });

  @override
  List<Object?> get props => [phone, password, deviceToken];
}

/// Event triggered when user attempts to logout
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

/// Event triggered to check if user is already logged in
class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}
