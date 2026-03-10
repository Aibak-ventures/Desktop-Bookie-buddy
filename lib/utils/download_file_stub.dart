// Stub for non-web platforms
import 'dart:typed_data';

void downloadFileWeb(Uint8List bytes, String fileName) {
  throw UnsupportedError('Download is only supported on web platform');
}
