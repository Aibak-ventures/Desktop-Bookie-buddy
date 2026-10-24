// Web-specific PDF viewer - opens PDF in new tab
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

void openPdfInNewTab(Uint8List bytes, String fileName) {
  final blob = web.Blob(
    [bytes.toJS].toJS,
    web.BlobPropertyBag(type: 'application/pdf'),
  );
  final url = web.URL.createObjectURL(blob);

  // Open PDF in new tab
  web.window.open(url, '_blank');

  // Revoke the URL after a short delay to free memory
  Future.delayed(const Duration(seconds: 1), () {
    web.URL.revokeObjectURL(url);
  });
}
