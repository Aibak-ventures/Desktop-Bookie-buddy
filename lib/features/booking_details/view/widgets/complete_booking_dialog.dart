import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showCompleteBookingDialog({
  required BuildContext context,
  required Future<void> Function() onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Complete Booking',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            const Text(
              'Are you sure you want to complete this booking?',
              style: TextStyle(color: AppColors.black),
            ),
            Text(
              'NB: Ensure that your booked product is returned in your hand',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              context.pop();
              await onConfirm();
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
