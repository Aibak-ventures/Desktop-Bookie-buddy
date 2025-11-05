// Web implementation
import 'dart:html' as html;
import 'dart:typed_data';

Future<void> printPdfWeb(Uint8List pdfBytes) async {
  final blob = html.Blob([pdfBytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  
  html.window.open(url, '_blank');
  await Future.delayed(const Duration(milliseconds: 500));
  html.window.print();
  
  html.Url.revokeObjectUrl(url);
}
