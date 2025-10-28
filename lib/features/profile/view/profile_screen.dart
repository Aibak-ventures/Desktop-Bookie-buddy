import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/screens/select_service_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_booking_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking_past/all_booking_past_bloc.dart';
import 'package:bookie_buddy_web/features/auth/view/login_screen.dart';
import 'package:bookie_buddy_web/features/change_password/view/change_secret_password_screen.dart';
import 'package:bookie_buddy_web/features/change_password/view/reset_password_screen.dart';
import 'package:bookie_buddy_web/features/change_password/view_model/bloc_reset_password/reset_password_bloc.dart';
import 'package:bookie_buddy_web/features/change_password/view_model/bloc_secret_password/secret_password_bloc.dart';
import 'package:bookie_buddy_web/features/client/view/client_list_screen.dart';
import 'package:bookie_buddy_web/features/completed_bookings/view/completed_bookings_screen.dart';
import 'package:bookie_buddy_web/features/ledger/view/ledger_screen.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_bookings/ledger_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_sales/ledger_sales_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_security_amounts/ledger_security_amounts_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_expense/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_payments/wallet_payments_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_pending/wallet_pending_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/ledger_simple_summary_cubit.dart';
import 'package:bookie_buddy_web/features/product/view/product_grid_screen.dart';
import 'package:bookie_buddy_web/features/profile/view/about_screen.dart';
import 'package:bookie_buddy_web/features/profile/view/contact_and_support_screen.dart';

import 'package:bookie_buddy_web/features/profile/view/widgets/custom_profile_expansion_tile.dart';
import 'package:bookie_buddy_web/features/profile/view/widgets/custom_profile_tile.dart';
import 'package:bookie_buddy_web/features/profile/view/widgets/profile_shop_details_card.dart';
import 'package:bookie_buddy_web/features/staff/view/staff_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final user = context.read<UserCubit>().state;
    final shopRole = user?.shopRole ?? ShopRole.staff;
     debugPrint('Shop role in profile screen: $shopRole');
    return SafeArea(
      child: Scaffold(
        backgroundColor: ResponsiveHelper.isDesktop(context) 
            ? const Color(0xFFF8F9FA) 
            : null,
        extendBody: true,
        body: ResponsiveWidget(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
          desktop: _buildDesktopLayout(context),
          largeDesktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: context.read<UserCubit>().loadUserData,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ProfileShopDetailsCard(),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: 16.padding,
                child: _buildProfileContent(context, context.read<UserCubit>().state?.shopRole ?? ShopRole.staff),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: context.read<UserCubit>().loadUserData,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF8F9FA),
                Color(0xFFE9ECEF),
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: const ProfileShopDetailsCard(),
                  ),
                ),
              ),
              
              // Content Section
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildProfileContent(context, context.read<UserCubit>().state?.shopRole ?? ShopRole.staff),
                ),
              ),
              
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: context.read<UserCubit>().loadUserData,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF8F9FA),
                Color(0xFFE9ECEF),
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 60,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const ProfileShopDetailsCard(),
                  ),
                ),
              ),
              
              // Content Section
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  padding: const EdgeInsets.all(48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: _buildProfileContent(context, context.read<UserCubit>().state?.shopRole ?? ShopRole.staff),
                ),
              ),
              
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context,ShopRole shopRole) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // all bookings expansion tile
        CustomProfileExpansionTile(
          icon: Icons.collections_bookmark_rounded,
          title: 'All Bookings',
          cards: [
            // upcoming booking
            CustomProfileExpandedCard(
              icon: const Icon(Icons.access_time),
              text: 'Upcoming\nBookings',
              color: const Color(0xFF2673C6),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => AllBookingBloc(repository: getIt.get()),
                      ),
                      BlocProvider(
                        create: (context) => AllBookingPastBloc(repository: getIt.get()),
                      ),
                    ],
                    child: AllBookingScreen(),
                  ),
                ),
              ),
            ),

            // completed booking
            CustomProfileExpandedCard(
              icon: const Icon(Icons.done_all),
              text: 'Completed\nBookings',
              color: const Color(0xFF219A00),
              onTap: () =>
                  context.push(CompletedBookingsScreen()),
            ),
          ],
        ),

        const SizedBox(height: 5),

        // ledger
        if (!shopRole.isStaff)
                          CustomProfileTile(
                            icon: Icons.menu_book_outlined,
                            title: 'Ledger',
                            onTap: () {
                              context.read<ServiceBloc>().add(
                                const ServiceEvent.loadServices(force: false),
                              );
                              performSecureActionDialog(
                                context,
                                SecretPasswordLocations.ledgerView,
                                onSuccess: () {
                                  context.push(
                                    MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => ClientCubit(
                                            repository: getIt.get(),
                                          )..clearSelected(),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              WalletExpenseBloc(
                                                repository: getIt.get(),
                                              ),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              WalletPaymentsBloc(
                                                repository: getIt.get(),
                                              ),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              LedgerSimpleSummaryCubit(
                                                repository: getIt.get(),
                                              ),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              WalletPendingBloc(
                                                repository: getIt.get(),
                                              ),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              LedgerBookingsBloc(
                                                repository: getIt.get(),
                                              ),
                                        ),
                                        BlocProvider(
                                          create: (context) => LedgerSalesBloc(
                                            repository: getIt.get(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) =>
                                              LedgerSecurityAmountsBloc(
                                                repository: getIt.get(),
                                              ),
                                        ),
                                      ],
                                      child: const WalletScreen(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),


        const SizedBox(height: 5),
  CustomProfileTile(
          icon: Icons.business_center_outlined,
          title: 'Staff',
          onTap: () => context.push(const StaffListScreen()),
        ),
        // stock
        CustomProfileTile(
          icon: Icons.bar_chart,
          title: 'Stock management',
          onTap: () => context.push(
            SelectServiceScreen(
              onServiceSelected: (service, ctx) {
                print('Selected service: ${service.name}');
                ctx.push(
                  ProductGridScreen(
                    serviceId: service.id,
                    name: service.name,
                    mainServiceType:
                        MainServiceType.fromString(
                            service.mainServiceName),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 5),

        // client
        CustomProfileTile(
          icon: Icons.people_alt_outlined,
          title: 'Clients',
          onTap: () => context.push(const ClientListScreen()),
        ),

        const SizedBox(height: 5),

        // change password expansion tile
        CustomProfileExpansionTile(
          icon: Icons.key_outlined,
          title: 'Change password',
          cards: [
            // account password
            CustomProfileExpandedCard(
              icon: const Icon(Icons.password),
              text: 'Account\nPassword',
              color: const Color(0xFFC68B26),
              onTap: () => context.push(
                BlocProvider(
                  create: (context) => ResetPasswordBloc(),
                  child: const ResetPasswordScreen(),
                ),
              ),
            ),

            // secret password
            CustomProfileExpandedCard(
              icon: const Icon(Icons.lock_person_outlined),
              text: 'Secret\nPassword',
              color: const Color(0xFFFF8604),
              onTap: () {
                context.push(BlocProvider(
                  create: (context) => SecretPasswordBloc(),
                  child: const ChangeSecretPasswordScreen(),
                ));
              },
            )
          ],
        ),

        const SizedBox(height: 5),

        // contact & support
        CustomProfileTile(
          icon: Icons.support_agent_outlined,
          title: 'Contact & Support',
          onTap: () {
            context.push(const ContactAndSupportScreen());
          },
        ),

        const SizedBox(height: 5),

        // privacy policy
        CustomProfileTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () async {
            try {
              final Uri url = Uri.parse(
                  'https://www.termsfeed.com/live/e9045109-cea9-4b40-a8b3-8c300091002e');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            } catch (e) {
              if (context.mounted) {
                context.showSnackBar(
                  'Could not open privacy policy. Please check your internet connection.',
                  isError: true,
                );
              }
            }
          },
        ),

        const SizedBox(height: 5),

        // about us
        CustomProfileTile(
          icon: Icons.info_outline,
          title: 'About us',
          onTap: () => context.push(const AboutScreen()),
        ),

        const SizedBox(height: 20),

        // log out button
        CustomElevatedButton(
          width: double.infinity,
          text: 'Log out',
          isNormal: false,
          icon: const Icon(Icons.logout_outlined),
          onPressed: () => _showLogoutDialog(context),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: SizedBox(
            width: context.isMobile ? null : 400,
            child: const Text("Are you sure you want to log out?"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  context.pop();
                  await context.read<UserCubit>().logOut();
                  if (context.mounted) {
                    context.pushAndRemoveUntil(LoginScreen());
                  }
                } catch (e) {
                  log(e.toString());
                  if (context.mounted) {
                    context.showSnackBar(
                      'Logout failed. Please try again.',
                      isError: true,
                    );
                  }
                }
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
