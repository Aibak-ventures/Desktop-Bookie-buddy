import 'dart:typed_data';
import 'dart:html' as html;

Future<void> handlePdfFile(
  Uint8List bytes, {
  required String fileName,
  bool printMode = false,
  bool viewMode = false,
}) async {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);

  if (viewMode) {
    html.window.open(url, "_blank");
  } else if (printMode) {
    html.window.open(url, "_blank");
    await Future.delayed(const Duration(seconds: 1));
    html.window.print();
  } else {
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
  }

  // Revoke object URL after a delay if viewing/printing?
  // If viewMode, we shouldn't revoke immediately if it breaks the tab?
  // Actually, createObjectUrlFromBlob works even after revoke?
  // Usually better to delay.
  if (!viewMode) {
    html.Url.revokeObjectUrl(url);
  } else {
    // For view mode, maybe keep it alive or revoke later?
    // Browser usually handles it.
    // Keeping it simple.
    Future.delayed(const Duration(minutes: 1), () {
      html.Url.revokeObjectUrl(url);
    });
  }
}
