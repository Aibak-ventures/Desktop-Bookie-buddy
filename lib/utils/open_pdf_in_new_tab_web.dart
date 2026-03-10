// Web-specific PDF viewer - opens PDF in new tab
import 'dart:html' as html;
import 'dart:typed_data';

void openPdfInNewTab(Uint8List bytes, String fileName) {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  
  // Open PDF in new tab
  html.window.open(url, '_blank');
  
  // Revoke the URL after a short delay to free memory
  Future.delayed(const Duration(seconds: 1), () {
    html.Url.revokeObjectUrl(url);
  });
}
