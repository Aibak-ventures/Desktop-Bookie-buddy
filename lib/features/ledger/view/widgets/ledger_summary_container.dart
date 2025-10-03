import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

class LedgerSummaryContainer extends StatelessWidget {
  const LedgerSummaryContainer({
    required this.child,
    super.key,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
      padding: 18.padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8A63FE),
            Color(0xFF6132E4),
          ],
        ),
        borderRadius: 10.radiusBorder,
      ),
      child: child,
    );
}
