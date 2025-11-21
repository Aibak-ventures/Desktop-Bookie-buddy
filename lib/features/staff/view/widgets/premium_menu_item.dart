import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class PremiumMenuItem extends PopupMenuEntry<String> {
  const PremiumMenuItem({
    super.key,
    required this.value,
    required this.label,
    this.icon,
  });
  final String value;
  final String label;
  final Widget? icon;

  @override
  State<PremiumMenuItem> createState() => _PremiumMenuItemState();

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(String? value) => value == this.value;
}

class _PremiumMenuItemState extends State<PremiumMenuItem> {
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          context.pop(widget.value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Shimmer(
                period: const Duration(seconds: 2),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1B44B1),
                    Color.fromARGB(255, 167, 108, 255),
                    Color(0xFF1B44B1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) widget.icon!,
                    6.width,
                    Text(
                      widget.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              6.width,
              Image.asset(AppAssets.crown, height: 20, width: 20),
            ],
          ),
        ),
      );
}
