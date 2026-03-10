sealed class BookingException implements Exception {
  final String message;
  final int? errorCode;
  BookingException(this.message, [this.errorCode]);
}

class FailedBookingException extends BookingException {
  FailedBookingException([
    super.message = 'Failed to load booking data',
    super.errorCode,
  ]);
}

class InvalidBookingException extends BookingException {
  InvalidBookingException([
    super.message = 'Invalid Booking',
    super.errorCode,
  ]);
}

class BookingNotFoundException extends BookingException {
  BookingNotFoundException([
    super.message = 'Booking not found',
    super.errorCode,
  ]);
}

class BookingSaveException extends BookingException {
  BookingSaveException([
    super.message = 'Could not save booking',
    super.errorCode,
  ]);
}
