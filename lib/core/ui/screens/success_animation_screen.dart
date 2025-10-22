import 'dart:async';
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_sized_box.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SuccessAnimationScreen extends StatefulWidget {
  final String text;
  final VoidCallback? afterSuccess;

  const SuccessAnimationScreen({
    super.key,
    required this.text,
    this.afterSuccess,
  });

  @override
  State<SuccessAnimationScreen> createState() => _SuccessAnimationScreenState();
}

class _SuccessAnimationScreenState extends State<SuccessAnimationScreen> {
  @override
  void initState() {
    super.initState();

    // Delay navigation safely
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (widget.afterSuccess == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BottomBarScreen()),
          (route) => false,
        );
      } else {
        widget.afterSuccess?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.afterSuccess == null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const BottomBarScreen()),
            (route) => false,
          );
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                AppAssets.aniAnimation,
                width: 200.w,
                height: 200.w,
                repeat: false,
              ),
            ),
            const CustomSizedBoxHeight(0.08),
            Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
