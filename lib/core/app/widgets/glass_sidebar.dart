import 'package:bookie_buddy_web/core/app/widgets/shop_switcher_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Hover-expandable glass sidebar for [BottomBarScreen].
///
/// Owns its own [isSidebarExpanded] state. Navigation taps and logout are
/// forwarded via callbacks to the parent screen which owns all routing logic.
class GlassSidebar extends StatefulWidget {
  final int currentIndex;
  final bool newOrderActive;
  final void Function(int index, bool isNewOrder) onNavTap;
  final VoidCallback onLogout;

  const GlassSidebar({
    super.key,
    required this.currentIndex,
    required this.newOrderActive,
    required this.onNavTap,
    required this.onLogout,
  });

  @override
  State<GlassSidebar> createState() => _GlassSidebarState();
}

class _GlassSidebarState extends State<GlassSidebar> {
  bool _isSidebarExpanded = false;

  static const double _collapsedWidth = 80.0;
  static const double _expandedWidth = 260.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isSidebarExpanded = true),
      onExit: (_) => setState(() => _isSidebarExpanded = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _isSidebarExpanded ? _expandedWidth : _collapsedWidth,
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
              width: _isSidebarExpanded ? _expandedWidth : _collapsedWidth,
              child: _isSidebarExpanded
                  ? _buildExpandedSidebar()
                  : _buildCollapsedSidebar(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedSidebar() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _profileHeaderExpanded(),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Divider(color: Colors.grey, thickness: 1),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                _navItemExpanded(0, Icons.add_box_outlined, 'New Order'),
                _navItemExpanded(1, Icons.dashboard_outlined, 'Dashboard'),
                _navItemExpanded(2, Icons.list_alt, 'Orders'),
                _navItemExpanded(3, Icons.bar_chart_outlined, 'Stocks'),
              ],
            ),
          ),
        ),
        const ShopSwitcherButtonExpanded(),
        const SizedBox(height: 12),
        _logoutButtonExpanded(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCollapsedSidebar() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _profileHeaderCollapsed(),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Divider(color: Colors.grey, thickness: 1),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                _navItemCollapsed(0, Icons.add_box_outlined),
                _navItemCollapsed(1, Icons.dashboard_outlined),
                _navItemCollapsed(2, Icons.list_alt),
                _navItemCollapsed(3, Icons.bar_chart_outlined),
              ],
            ),
          ),
        ),
        const ShopSwitcherButtonCollapsed(),
        const SizedBox(height: 12),
        _logoutButtonCollapsed(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _profileHeaderExpanded() {
    return BlocBuilder<UserCubit, UserEntity?>(
      builder: (context, user) {
        final userName = user?.firstName ?? 'User';
        final firstLetter =
            userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              _buildAvatar(firstLetter, 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D3436),
                        letterSpacing: 0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _profileHeaderCollapsed() {
    return BlocBuilder<UserCubit, UserEntity?>(
      builder: (context, user) {
        final userName = user?.firstName ?? 'User';
        final firstLetter =
            userName.isNotEmpty ? userName[0].toUpperCase() : 'U';
        return _buildAvatar(firstLetter, 40);
      },
    );
  }

  Widget _buildAvatar(String letter, double size) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C5CE7), Color(0xFF00B4DB)],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6C5CE7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItemExpanded(int index, IconData icon, String label) {
    final isActive = widget.currentIndex == index;
    final isNewOrder = index == 0;
    final isNewOrderActive = isNewOrder && widget.newOrderActive;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => widget.onNavTap(index, isNewOrder),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: _getNavDecoration(isActive, isNewOrderActive),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: (isActive || isNewOrderActive)
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: (isActive || isNewOrderActive)
                        ? Colors.white
                        : const Color(0xFF636E72),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItemCollapsed(int index, IconData icon) {
    final isActive = widget.currentIndex == index;
    final isNewOrder = index == 0;
    final isNewOrderActive = isNewOrder && widget.newOrderActive;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => widget.onNavTap(index, isNewOrder),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: _getNavDecoration(isActive, isNewOrderActive),
          child: Center(
            child: Icon(
              icon,
              size: 22,
              color: (isActive || isNewOrderActive)
                  ? Colors.white
                  : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration? _getNavDecoration(bool isActive, bool isNewOrderActive) {
    if (isActive || isNewOrderActive) {
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
    return null;
  }

  Widget _logoutButtonExpanded() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onLogout,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.shade200.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: Colors.red.shade400, size: 20),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutButtonCollapsed() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onLogout,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.shade200.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Icon(
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
