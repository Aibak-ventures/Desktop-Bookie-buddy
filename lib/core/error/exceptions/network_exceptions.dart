sealed class NetworkException implements Exception {
  final String message;
  final int? errorCode;
  NetworkException(this.message, [this.errorCode]);
}

class FailedNetworkException extends NetworkException {
  FailedNetworkException([
    super.message = 'Network error',
    super.errorCode,
  ]);
}

class ServerException extends NetworkException {
  ServerException([
    super.message = 'Server error',
    super.errorCode,
  ]);
}
