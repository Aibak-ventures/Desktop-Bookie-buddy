sealed class PrinterException implements Exception {
  final String message;

  PrinterException(this.message);

  @override
  String toString() => message;
}

class PrinterBridgeUnavailableException extends PrinterException {
  PrinterBridgeUnavailableException([
    super.message = 'QZ Tray isn\'t running. Install/start it, then try again.',
  ]);
}

class PrinterOperationException extends PrinterException {
  PrinterOperationException(super.message);
}
