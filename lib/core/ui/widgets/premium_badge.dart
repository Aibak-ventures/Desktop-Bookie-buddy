import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/premium_feature_dialog.dart';
// import 'package:bookie_buddy_web/core/ui/dialogs/premium_feature_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/app_assets.dart'; // crown asset path

// class PremiumBadge extends StatelessWidget {
//   final String label;
//   final double fontSize;
//   final bool showLabel;
//   final bool needOnTap;

//   const PremiumBadge({
//     super.key,
//     this.label = 'Premium',
//     this.fontSize = 12,
//     this.showLabel = true,
//     this.needOnTap = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final icon = Image.asset(
//       AppAssets.crown,
//       height: 14,
//       width: 14,
//       color: Colors.white, // ensures it fits premium theme
//     );

//     final badge = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//       decoration: BoxDecoration(
//         borderRadius: 12.radiusBorder,
//         gradient: const LinearGradient(
//           colors: [Color(0xFF1B44B1), Color.fromARGB(255, 167, 108, 255)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.purple.withOpacity(0.4),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           icon,
//           if (showLabel) ...[
//             4.width,
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );

//     return needOnTap
//         ? badge.onTap(() {
//             PremiumFeatureDialog.show(context, isPremiumUser: true);
//           })
//         : badge;
//   }
// }

class PremiumBadge extends StatelessWidget {
  final String label;
  final double fontSize;
  final bool showLabel;
  final bool needOnTap;

  const PremiumBadge({
    super.key,
    this.label = 'Premium',
    this.fontSize = 12,
    this.showLabel = true,
    this.needOnTap = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Shimmer(
      period: const Duration(seconds: 2),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 201, 210, 237),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.crown,
            height: 14,
            width: 14,
            color: Colors.white,
          ),
          if (showLabel) ...[
            4.width,
            Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: 12.radiusBorder,
        gradient: const LinearGradient(
          colors: [Color(0xFF1B44B1), Color.fromARGB(255, 167, 108, 255)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.4),
            blurRadius: 5,
          ),
        ],
      ),
      child: content,
    );

    return needOnTap
        ? badge.onTap(() {
            PremiumFeatureDialog.show(context, isPremiumUser: true);
          })
        : badge;
  }
}
