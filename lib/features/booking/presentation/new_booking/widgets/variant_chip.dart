import 'package:flutter/material.dart';

Widget variantChip(String text) {
  final isShortText = text.length <= 3;

  return Container(
    // Use fixed size for circles, flexible for rectangles
    width: isShortText ? 35 : null,
    height: 33,
    padding: isShortText ? null : const EdgeInsets.symmetric(horizontal: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      // Use circle for short text, rounded rectangle for long text
      shape: isShortText ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: isShortText ? null : BorderRadius.circular(8),
      color: const Color.fromARGB(255, 225, 215, 255),
      border: Border.all(color: Colors.grey.shade200, width: 0.6),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
    ),
  );
}
