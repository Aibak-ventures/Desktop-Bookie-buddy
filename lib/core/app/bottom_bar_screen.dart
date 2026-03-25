import 'package:bookie_buddy_web/core/app/widgets/shop_switcher_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/stock_management_cubit/stock_management_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/delete_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_details_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sales_usecase.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/pages/new_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/pages/all_bookings_desktop_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_payment_history_cubit/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_drawer_cubit/sales_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/pages/stock_management_screen.dart';
import 'package:bookie_buddy_web/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int currentIndex = 1; // Start with Dashboard (index 1, since 0 is New Order)
  late PageController pageController;
  bool newOrderActive = false;
  bool showNewBookingInContent = false;
  bool isSidebarExpanded = false; // Track sidebar hover state

  // GlobalKey to access NewBookingScreen state
  final GlobalKey<NewBookingScreenState> _newBookingKey = GlobalKey();

  // GlobalKey to access AllBookingsDesktopScreen state
  final GlobalKey<AllBookingsDesktopScreenState> _allBookingsKey = GlobalKey();

  late final List<Widget> screens;

  @override
  void initState() {
    pageController = PageController();
    screens = [
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BookingDetailsDrawerCubit()),
          BlocProvider(
            create: (context) => BookingDetailsBloc(
              getBooking: getIt(),
              updateDeliveryStatus: getIt(),
              updateBookingStatus: getIt(),
              updatePayment: getIt(),
              cancelBooking: getIt(),
              deleteBooking: getIt(),
            ),
          ),
          BlocProvider(
            create: (context) => BookingDetailsPaymentHistoryCubit(),
          ),
          BlocProvider(
            create: (context) => AllBookingBloc(
              updateDeliveryStatus: getIt(),
              deleteBooking: getIt(),
              updateBookingStatus: getIt(),
              loadDesktopBookings: getIt(),
            ),
          ),
        ],
        child: DashboardScreen(onNavigateToBookings: _navigateToBookingsTab),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BookingDetailsDrawerCubit()),
          BlocProvider(
            create: (context) => BookingDetailsBloc(
              getBooking: getIt(),
              updateDeliveryStatus: getIt(),
              updateBookingStatus: getIt(),
              updatePayment: getIt(),
              cancelBooking: getIt(),
              deleteBooking: getIt(),
            ),
          ),
          BlocProvider(
            create: (context) => BookingDetailsPaymentHistoryCubit(),
          ),
          BlocProvider(
            create: (context) =>
                AllSalesBloc(getSalesUseCase: getIt<GetSalesUseCase>()),
          ),
          BlocProvider(create: (context) => SalesDetailsDrawerCubit()),
          BlocProvider(
            create: (context) => SalesDetailsBloc(
              getSaleDetailsUseCase: getIt<GetSaleDetailsUseCase>(),
              deleteSaleUseCase: getIt<DeleteSaleUseCase>(),
            ),
          ),
        ],
        child: AllBookingsDesktopScreen(key: _allBookingsKey),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BookingDetailsDrawerCubit()),
          BlocProvider(
            create: (context) => BookingDetailsBloc(
              getBooking: getIt(),
              updateDeliveryStatus: getIt(),
              updateBookingStatus: getIt(),
              updatePayment: getIt(),
              cancelBooking: getIt(),
              deleteBooking: getIt(),
            ),
          ),
          BlocProvider(
            create: (context) => BookingDetailsPaymentHistoryCubit(),
          ),
          BlocProvider(
            create: (context) => AllBookingBloc(
              updateDeliveryStatus: getIt(),
              deleteBooking: getIt(),
              updateBookingStatus: getIt(),
              loadDesktopBookings: getIt(),
            ),
          ),
          BlocProvider(
            create: (context) => StockManagementCubit(
              getProducts: getIt(),
              deleteProduct: getIt(),
              searchAllProducts: getIt(),
              searchAndFilterProducts: getIt(),
            ),
          ),
        ],
        child: const StockManagementScreen(),
      ),
    ];
    super.initState();
  }

  /// Navigate to All Bookings tab with a specific status filter
  void _navigateToBookingsTab(String statusTab) {
    setState(() {
      currentIndex =
          2; // All Bookings is index 2 in sidebar (Dashboard=1, All Bookings=2)
    });
    pageController.jumpToPage(1); // All Bookings is page index 1 in PageView
    // Change the status tab in the All Bookings screen after frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _allBookingsKey.currentState?.changeStatusTab(statusTab);
    });
  }


  /// Check for unsaved changes before navigating away from NewBookingScreen
  Future<bool> _checkNavigationFromNewBooking() async {
    final newBookingState = _newBookingKey.currentState;
    if (newBookingState != null && newBookingState.hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      return shouldDiscard ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content - with left padding to account for collapsed sidebar
          Positioned.fill(
            left: 80, // Space for collapsed sidebar (icon-only width)
            child: showNewBookingInContent
                ? NewBookingScreen(
                    key: _newBookingKey,
                    onClose: () {
                      setState(() {
                        showNewBookingInContent = false;
                        newOrderActive = false;
                        currentIndex = 1; // Back to Dashboard
                      });
                      // Refresh dashboard data after closing new booking
                      _refreshDashboard();
                    },
                  )
                : PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: screens,
                  ),
          ),
          // Hover-expandable sidebar (positioned absolutely, overlays content)
          Positioned(left: 0, top: 0, bottom: 0, child: _glassSidebar()),
        ],
      ),
    );
  }

  Widget _glassSidebar() {
    const collapsedWidth = 80.0;
    const expandedWidth = 260.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isSidebarExpanded = true),
      onExit: (_) => setState(() => isSidebarExpanded = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: isSidebarExpanded ? expandedWidth : collapsedWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bottom_bar_background.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRect(
          child: OverflowBox(
            minWidth: collapsedWidth,
            maxWidth: expandedWidth,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: isSidebarExpanded ? expandedWidth : collapsedWidth,
              child: isSidebarExpanded
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
                _navItemExpanded(0, Icons.add_box_outlined, "New Order"),
                _navItemExpanded(1, Icons.dashboard_outlined, "Dashboard"),
                _navItemExpanded(2, Icons.list_alt, "Orders"),
                _navItemExpanded(3, Icons.bar_chart_outlined, "Stocks"),
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
        final firstLetter = userName.isNotEmpty
            ? userName[0].toUpperCase()
            : 'U';

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
        final firstLetter = userName.isNotEmpty
            ? userName[0].toUpperCase()
            : 'U';

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
    final isActive = currentIndex == index;
    final isNewOrder = index == 0;
    final isNewOrderActive = isNewOrder && newOrderActive;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _handleNavTap(index, isNewOrder),
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
    final isActive = currentIndex == index;
    final isNewOrder = index == 0;
    final isNewOrderActive = isNewOrder && newOrderActive;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _handleNavTap(index, isNewOrder),
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
            color: const Color(0xFF6C5CE7).withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );
    }
    return null;
  }

  Future<void> _handleNavTap(int index, bool isNewOrder) async {
    if (isNewOrder) {
      setState(() {
        newOrderActive = true;
        showNewBookingInContent = true;
        currentIndex = -1;
      });
    } else {
      if (showNewBookingInContent) {
        final shouldNavigate = await _checkNavigationFromNewBooking();
        if (!shouldNavigate) return;
      }
      setState(() {
        newOrderActive = false;
        showNewBookingInContent = false;
        currentIndex = index;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.jumpToPage(index - 1);
        }
      });
      // Refresh dashboard when navigating to Dashboard (index 1)
      if (index == 1) {
        _refreshDashboard();
      }
    }
  }

  /// Refresh dashboard data
  void _refreshDashboard() {
    context.read<DashboardBloc>().add(
      const DashboardEvent.loadDashboardData(useOldState: true),
    );
  }

  Widget _logoutButtonExpanded() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showLogoutConfirmationDialog(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.shade200.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(
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
          onTap: () => _showLogoutConfirmationDialog(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.shade200.withOpacity(0.5),
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

  /// Show logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.logout_rounded, color: Colors.red.shade400, size: 28),
            const SizedBox(width: 12),
            const Text(
              'Logout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // Perform logout
      await context.read<UserCubit>().logOut();

      // Navigate to login screen immediately
      if (mounted) {
        context.pushReplacement(LoginScreen());
      }
    }
  }
}
