import 'package:bookie_buddy_web/core/app/widgets/glass_sidebar.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/pages/old_new_booking_screen.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/stock_management_cubit/stock_management_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/delete_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_details_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sales_usecase.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
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
  int currentIndex = 1;
  late PageController pageController;
  bool newOrderActive = false;
  bool showNewBookingInContent = false;

  final GlobalKey<OldNewBookingScreenState> _newBookingKey = GlobalKey();
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

  void _navigateToBookingsTab(String statusTab) {
    setState(() {
      currentIndex = 2;
    });
    pageController.jumpToPage(1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _allBookingsKey.currentState?.changeStatusTab(statusTab);
    });
  }

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
          Positioned.fill(
            left: 80,
            child: showNewBookingInContent
                ? OldNewBookingScreen(
                    key: _newBookingKey,
                    onClose: () {
                      setState(() {
                        showNewBookingInContent = false;
                        newOrderActive = false;
                        currentIndex = 1;
                      });
                      _refreshDashboard();
                    },
                  )
                : PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: screens,
                  ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: GlassSidebar(
              currentIndex: currentIndex,
              newOrderActive: newOrderActive,
              onNavTap: _handleNavTap,
              onLogout: () => _showLogoutConfirmationDialog(context),
            ),
          ),
        ],
      ),
    );
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
      if (index == 1) {
        _refreshDashboard();
      }
    }
  }

  void _refreshDashboard() {
    context.read<DashboardBloc>().add(
      const DashboardEvent.loadDashboardData(useOldState: true),
    );
  }

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
      await context.read<UserCubit>().logOut();
      if (mounted) {
        context.pushReplacement(LoginScreen());
      }
    }
  }
}
