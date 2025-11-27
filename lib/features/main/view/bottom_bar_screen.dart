import 'dart:io';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/storage/token_manager.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/screens/select_service_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_date_selecting_screen.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/view_model/cubit_save_sales/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/add_or_edit_sales_screen.dart';
import 'package:bookie_buddy_web/features/main/widgets/shop_switcher_bottom_sheet.dart';
import 'package:bookie_buddy_web/features/product/view/product_grid_screen.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product/product_bloc.dart';
import 'package:bookie_buddy_web/features/search/view_model/bloc_search/search_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../save_expense/view/add_expense_screen.dart';
import '../../search/view/search_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int currentIndex = 0;
  late PageController pageController;

  // List of screens
  final List<Widget> screens = [
    const HomeScreen(),
    BlocProvider(
      create: (context) => SearchBloc(repository: getIt.get()),
      child: const SearchScreen(),
    ),
    const AddExpenseScreen(),
    const ProfileScreen(),
    BlocProvider(
      create: (context) => ProductBloc(),
      child: SelectServiceScreen(
        onServiceSelected: (service, ctx) {
          print('Selected service: ${service.name}');
          ctx.push(
            ProductGridScreen(
              serviceId: service.id,
              name: service.name,
              mainServiceType:
                  MainServiceType.fromString(service.mainServiceName),
            ),
          );
        },
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb ||
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        print('on pop invoked worked');
        if (!didPop) await _onWillPop(context);
        print('on pop invoke after dialog function');
      },
      child: isDesktop
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Row(
        children: [
          // Left Sidebar Navigation
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with User Info
                _buildDesktopHeader(context),
                // Navigation Items
                Expanded(
                  child: _buildDesktopNavigation(context),
                ),
                // Quick Action Buttons
                _buildDesktopQuickActions(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: screens,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667eea),
            const Color(0xFF764ba2),
          ],
        ),
      ),
      child: Column(
        children: [
          // App Logo/Name
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.business_center,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Bookie Buddy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // User Profile
          BlocBuilder<UserCubit, UserModel?>(
            builder: (context, user) {
              return GestureDetector(
                onLongPress: () {
                  if (user?.haveMultipleShops ?? false) {
                    context
                        .read<ShopListBloc>()
                        .add(const ShopListEvent.loadShops());
                    showAccountSwitcherBottomSheet(context);
                  }
                },
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomNetworkImage(
                          imageUrl: user?.shopDetails.image ?? "",
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) {
                            return Container(
                              color: Colors.white.withOpacity(0.2),
                              child: Icon(
                                Icons.business,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              color: Colors.white.withOpacity(0.2),
                              child: Icon(
                                Icons.business,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.firstName ?? 'Shop Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            user?.lastName ?? 'Owner',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
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
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        children: [
          _buildDesktopNavItem(
            0,
            Icons.home_outlined,
            Icons.home,
            "Dashboard",
          ),
          const SizedBox(height: 8),
          _buildDesktopNavItem(
            1,
            LucideIcons.search,
            LucideIcons.search,
            "Search",
          ),
          const SizedBox(height: 8),
          _buildDesktopNavItem(
            2,
            Icons.attach_money_outlined,
            Icons.attach_money,
            "Expenses",
          ),
          const SizedBox(height: 8),
          _buildDesktopNavItem(
            3,
            Icons.person_outline,
            Icons.person,
            "Profile",
          ),
          const Divider(height: 24),
          _buildDesktopNavItem(
            4,
            Icons.inventory_2_outlined,
            Icons.inventory_2,
            "Stock",
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavItem(
    int index,
    IconData outlinedIcon,
    IconData filledIcon,
    String label,
  ) {
    final isSelected = currentIndex == index;

    return Container(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            print('Desktop nav item tapped: $index, current: $currentIndex');
            setState(() {
              currentIndex = index;
            });
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF667eea).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: const Color(0xFF667eea).withOpacity(0.3))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? filledIcon : outlinedIcon,
                  color: isSelected
                      ? const Color(0xFF667eea)
                      : const Color(0xFF6B7280),
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF667eea)
                        : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Add Booking Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                context.push(
                  const AddBookingDateSelectingScreen(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667eea),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_available, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Add Booking',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Add Sales Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                context.push(
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            SaveSalesCubit(repository: getIt.get()),
                      ),
                      BlocProvider(
                        create: (context) =>
                            StaffSearchCubit(repository: getIt.get())
                              ..getAllStaffs(),
                      ),
                    ],
                    child: const AddOrEditSalesScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10b981),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.point_of_sale, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Add Sales',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: screens,
      ),
      extendBody: currentIndex != 3 ? true : false,
      // resizeToAvoidBottomInset: currentIndex == 2 ? false : true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greyBorder, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  0,
                  Icons.home_outlined,
                  Icons.home,
                  "Home",
                ),
                _buildNavItem(
                  1,
                  LucideIcons.search,
                  LucideIcons.search,
                  "Search",
                ),
                // Center button
                _buildCenterButton(),

                _buildNavItem(
                  2,
                  Icons.attach_money_outlined,
                  Icons.attach_money,
                  "Expense",
                ),
                // _buildNavItem(
                //   3,
                //   Icons.person_outline,
                //   Icons.person,
                //   "Profile",
                // ),
                BlocBuilder<UserCubit, UserModel?>(
                  builder: (context, user) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 3;
                          pageController.jumpToPage(currentIndex);
                        });
                      },
                      onLongPress: () {
                        print(
                            'user have multiple shop : ${user?.haveMultipleShops}');
                        if (user?.haveMultipleShops ?? false) {
                          context
                              .read<ShopListBloc>()
                              .add(const ShopListEvent.loadShops());
                          showAccountSwitcherBottomSheet(context);
                        }
                      },
                      child: CustomNetworkImage(
                        width: 40,
                        height: 40,
                        imageUrl: user?.shopDetails.image ?? "",
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyBorder,
                            ),
                            child: Icon(
                              Icons.person,
                              color: AppColors.grey600,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyBorder,
                            ),
                            child: Icon(
                              Icons.person,
                              color: AppColors.grey600,
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData outlinedIcon,
    IconData filledIcon,
    String label,
  ) {
    final isSelected = currentIndex == index;

    return Padding(
      padding: (4, 8).padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? filledIcon : outlinedIcon,
            color: isSelected ? AppColors.purple : AppColors.grey600,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.purple : AppColors.grey600,
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 2,
              width: 20,
              decoration: BoxDecoration(
                color: AppColors.purple,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    ).onTap(
      () async {
        // await pageController.animateToPage(
        //   index,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
        setState(() {
          currentIndex = index;
          pageController.jumpToPage(index);
        });
      },
    );
  }

  Widget _buildCenterButton() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFF5B4BD6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 28,
      ),
    ).onTap(
      () {
        context.push(
          const AddBookingDateSelectingScreen(),
        );
      },
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    print('user trying to exit...');

    final bool? exitApp = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.exit_to_app_rounded,
              color: Theme.of(context).colorScheme.error,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'Exit App',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to close the app?',
          style: TextStyle(
            fontSize: 16.sp,
            height: 1.4,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 6),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Exit',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );

    if (exitApp == true) {
      print('user wants to exit...');
      TokenManager.stopProactiveRefresh();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      } else {
        exit(0);
      }
    }

    return false;
  }
}

class BottomProfileContainer extends StatelessWidget {
  const BottomProfileContainer({
    super.key,
    required this.currentIndex,
    required this.imageProvider,
  });

  final int currentIndex;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: currentIndex != 3 ? null : Matrix4.translationValues(0, -3, 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          if (currentIndex == 3)
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
        ],
        border: Border.all(
          color: AppColors.grey,
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: imageProvider != null
            ? Image(
                image: imageProvider!,
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.person,
                size: 16.sp,
                color: AppColors.grey,
              ),
      ),
    );
  }
}
