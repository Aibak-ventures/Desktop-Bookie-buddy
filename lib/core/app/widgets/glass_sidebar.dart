import 'package:bookie_buddy_web/core/app/shell_nav_items.dart';
import 'package:bookie_buddy_web/core/app/widgets/shop_switcher_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/app/widgets/sidebar_logout_button.dart';
import 'package:bookie_buddy_web/core/app/widgets/sidebar_nav_item.dart';
import 'package:bookie_buddy_web/core/app/widgets/sidebar_profile_header.dart';
import 'package:flutter/material.dart';

/// Hover-expandable glass sidebar for [AppShellScreen].
///
/// Owns its own hover-expanded state. Navigation taps and logout are
/// forwarded via callbacks to the parent screen which owns all routing
/// logic; the nav items themselves (icon/label/order) come entirely from
/// [navItems], so this widget has no per-tab knowledge baked in.
class GlassSidebar extends StatefulWidget {
  final List<ShellNavItem> navItems;
  final ShellTabId activeTab;
  final void Function(ShellTabId tab) onTabTap;
  final VoidCallback onLogout;

  const GlassSidebar({
    super.key,
    required this.navItems,
    required this.activeTab,
    required this.onTabTap,
    required this.onLogout,
  });

  @override
  State<GlassSidebar> createState() => _GlassSidebarState();
}

class _GlassSidebarState extends State<GlassSidebar> {
  bool _isExpanded = false;

  static const double _collapsedWidth = 80.0;
  static const double _expandedWidth = 260.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isExpanded = true),
      onExit: (_) => setState(() => _isExpanded = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _isExpanded ? _expandedWidth : _collapsedWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/bottom_bar_background.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRect(
          child: OverflowBox(
            minWidth: _collapsedWidth,
            maxWidth: _expandedWidth,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: _isExpanded ? _expandedWidth : _collapsedWidth,
              child: _buildContent(expanded: _isExpanded),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent({required bool expanded}) {
    return Column(
      children: [
        const SizedBox(height: 24),
        SidebarProfileHeader(expanded: expanded),
        SizedBox(height: expanded ? 16 : 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: expanded ? 22 : 12),
          child: const Divider(color: Colors.grey, thickness: 1),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                for (final item in widget.navItems)
                  SidebarNavItem(
                    item: item,
                    isActive: widget.activeTab == item.id,
                    expanded: expanded,
                    onTap: widget.onTabTap,
                  ),
              ],
            ),
          ),
        ),
        expanded
            ? const ShopSwitcherButtonExpanded()
            : const ShopSwitcherButtonCollapsed(),
        const SizedBox(height: 12),
        SidebarLogoutButton(expanded: expanded, onLogout: widget.onLogout),
        const SizedBox(height: 20),
      ],
    );
  }
}
