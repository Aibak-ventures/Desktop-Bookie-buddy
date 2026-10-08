import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/app/shell_nav_items.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_list_filter_enum.dart';
import 'package:bookie_buddy_web/core/app/widgets/glass_sidebar.dart';
import 'package:bookie_buddy_web/core/app/widgets/logout_confirmation_dialog.dart';
import 'package:bookie_buddy_web/core/app/bloc/details_drawer_cubit/details_drawer_cubit.dart';
import 'package:bookie_buddy_web/core/app/widgets/global_details_drawer.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/check_print_bridge_available_usecase.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/pages/all_bookings_desktop_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/pages/new_booking_screen.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key});

  @override
  State<AppShellScreen> createState() => AppShellScreenState();
}

class AppShellScreenState extends State<AppShellScreen> {
  ShellTabId activeTab = ShellTabId.dashboard;
  late PageController pageController;
  late final List<ShellNavItem> navItems;

  final GlobalKey<NewBookingScreenState> _newBookingKey = GlobalKey();
  final GlobalKey<AllBookingsDesktopScreenState> _allBookingsKey = GlobalKey();

  /// Set by [_navigateToBookingsTab] just before the Orders screen's very
  /// first mount, so its `initState` can pick up the real target status
  /// directly instead of loading the default 'upcoming' filter only to
  /// immediately reload with the correct one.
  BookingListFilter? _pendingOrdersFilter;

  @override
  void initState() {
    navItems = buildShellNavItems(
      onNewOrderClosed: () => navigateTo(ShellTabId.dashboard),
      onNavigateToBookings: _navigateToBookingsTab,
      newBookingKey: _newBookingKey,
      allBookingsKey: _allBookingsKey,
      pendingOrdersFilter: () {
        final pending = _pendingOrdersFilter;
        _pendingOrdersFilter = null;
        return pending;
      },
    );
    pageController = PageController(
      initialPage: navItems.indexWhere((item) => item.id == activeTab),
    );
    _warmUpPrinterBridge();
    super.initState();
  }

  /// Fires a one-off, silent QZ Tray connection attempt as soon as the user
  /// lands here — reached from every successful-auth path (fresh login,
  /// splash's silent session restore, post-reset-password), so this is the
  /// single place that covers all of them.
  ///
  /// Deliberately not tied to [QzPrinterCubit] — that cubit is screen-scoped
  /// by design (see its own doc comment: no persistent per-device
  /// connection worth keeping alive once the print screen closes), so
  /// reusing it here for a background warm-up would fight that. This just
  /// pays the WebSocket-handshake latency once, early, so the first receipt
  /// print of the session (quick-print or the picker) doesn't have to pay
  /// it — QZ Tray itself remembers nothing between calls, so nothing here
  /// needs to be undone/disconnected.
  ///
  /// Uses [CheckPrintBridgeAvailableUseCase] rather than
  /// [ConnectPrintBridgeUseCase] specifically because it never throws (a
  /// user without QZ Tray running/installed is an entirely normal case here
  /// — nothing to show an error for, since nothing on this screen is asking
  /// to print yet).
  void _warmUpPrinterBridge() {
    try {
      log('warming up QZ Tray connection...', name: 'AppShellScreen');
      unawaited(getIt<CheckPrintBridgeAvailableUseCase>()());
    } catch (_) {}
  }

  void _navigateToBookingsTab(BookingListFilter statusTab) {
    navigateTo(ShellTabId.orders);

    final mountedState = _allBookingsKey.currentState;
    if (mountedState != null) {
      // Screen already exists from a previous visit (kept alive via
      // AutomaticKeepAliveClientMixin) — apply directly. Dispatching this
      // to AllBookingBloc instead used to race against this screen's own
      // default "upcoming" load with no guaranteed ordering between the
      // two; calling straight into the live state sidesteps that entirely.
      mountedState.applyStatusFilter(statusTab, resetFilters: true);
      return;
    }

    // First-ever visit: the Orders page doesn't exist yet — the plain
    // [PageView] only builds it lazily once `navigateTo`'s `jumpToPage`
    // actually scrolls it into view, which can take a frame or more. Rather
    // than polling for that, hand the target status to the screen itself so
    // its own `initState` loads it directly — avoids firing the default
    // 'upcoming' load only to immediately redo it.
    _pendingOrdersFilter = statusTab;
  }

  Future<bool> _checkNavigationFromNewBooking() async {
    return await _newBookingKey.currentState?.confirmLeave() ?? true;
  }

  /// Single navigation entry point for both sidebar taps and any external
  /// caller holding a [GlobalKey<AppShellScreenState>] for this screen.
  Future<void> navigateTo(ShellTabId tab) async {
    if (activeTab == ShellTabId.newOrder && tab != ShellTabId.newOrder) {
      final shouldNavigate = await _checkNavigationFromNewBooking();
      if (!shouldNavigate) return;
    }
    if (tab != activeTab) {
      context.read<DetailsDrawerCubit>().closeDrawer();
    }
    setState(() {
      activeTab = tab;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        pageController.jumpToPage(
          navItems.indexWhere((item) => item.id == tab),
        );
      }
    });
    if (tab == ShellTabId.dashboard) {
      _refreshDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            left: 80,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: navItems
                  .map((item) => item.screenBuilder(context))
                  .toList(),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: GlassSidebar(
              navItems: navItems,
              activeTab: activeTab,
              onTabTap: navigateTo,
              onLogout: () => _handleLogout(context),
            ),
          ),
          // Rendered once here so any screen can open a drawer via
          // `context.read<DetailsDrawerCubit>().open(type, id)` without
          // wrapping itself in a Stack.
          const GlobalDetailsDrawer(),
        ],
      ),
    );
  }

  void _refreshDashboard() {
    context.read<DashboardBloc>().add(
      const DashboardEvent.loadDashboardData(useOldState: true),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showLogoutConfirmationDialog(context);
    if (confirmed && mounted) {
      await context.read<UserCubit>().logOut();
      if (mounted) {
        context.pushReplacement(LoginScreen());
      }
    }
  }
}
