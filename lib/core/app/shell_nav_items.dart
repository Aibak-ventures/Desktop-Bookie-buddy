import 'package:bookie_buddy_web/core/constants/enums/booking_list_filter_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/pages/all_bookings_desktop_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/pages/new_booking_screen.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:bookie_buddy_web/features/global_search/presentation/pages/global_search_screen.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/pages/stock_management_screen.dart';
import 'package:bookie_buddy_web/features/settings/presentation/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum ShellTabId { newOrder, dashboard, globalSearch, orders, stock, settings }

class ShellNavItem {
  final ShellTabId id;
  final IconData icon;
  final String label;
  final WidgetBuilder screenBuilder;

  const ShellNavItem({
    required this.id,
    required this.icon,
    required this.label,
    required this.screenBuilder,
  });
}

/// Order here is the single source of truth for both [PageView] order and
/// sidebar order — inserting a new screen anywhere (including between two
/// existing ones) is exactly one entry in this list, nothing else to touch.
List<ShellNavItem> buildShellNavItems({
  required VoidCallback onNewOrderClosed,
  required void Function(BookingListFilter statusTab) onNavigateToBookings,
  required GlobalKey<NewBookingScreenState> newBookingKey,
}) => [
  ShellNavItem(
    id: ShellTabId.newOrder,
    icon: Icons.add_box_outlined,
    label: 'New Order',
    screenBuilder: (_) =>
        NewBookingScreen(key: newBookingKey, onClose: onNewOrderClosed),
  ),
  ShellNavItem(
    id: ShellTabId.dashboard,
    icon: Icons.dashboard_outlined,
    label: 'Dashboard',
    screenBuilder: (_) =>
        DashboardScreen(onNavigateToBookings: onNavigateToBookings),
  ),
  ShellNavItem(
    id: ShellTabId.globalSearch,
    icon: LucideIcons.search500,
    label: 'Global Search',
    screenBuilder: (_) => const GlobalSearchScreen(),
  ),
  ShellNavItem(
    id: ShellTabId.orders,
    icon: Icons.list_alt,
    label: 'Orders',
    screenBuilder: (_) => const AllBookingsDesktopScreen(),
  ),
  ShellNavItem(
    id: ShellTabId.stock,
    icon: Icons.bar_chart_outlined,
    label: 'Stocks',
    screenBuilder: (_) => const StockManagementScreen(),
  ),
  ShellNavItem(
    id: ShellTabId.settings,
    icon: Icons.settings_outlined,
    label: 'Settings',
    screenBuilder: (_) => const SettingsScreen(),
  ),
];
