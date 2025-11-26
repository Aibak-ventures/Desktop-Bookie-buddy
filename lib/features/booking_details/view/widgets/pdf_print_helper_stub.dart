// Stub implementation for non-web platforms
import 'dart:typed_data';

Future<void> printPdfWeb(Uint8List pdfBytes) async {
  throw UnsupportedError('Printing is only supported on web platform');
}
