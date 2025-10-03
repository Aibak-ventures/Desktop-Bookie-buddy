import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Future<bool?> showDiscardDialog(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Discard Changes?'),
      content: const Text('Are you sure you want to discard your changes?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            'Discard',
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    ),
  );
