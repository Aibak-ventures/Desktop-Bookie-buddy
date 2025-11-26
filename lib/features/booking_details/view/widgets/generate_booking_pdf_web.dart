import 'dart:typed_data';
import 'dart:html' as html;

Future<void> handlePdfFile(
  Uint8List bytes, {
  required String fileName,
  bool printMode = false,
}) async {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);

  if (printMode) {
    html.window.open(url, "_blank");
    await Future.delayed(const Duration(seconds: 1));
    html.window.print();
  } else {
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
  }

  html.Url.revokeObjectUrl(url);
}
