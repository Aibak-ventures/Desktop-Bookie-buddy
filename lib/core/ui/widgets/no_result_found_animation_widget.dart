import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

/// A widget that displays an animation and a message when no results are found.
class NoResultFoundAnimationWidget extends StatelessWidget {
  const NoResultFoundAnimationWidget({
    super.key,
    this.adjustHeightTop,
    this.adjustHeightBottom,
    this.isScrollable = true,
  });
  final double? adjustHeightTop;
  final double? adjustHeightBottom;
  final bool isScrollable;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: !isScrollable,
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        if (adjustHeightTop != null)
          SizedBox(height: context.screenHeight * adjustHeightTop!),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/nodata.json',
              width: 200.w,
              height: 200.w,
              // height: context.mediaQueryHeight(0.3),
              // width: context.mediaQueryWidth(0.45),
            ),
            const Text('No result found'),
          ],
        ),
        if (adjustHeightBottom != null) SizedBox(height: adjustHeightBottom),
      ],
    );
  }
}

class NoProductFoundAnimationWidget extends StatelessWidget {
  const NoProductFoundAnimationWidget({
    super.key,
    this.adjustHeightTop,
    this.adjustHeightBottom,
  });
  final double? adjustHeightTop;
  final double? adjustHeightBottom;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        if (adjustHeightTop != null)
          SizedBox(height: context.screenHeight * adjustHeightTop!),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/no_product_animation.json',
              height: context.mediaQueryHeight(0.3),
              width: context.mediaQueryWidth(0.45),
            ),
            const Text('No product found'),
          ],
        ),
        if (adjustHeightBottom != null) SizedBox(height: adjustHeightBottom),
      ],
    );
  }
}
