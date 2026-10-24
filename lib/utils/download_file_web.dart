// Web-specific file download
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

void downloadFileWeb(Uint8List bytes, String fileName) {
  final blob = web.Blob(
    [bytes.toJS].toJS,
    web.BlobPropertyBag(type: 'application/pdf'),
  );
  final url = web.URL.createObjectURL(blob);
  (web.document.createElement('a') as web.HTMLAnchorElement)
    ..href = url
    ..download = fileName
    ..click();
  web.URL.revokeObjectURL(url);
}
