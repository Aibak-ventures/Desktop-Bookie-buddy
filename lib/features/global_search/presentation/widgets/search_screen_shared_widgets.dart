import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:lottie/lottie.dart';
import 'package:material_ui/material_ui.dart';

class GlobalSearchInitialAnimation extends StatelessWidget {
  const GlobalSearchInitialAnimation({super.key});

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: Lottie.asset(
      AppAssets.searchAnimation,
      height: context.mediaQueryHeight(0.2),
      width: context.mediaQueryWidth(0.45),
    ),
  );
}
