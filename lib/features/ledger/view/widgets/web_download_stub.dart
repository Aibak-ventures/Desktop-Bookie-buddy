import 'dart:typed_data';

/// Stub implementation for non-web platforms
void downloadPdfWeb(Uint8List pdfBytes, String fileName) {
  throw UnsupportedError('Web downloads are only supported on web platform');
}
