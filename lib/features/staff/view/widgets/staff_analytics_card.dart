import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

class StaffAnalyticsCard extends StatelessWidget {
  const StaffAnalyticsCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 12.radiusBorder,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.15), blurRadius: 10),
          ],
        ),
        child: child,
      );
}
