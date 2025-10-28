import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showCompleteBookingDialog({
  required BuildContext context,
  required Future<void> Function() onConfirm,
  VoidCallback? onCancel,
}) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Complete Booking',
        ),
        content: SizedBox(
          width: 400, // Constrain dialog width
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
            const Text(
              'Are you sure you want to complete this booking?',
              style: TextStyle(color: AppColors.black),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 20.sp,
                  ),
                  8.width,
                  Expanded(
                    child: Text(
                      'Note: Please ensure all products are returned before marking the booking as complete.',
                      softWrap: true,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   'NB: Ensure that your booked product is returned in your hand',
            //   style: TextStyle(
            //     fontWeight: FontWeight.w600,
            //     color: Colors.grey,
            //     fontSize: 12.sp,
            //   ),
            // ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onCancel?.call();
              context.pop();
            },
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
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
  );
