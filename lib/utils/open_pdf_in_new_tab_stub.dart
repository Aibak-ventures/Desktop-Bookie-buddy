// Stub for non-web platforms
import 'dart:typed_data';

void openPdfInNewTab(Uint8List bytes, String fileName) {
  throw UnsupportedError('openPdfInNewTab is only supported on web');
}
