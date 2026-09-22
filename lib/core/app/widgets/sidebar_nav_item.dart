import 'package:bookie_buddy_web/core/app/shell_nav_items.dart';
import 'package:flutter/material.dart';

/// One sidebar destination: icon-only when collapsed, icon+label when
/// [expanded], highlighted when [isActive].
class SidebarNavItem extends StatelessWidget {
  final ShellNavItem item;
  final bool isActive;
  final bool expanded;
  final void Function(ShellTabId tab) onTap;

  const SidebarNavItem({
    super.key,
    required this.item,
    required this.isActive,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onTap(item.id),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: expanded ? 10 : 12,
          ),
          decoration: _decorationFor(isActive),
          child: expanded
              ? Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 20,
                      color: isActive ? Colors.white : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? Colors.white
                              : const Color(0xFF636E72),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Icon(
                    item.icon,
                    size: 22,
                    color: isActive ? Colors.white : Colors.grey.shade600,
                  ),
                ),
        ),
      ),
    );
  }

  BoxDecoration? _decorationFor(bool isActive) {
    if (!isActive) return null;
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF6C5CE7), Color(0xFF8B7CF7)],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF6C5CE7).withValues(alpha: 0.35),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
