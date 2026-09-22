import 'package:flutter/material.dart';

/// Sidebar logout action, shown as an icon-only button when collapsed and
/// an icon+label button when [expanded].
class SidebarLogoutButton extends StatelessWidget {
  final bool expanded;
  final VoidCallback onLogout;

  const SidebarLogoutButton({
    super.key,
    required this.expanded,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: expanded ? 20 : 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onLogout,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: expanded ? 12 : 14),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.shade200.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: expanded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.red.shade400,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red.shade500,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                : Icon(
                    Icons.logout_rounded,
                    color: Colors.red.shade400,
                    size: 20,
                  ),
          ),
        ),
      ),
    );
  }
}
