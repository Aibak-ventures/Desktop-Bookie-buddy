import 'dart:async';

import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_sized_box.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String text;
  final VoidCallback? afterSuccess;
  const SuccessScreen({
    super.key,
    required this.text,
    this.afterSuccess,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Timer(
          const Duration(seconds: 1, milliseconds: 500),
          () {
            if (afterSuccess == null) {
              context.pushAndRemoveUntil(const BottomBarScreen());
            } else {
              afterSuccess?.call();
            }
          },
        );
      },
    );
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (afterSuccess == null)
          context.pushAndRemoveUntil(const BottomBarScreen());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/animations/ani.json',
                width: 200,
                height: 200,
                repeat: false,
              ),
            ),
            const CustomSizedBoxHeight(0.08),
            Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
