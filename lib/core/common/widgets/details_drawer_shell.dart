import 'package:flutter/material.dart';

/// Shared slide-in-from-the-right chrome for every feature's details drawer
/// (booking, sales, ...) — the animation, shadow, and close-button header are
/// identical across drawers; only [child] and [trailing] differ per feature.
class DetailsDrawerShell extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final Widget child;
  final Widget? trailing;
  final double width;

  const DetailsDrawerShell({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.child,
    this.trailing,
    this.width = 470,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      right: isOpen ? 0 : -(width + 180),
      top: 0,
      bottom: 0,
      width: width,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Material(
          elevation: 16,
          shadowColor: Colors.black.withValues(alpha: 0.3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(-4, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_right, size: 28),
                        onPressed: onClose,
                        tooltip: 'Close',
                        color: Colors.grey.shade600,
                        hoverColor: Colors.grey.shade100,
                      ),
                      if (trailing != null) trailing!,
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
