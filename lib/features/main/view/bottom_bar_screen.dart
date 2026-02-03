import 'dart:ui';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/home/view/home_screen.dart';
import 'package:bookie_buddy_web/features/new_booking/view/new_booking_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_bookings_desktop_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_sales/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_sales_details/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_sales_details_drawer/sales_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/stock_management/view/stock_management_screen.dart';
import 'package:bookie_buddy_web/features/stock_management/view_model/stock_management_cubit.dart';
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

  final List<Widget> screens = [
    const HomeScreen(),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingDetailsDrawerCubit(),
        ),
        BlocProvider(
          create: (context) => BookingDetailsBloc(
            repository: getIt.get<BookingRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => BookingDetailsPaymentHistoryCubit(
            repository: getIt.get<BookingRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AllSalesBloc(
            repository: getIt.get<SalesRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SalesDetailsDrawerCubit(),
        ),
        BlocProvider(
          create: (context) => SalesDetailsBloc(
            repository: getIt.get<SalesRepository>(),
          ),
        ),
      ],
      child: const AllBookingsDesktopScreen(),
    ),
    const HomeScreen(),
    RepositoryProvider(
      create: (context) => getIt.get<ProductRepository>(),
      child: BlocProvider(
        create: (context) => StockManagementCubit(
          repository: getIt.get(),
        ),
        child: const StockManagementScreen(),
      ),
    ),
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
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
                    },
                  )
                : PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: screens,
                  ),
          ),
          // Hover-expandable sidebar (positioned absolutely, overlays content)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: _glassSidebar(),
          ),
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
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: isSidebarExpanded ? expandedWidth : collapsedWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/assets/images/bottom_bar_background.png'),
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              _profileHeader(),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSidebarExpanded ? 22 : 12,
                ),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 16),
              // Scrollable navigation items area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      _navItem(0, Icons.add_box_outlined, "New Order"),
                      _navItem(1, Icons.dashboard_outlined, "Dashboard"),
                      _navItem(2, Icons.list_alt, "Orders"),
                      _navItem(3, Icons.menu_book_rounded, "Ledger book"),
                      _navItem(4, Icons.bar_chart_outlined, "Stocks"),
                    ],
                  ),
                ),
              ),
              // Logout button fixed at bottom
              _logoutButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return BlocBuilder<UserCubit, UserModel?>(
      builder: (context, user) {
        final userName = user?.userFullName ?? 'User';
        // Use first letter as "spelling icon"
        final firstLetter =
            userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSidebarExpanded ? 20 : 12,
          ),
          child: isSidebarExpanded
              ? Row(
                  children: [
                    _buildAvatar(firstLetter),
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
                          // Optional: Show Role or Shop Name below?
                          // User didn't ask, but it's good context.
                          // "we are showing the shop name and all right but that we need to change"
                          // Maybe show Shop Name as subtitle?
                          if (user?.shopDetails.name != null)
                            Text(
                              user!.shopDetails.name,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                )
              : _buildAvatar(firstLetter),
        );
      },
    );
  }

  Widget _buildAvatar(String letter) {
    return Container(
      width: isSidebarExpanded ? 48 : 40,
      height: isSidebarExpanded ? 48 : 40,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C5CE7),
            Color(0xFF00B4DB),
          ],
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
              fontSize: isSidebarExpanded ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6C5CE7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isActive = currentIndex == index;
    final isNewOrder = index == 0; // New Order is at index 0
    // Check if New Order is actually active
    final isNewOrderActive = isNewOrder && newOrderActive;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () async {
          if (isNewOrder) {
            setState(() {
              newOrderActive = true;
              showNewBookingInContent = true;
              currentIndex = -1; // no sidebar item selected
            });
          } else {
            // If NewBookingScreen is active, check for unsaved changes
            if (showNewBookingInContent) {
              // We need to get the callback from NewBookingScreen's state
              // For now, we'll call the onClose which will handle the discard check
              // But we need to modify this to await the result
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
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: isSidebarExpanded ? 10 : 12,
          ),
          decoration: BoxDecoration(
            gradient: (isActive || isNewOrderActive)
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6C5CE7),
                      Color(0xFF8B7CF7),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(14),
            boxShadow: (isActive || isNewOrderActive)
                ? [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: isSidebarExpanded
              ? Row(
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
                      ),
                    ),
                  ],
                )
              : Center(
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

  Widget _logoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSidebarExpanded ? 20 : 12,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<UserCubit>().logOut();
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: isSidebarExpanded ? 12 : 14,
            ),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.shade200.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
