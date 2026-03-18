import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PremiumFeatureDialog {
  static void show(BuildContext context, {bool isPremiumUser = false}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: 16.radiusBorder),
        child: Padding(
          padding: 20.padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(CustomIcons.premium, size: 50, color: AppColors.premium),
              Image.asset(
                AppAssets.crown,
                height: 50,
                width: 50,
                // color: AppColors.premium,
              ),
              12.height,
              Text(
                isPremiumUser ? 'You\'re Premium!' : 'Premium Feature',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.height,
              Text(
                isPremiumUser
                    ? 'You already have access to this Premium feature.'
                    : 'This feature is available only with the Premium plan.\nUpgrade now to unlock it!',
                textAlign: TextAlign.center,
              ),
              20.height,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.pop();
                  if (isPremiumUser) {
                    // 👇 Already premium → maybe navigate directly to the feature
                    // context.push("/premium-feature");
                  } else {
                    // 👇 Not premium → navigate to upgrade screen
                    // context.push("/upgrade");
                  }
                },
                icon: Icon(isPremiumUser ? Icons.check_circle : Icons.upgrade),
                label: Text(isPremiumUser ? 'Continue' : 'Upgrade Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
