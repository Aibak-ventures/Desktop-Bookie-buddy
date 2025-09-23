import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// *Show update dialog for iOS*
Future<void> showIOSUpdateDialog(
  BuildContext context,
  VoidCallback onPressed, {
  required String currentVersion,
  required String latestVersion,
}) async {
  await showAdaptiveDialog(
    context: context,
    barrierDismissible: false, // Prevent closing on tap outside
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Reduce border radius
          ),
          title: const Row(
            children: [
              Text(
                "Update Required",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
              Icon(Icons.update, color: Colors.black, size: 20),
            ],
          ),
          content: Text(
            "Current: $currentVersion\nLatest: $latestVersion\n\nPlease update to continue.",
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          actions: [
            CustomElevatedButton(onPressed: onPressed, text: 'Update Now'),
          ],
        ),
      );
    },
  );
}
