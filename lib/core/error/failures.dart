sealed class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() {
    return message;
  }
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure(super.message, [this.statusCode]);
}

class DioFailure extends Failure {
  final int? statusCode;
  const DioFailure(super.message, [this.statusCode]);
}

class BookingFailure extends Failure {
  const BookingFailure(super.message);
}

class ProductFailure extends Failure {
  const ProductFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
