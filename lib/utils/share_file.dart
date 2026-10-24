import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:material_ui/material_ui.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareFile({
  required BuildContext context,
  required String filePath,
  VoidCallback? onBeforeShare,
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
