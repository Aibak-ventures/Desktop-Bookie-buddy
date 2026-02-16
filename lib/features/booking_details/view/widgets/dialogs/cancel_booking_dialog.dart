import 'package:flutter/material.dart';

class CancelBookingDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CancelBookingDialog({
    required this.onCancel,
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.cancel_outlined,
              color: Colors.red.shade700,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Text('Cancel Booking'),
        ],
      ),
      content: const Text(
        'Are you sure you want to cancel this booking? This action cannot be undone.',
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        OutlinedButton(
          onPressed: onCancel,
          child: const Text('Keep Booking'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Cancel Booking'),
        ),
      ],
    );
  }
}
