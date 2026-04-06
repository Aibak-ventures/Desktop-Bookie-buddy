import 'dart:developer';

import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

Future<T?> showCustomBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  double initialChildSize = 0.5,
  bool isDraggable = true,
}) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.95,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        if (isDraggable) {
          log('showCustomBottomSheet: draggable');

          return DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) => SingleChildScrollView(
                controller: scrollController, child: child),
          );
        } else {
          log('showCustomBottomSheet: non-draggable');
          return SingleChildScrollView(child: child);
        }
      },
    );
