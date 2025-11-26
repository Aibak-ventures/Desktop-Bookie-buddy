import 'package:bookie_buddy_web/core/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalLoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context, {String? text}) {
    'Showing global loading overlay...'.logDebug();
    if (_overlayEntry != null) {
      'Overlay entry is not null, returning!'.logDebug();
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: ColoredBox(
          color: Colors.black38,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                if (text != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      'Back button pressed, hiding overlay'.logDebug();
                      hide();
                    },
                    label: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
    'Inserting overlay into current context'.logDebug();
    Overlay.of(context).insert(_overlayEntry!);
    'overlay inserted'.logDebug();
  }

  static void hide() {
    'hiding overlay'.logDebug();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
