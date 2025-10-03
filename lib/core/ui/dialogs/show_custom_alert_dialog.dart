import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Future<void> showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  String? confirmText,
}) async => showDialog(
  context: context,
  builder: (dialogCtx) => AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        onPressed: () {
          onCancel?.call();
          dialogCtx.pop();
        },
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
          onConfirm();
          dialogCtx.pop();
        },
        child: Text(
          confirmText ?? 'Confirm',
          style: const TextStyle(color: AppColors.white),
        ),
      ),
    ],
  ),
);
