import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareFile({
  required final BuildContext context,
  required final String filePath,
  final VoidCallback? onBeforeShare,
}) async {
  try {
    final box = context.isMobile
        ? null
        : context.findRenderObject() as RenderBox?;
    final fileName = filePath.split('/').last;
    onBeforeShare?.call();
    await SharePlus.instance.share(
      ShareParams(
        title: fileName,
        subject: fileName,
        files: [XFile(filePath)],
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  } catch (e) {
    debugPrint('Error sharing ledger PDF: $e');
    rethrow;
  }
}
