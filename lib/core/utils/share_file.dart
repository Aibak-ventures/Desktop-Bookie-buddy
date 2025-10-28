import 'dart:io' show File;
import 'dart:typed_data';
import 'dart:html' as html; // for web
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';

Future<void> shareFile({
  required BuildContext context,
  required String filePath,
  VoidCallback? onBeforeShare,
  Uint8List? fileBytes, // required for web since filePath doesn’t exist
}) async {
  try {
    onBeforeShare?.call();

    final fileName = path.basename(filePath);

    if (kIsWeb) {
      // ✅ Web-specific logic: trigger download/share in browser
      if (fileBytes == null) {
        throw Exception('fileBytes is required when sharing on Web.');
      }

      final blob = html.Blob([fileBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Automatically trigger a download
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();

      html.Url.revokeObjectUrl(url);
      debugPrint('PDF download triggered in browser.');
    } else {
      // ✅ Mobile/Desktop logic
      final box = context.isMobile
          ? null
          : context.findRenderObject() as RenderBox?;

      await Share.shareXFiles(
        [XFile(filePath)],
        subject: fileName,
        text: fileName,
        sharePositionOrigin:
            box == null ? null : box.localToGlobal(Offset.zero) & box.size,
      );
    }
  } catch (e) {
    debugPrint('Error sharing ledger PDF: $e');
    context.showSnackBar('Failed to share file', isError: true);
  }
}
