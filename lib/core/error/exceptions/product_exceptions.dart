sealed class ProductException implements Exception {
  final String message;
  final int? errorCode;

  ProductException(this.message, [this.errorCode]);
}

class ProductNotFoundException extends ProductException {
  ProductNotFoundException([
    super.message = "Product not found",
    super.errorCode,
  ]);
}

class ProductAlreadyExistsException extends ProductException {
  ProductAlreadyExistsException([
    super.message = "Product already exists",
    super.errorCode,
  ]);
}
