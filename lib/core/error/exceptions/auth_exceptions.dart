sealed class AuthException implements Exception {
  final String message;
  final int? errorCode;
  AuthException(this.message, [this.errorCode]);
}

class FailedAuthException extends AuthException {
  FailedAuthException([
    super.message = "Authentication failed",
    super.errorCode,
  ]);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException([
    super.message = "User not found",
    super.errorCode,
  ]);
}

class TokenExpiredException extends AuthException {
  TokenExpiredException([
    super.message = "Token expired",
    super.errorCode,
  ]);
}
