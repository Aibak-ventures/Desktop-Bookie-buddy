import 'package:flutter/material.dart';

class WebToast extends StatelessWidget {
  final String message;
  final bool isError;
  final Color? color;
  final VoidCallback onClose;

  const WebToast({
    super.key,
    required this.message,
    required this.onClose,
    this.isError = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color ??
              (isError ? AppColors.redLight : AppColors.greenSuccessLight),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isError ? Colors.red.shade300 : Colors.green.shade300,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black.withOpacity(.12),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              size: 18,
              color: isError ? Colors.red : Colors.green,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onClose,
              child: const Icon(Icons.close, size: 16),
            )
          ],
        ),
      ),
    );
  }
}

