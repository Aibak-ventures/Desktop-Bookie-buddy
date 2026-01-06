import 'dart:ui';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_date_selecting_screen.dart';
import 'package:bookie_buddy_web/features/home/view/home_screen.dart';
import 'package:bookie_buddy_web/features/new_booking/view/new_booking_screen.dart';
import 'package:bookie_buddy_web/features/new_booking/view/new_booking_screen_v2.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_bookings_desktop_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
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
      ],
      child: const AllBookingsDesktopScreen(),
    ),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/assets/images/bottom_bar_background.png',
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: [
              _glassSidebar(),
              Expanded(
                child: showNewBookingInContent
                    ? NewBookingScreen(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _glassSidebar() {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: const Color(0xFFF3EEFF), // soft purple like design
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _profileHeader(),
          // const SizedBox(height: 24),
          // _newOrderButton(),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _navItem(0, Icons.add, "New Order"),
                  _navItem(1, Icons.dashboard_rounded, "Dashboard"),
                  _navItem(2, Icons.shopping_cart_rounded, "Orders"),
                  _navItem(3, Icons.menu_book_rounded, "Ledger book"),
                  _navItem(4, Icons.inventory_2_rounded, "Stocks"),
                ],
              ),
            ),
          ),
          _logoutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _profileHeader() {
    return BlocBuilder<UserCubit, UserModel?>(
      builder: (context, user) {
        final shopName = user?.shopDetails.name ?? 'Business Name';
        final shopAddress = user?.shopDetails.place ??
            user?.shopDetails.city ??
            user?.shopDetails.address ??
            'Location';
        final shopImage = user?.shopDetails.image;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Profile Image with border
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF6C5CE7),
                      const Color(0xFF00B4DB),
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: shopImage != null && shopImage.isNotEmpty
                        ? ClipOval(
                            child: CustomNetworkImage(
                              imageUrl: shopImage,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.store_rounded,
                            size: 36,
                            color: Color(0xFF6C5CE7),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // Shop Name
              Text(
                shopName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3436),
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Location with icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      shopAddress,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _newOrderButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(const AddBookingDateSelectingScreen()),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C5CE7),
                  Color(0xFF8B7CF7),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "New Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isActive = currentIndex == index;
    final isNewOrder = index == 0; // New Order is at index 0

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          if (isNewOrder) {
            setState(() {
              newOrderActive = true;
              showNewBookingInContent = true;
              currentIndex = -1; // no sidebar item selected
            });
          } else {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: isNewOrder
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6C5CE7),
                      Color(0xFF8B7CF7),
                    ],
                  )
                : isActive
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
            boxShadow: (isActive || isNewOrder)
                ? [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: (isActive || isNewOrder)
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
                    color: (isActive || isNewOrder)
                        ? Colors.white
                        : const Color(0xFF636E72),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle logout
            context.read<UserCubit>().logOut();
          },
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
                  size: 18,
                  color: Colors.red.shade400,
                ),
                const SizedBox(width: 8),
                Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
