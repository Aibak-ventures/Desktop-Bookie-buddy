import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:flutter/material.dart';

void CustomSnackBar({
  required String message,
  String? title,
  bool isError = true,
  bool isTitleVisible = true,
  Duration duration = const Duration(seconds: 4),
}) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  final snackBar = SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTitleVisible && (title != null || isError)) ...[
          Text(
            title ?? (isError ? 'Error' : 'Success'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    ),
    backgroundColor: isError ? Colors.red[600] : Colors.green[600],
    duration: duration,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(16),
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
