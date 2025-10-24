import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
import 'package:bookie_buddy_web/core/ui/screens/select_service_screen.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_animation_screen.dart';
// import 'package:bookie_buddy_web/core/ui/screens/transfer_animation_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_normal_elevated_button.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_client_details_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_date_selecting_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_payment_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_product_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_customization_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/cubit_add_booking_products/add_booking_products_cubit.dart';
import 'package:bookie_buddy_web/features/add_old_booking/view/add_old_booking_screen.dart';
import 'package:bookie_buddy_web/features/add_old_booking/view_model/bloc_add_old_bookings/add_old_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/view_model/cubit_save_sales/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/add_or_edit_sales_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_booking_screen.dart';
import 'package:bookie_buddy_web/features/auth/view/login_screen.dart';
import 'package:bookie_buddy_web/features/auth/view/onboarding_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/edit_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:bookie_buddy_web/features/change_password/view/change_secret_password_screen.dart';
import 'package:bookie_buddy_web/features/change_password/view/reset_password_screen.dart';
import 'package:bookie_buddy_web/features/change_password/view_model/bloc_reset_password/reset_password_bloc.dart';
import 'package:bookie_buddy_web/features/change_password/view_model/bloc_secret_password/secret_password_bloc.dart';
import 'package:bookie_buddy_web/features/client/view/client_list_screen.dart';
import 'package:bookie_buddy_web/features/completed_bookings/view/completed_bookings_screen.dart';
import 'package:bookie_buddy_web/features/home/view/home_screen.dart';
import 'package:bookie_buddy_web/features/ledger/view/ledger_screen.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_bookings/ledger_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_sales/ledger_sales_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_security_amounts/ledger_security_amounts_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_expense/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_payments/wallet_payments_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_pending/wallet_pending_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/ledger_simple_summary_cubit.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:bookie_buddy_web/features/product/view/add_or_edit_product_screen.dart';
import 'package:bookie_buddy_web/features/product/view/product_grid_screen.dart';
import 'package:bookie_buddy_web/features/product/view/product_growth_screen.dart';
import 'package:bookie_buddy_web/features/product/view/product_info_screen.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product_growth/product_growth_bloc.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product_info/product_info_bloc.dart';
import 'package:bookie_buddy_web/features/product_all_booking/view/product_all_bookings_screen.dart';
import 'package:bookie_buddy_web/features/product_all_booking/view_model/bloc_product_booking_completed/product_booking_completed_bloc.dart';
import 'package:bookie_buddy_web/features/product_all_booking/view_model/bloc_product_booking_upcoming/product_booking_upcoming_bloc.dart';
import 'package:bookie_buddy_web/features/profile/view/about_screen.dart';
import 'package:bookie_buddy_web/features/profile/view/contact_and_support_screen.dart';
import 'package:bookie_buddy_web/features/profile/view/profile_screen.dart';
import 'package:bookie_buddy_web/features/sale_details/view/sale_details_screen.dart';
import 'package:bookie_buddy_web/features/save_expense/view/add_expense_screen.dart';
import 'package:bookie_buddy_web/features/search/view/search_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/splash/view/splash_screen.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/transfer_product_screen.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/transfer_product_select_and_transfer_product_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _subNavKey = GlobalKey<NavigatorState>();

///**Go to login screen and clear all previous routes**
///```dart
/// context.goNamed(AppRoutes.login.name); 'login' // Preferred way
/// context.go(AppRoutes.login.path); '/login'
///```
///
/// **Push details screen on top of current stack**
///```dart
/// context.pushNamed(AppRoutes.details.name); 'details' // Preferred way
/// context.push(AppRoutes.details.path); '/details'
///```
///
/// **Replace current screen with settings**
///```dart
/// context.pushReplacement(AppRoutes.settings.path); '/settings'
///```
///
/// **Pop back to previous screen**
///```dart
/// context.pop();
///```
///
/// **Check if we can pop**
///```dart
/// if (context.canPop()) {
///   context.pop();
/// }
///```
class Navigations {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash.path,
    debugLogDiagnostics: true,

    routes: [
      // Splash screen
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding screen
      GoRoute(
        path: AppRoutes.onboarding.path,
        name: AppRoutes.onboarding.name,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Login screen
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => LoginScreen(),
      ),

      // Bottom navigation bar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomBarScreen(),

        branches: [
          StatefulShellBranch(
            navigatorKey: _subNavKey,
            initialLocation: AppRoutes.home.path,
            preload: true,
            routes: [
              // Home screen
              GoRoute(
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              // Search screen
              GoRoute(
                path: AppRoutes.searchGlobal.path,
                name: AppRoutes.searchGlobal.name,
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              // Add expense screen
              GoRoute(
                path: AppRoutes.addExpense.path,
                name: AppRoutes.addExpense.name,
                builder: (context, state) => const AddExpenseScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              // Profile screen
              GoRoute(
                path: AppRoutes.profile.path,
                name: AppRoutes.profile.name,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // booking details screen
      GoRoute(
        path: AppRoutes.bookingDetails.path,
        name: AppRoutes.bookingDetails.name,
        parentNavigatorKey: navigatorKey,
        builder: (context, state) {
          final bookingId = state.pathParameters['id']?.toIntOrNull();
          if (bookingId == null) {
            // Fallback: show an error UI or a lightweight placeholder to avoid crash
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid booking or id. Please try again.'),
              ),
            );
          }
          return BookingDetailsScreen(bookingId: bookingId);
        },
      ),

      // Edit booking screen
      GoRoute(
        path: AppRoutes.editBooking.path,
        name: AppRoutes.editBooking.name,
        parentNavigatorKey: navigatorKey,
        builder: (context, state) {
          final booking = state.extra as BookingDetailsModel?;
          if (booking == null) {
            // Fallback: show an error UI or a lightweight placeholder to avoid crash
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid booking. Please try again.'),
              ),
            );
          }
          return BlocProvider(
            create: (context) => UpdateBookingCubit(
              bookingRepository: getIt.get(),
              clientRepository: getIt.get(),
            ),
            child: EditBookingScreen(booking: booking),
          );
        },
      ),

      // All bookings screen
      GoRoute(
        path: AppRoutes.allBookings.path,
        name: AppRoutes.allBookings.name,
        builder: (context, state) {
          final index = state.uri.queryParameters['index']?.toIntOrNull() ?? 0;
          return AllBookingScreen(index: index);
        },
      ),

      // All bookings screen
      GoRoute(
        path: AppRoutes.completedBookings.path,
        name: AppRoutes.completedBookings.name,
        builder: (context, state) => CompletedBookingsScreen(),
      ),

      // Sales screen
      // GoRoute(
      //   path: AppRoutes.sales.path,
      //   name: AppRoutes.sales.name,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => SalesListBloc(repository: getIt.get()),
      //     child: const SalesListScreen(),
      //   ),
      // ),

      // Ledger screen
      GoRoute(
        path: AppRoutes.ledger.path,
        name: AppRoutes.ledger.name,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ClientCubit(repository: getIt.get())..clearSelected(),
            ),
            BlocProvider(
              create: (context) => WalletExpenseBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (context) => WalletPaymentsBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (context) =>
                  LedgerSimpleSummaryCubit(repository: getIt.get()),
            ),
            BlocProvider(
              create: (context) => WalletPendingBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (context) => LedgerBookingsBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (context) => LedgerSalesBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (context) =>
                  LedgerSecurityAmountsBloc(repository: getIt.get()),
            ),
          ],
          child: const WalletScreen(),
        ),

        routes: [
          GoRoute(
            path: AppRoutes.editExpense.path,
            name: AppRoutes.editExpense.name,
            builder: (context, state) {
              final expense = state.extra as ExpenseModel?;

              if (expense == null) {
                return const CustomRouteErrorScreen(
                  message: 'Invalid expense. Please try again.',
                );
              }
              return AddExpenseScreen(expense: expense);
            },
          ),
        ],
      ),

      // Stock management screen
      GoRoute(
        path: AppRoutes.stockManagement.path,
        name: AppRoutes.stockManagement.name,
        builder: (context, state) => SelectServiceScreen(
          onServiceSelected: (service, ctx) {
            debugPrint('Selected service: ${service.name}');

            ctx.pushReplacementNamed(
              AppRoutes.products.name,
              pathParameters: {'service_id': service.id.toString()},
              queryParameters: {
                'service_name': service.name,
                'main_service_name': service.mainServiceName,
              },
            );
          },
        ),
      ),

      // Products screen
      GoRoute(
        path: AppRoutes.products.path,
        name: AppRoutes.products.name,
        builder: (context, state) {
          debugPrint('Current URI: ${state.uri}');
          final serviceId = state.pathParameters['service_id']?.toIntOrNull();
          final serviceName = state.uri.queryParameters['service_name'];
          final mainServiceName =
              state.uri.queryParameters['main_service_name'];
          if (serviceId == null ||
              mainServiceName.isNullOrEmpty ||
              serviceName.isNullOrEmpty) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid service details. Please try again.'),
              ),
            );
          }
          return ProductGridScreen(
            serviceId: serviceId,
            name: serviceName!,
            mainServiceType: MainServiceType.fromString(mainServiceName),
          );
        },
      ),

      // Add old bookings screen
      GoRoute(
        path: AppRoutes.addOldBookings.path,
        name: AppRoutes.addOldBookings.name,
        builder: (context, state) => BlocProvider(
          create: (context) => AddOldBookingsBloc(
            bookingRepository: getIt.get(),
            clientRepository: getIt.get(),
          ),
          child: const AddOldBookingScreen(),
        ),
      ),

      // Sale details screen
      GoRoute(
        path: AppRoutes.saleDetails.path,
        name: AppRoutes.saleDetails.name,
        builder: (context, state) {
          final saleId = state.pathParameters['id']?.toIntOrNull();
          if (saleId == null) {
            // Fallback: show an error UI or a lightweight placeholder to avoid crash
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid sale id. Please try again.'),
              ),
            );
          }
          return SaleDetailsScreen(saleId: saleId);
        },
      ),

      // Add or edit sales screen
      GoRoute(
        path: AppRoutes.addOrEditSales.path,
        name: AppRoutes.addOrEditSales.name,
        builder: (context, state) {
          final saleDetails = state.extra as SaleDetailsModel?;

          return BlocProvider(
            create: (context) => SaveSalesCubit(repository: getIt.get()),
            child: AddOrEditSalesScreen(saleDetails: saleDetails),
          );
        },
      ),

      // Select products screen
      GoRoute(
        path: AppRoutes.selectProducts.path,
        name: AppRoutes.selectProducts.name,
        builder: (context, state) {
          // debugPrint(state.uri.toString() + ' and extra: ${state.extra}');
          final serviceId = state.pathParameters['service_id']?.toIntOrNull();
          final queryParams = state.uri.queryParameters;
          final pickupDate = queryParams['pickup_date'];
          final returnDate = queryParams['return_date'];
          final isSameDateAsOldBooking =
              queryParams['is_same_date_as_old_booking'] == 'true';

          final availabilityCheckOnly = bool.tryParse(
            queryParams['availability'] ?? '',
          );
          final useAvailableProductsApi = bool.tryParse(
            queryParams['use_available'] ?? '',
          );
          final isSales = bool.tryParse(queryParams['is_sales'] ?? '');

          final extra = state.extra as Map<String, dynamic>? ?? {};
          final pickupTime = extra['pickup_time'] as TimeOfDay?;
          final returnTime = extra['return_time'] as TimeOfDay?;
          final preSelectedData =
              extra['pre_selected_data'] as List<ProductSelectedModel>?;

          if (serviceId == null || pickupDate == null || returnDate == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid product selection. Please try again.'),
              ),
            );
          }

          return SelectProductScreen(
            serviceId: serviceId,
            pickupDate: pickupDate,
            returnDate: returnDate,
            availabilityCheckOnly: availabilityCheckOnly ?? false,
            pickupTime: pickupTime,
            returnTime: returnTime,
            preSelectedData: preSelectedData,
            useAvailableProductsApi: useAvailableProductsApi ?? true,
            isSales: isSales ?? false,
            // isSameDateAsOldBooking: isSameDateAsOldBooking,
          );
        },
      ),

      // Staffs screen
      // GoRoute(
      //   path: AppRoutes.staffs.path,
      //   name: AppRoutes.staffs.name,
      //   builder: (context, state) {
      //     context.read<StaffListBloc>().add(const StaffListEvent.loadStaffs());
      //     return const StaffListScreen();
      //   },
      // ),

      // // Staff analytics screen
      // GoRoute(
      //   path: AppRoutes.staffAnalytics.path,
      //   name: AppRoutes.staffAnalytics.name,
      //   builder: (context, state) {
      //     final staffId = state.pathParameters['id']?.toIntOrNull();
      //     final staffName = state.uri.queryParameters['name'];

      //     if (staffId == null || staffName == null) {
      //       return Scaffold(
      //         appBar: AppBar(),
      //         body: const Center(
      //           child: Text('Invalid staff analytics. Please try again.'),
      //         ),
      //       );
      //     }

      //     return BlocProvider(
      //       create: (_) => StaffAnalyticsBloc(repository: getIt.get())
      //         ..add(
      //           StaffAnalyticsEvent.getStaffAnalytics(
      //             staffId: staffId,
      //             year: DateTime.now().year,
      //             month: DateTime.now().month,
      //           ),
      //         ),
      //       child: StaffAnalyticsScreen(staffId: staffId, staffName: staffName),
      //     );
      //   },
      // ),

      // Clients screen
      GoRoute(
        path: AppRoutes.clients.path,
        name: AppRoutes.clients.name,
        builder: (context, state) => const ClientListScreen(),
      ),

      // Transfer product history screen
      // GoRoute(
      //   path: AppRoutes.productTransferHistory.path,
      //   name: AppRoutes.productTransferHistory.name,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => TransferProductHistoryBloc(
      //       productRepo: getIt.get(),
      //       userRepo: getIt.get(),
      //     )..add(const TransferProductHistoryEvent.loadTransferHistory()),
      //     child: const TransferProductHistoryScreen(),
      //   ),
      // ),

      // // Change Account Password screen
      // GoRoute(
      //   path: AppRoutes.changeAccountPassword.path,
      //   name: AppRoutes.changeAccountPassword.name,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => ResetPasswordBloc(
      //       changePasswordRepo: getIt.get(),
      //       authRepo: getIt.get(),
      //     ),
      //     child: const ResetPasswordScreen(),
      //   ),
      // ),

      // // Change Secret Password screen
      // GoRoute(
      //   path: AppRoutes.changeSecretPassword.path,
      //   name: AppRoutes.changeSecretPassword.name,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => SecretPasswordBloc(repository: getIt.get()),
      //     child: const ChangeSecretPasswordScreen(),
      //   ),
      // ),

      // // Settings screen
      // GoRoute(
      //   path: AppRoutes.settings.path,
      //   name: AppRoutes.settings.name,
      //   builder: (context, state) => const SettingsScreen(),
      // ),

      // More options screen
      // GoRoute(
      //   path: AppRoutes.profileMore.path,
      //   name: AppRoutes.profileMore.name,
      //   builder: (context, state) => const MoreOptionsScreen(),
      // ),

      // Contact and support screen
      GoRoute(
        path: AppRoutes.contactAndSupport.path,
        name: AppRoutes.contactAndSupport.name,
        builder: (context, state) => const ContactAndSupportScreen(),
      ),

      // About screen
      GoRoute(
        path: AppRoutes.aboutUs.path,
        name: AppRoutes.aboutUs.name,
        builder: (context, state) => const AboutScreen(),
      ),

      // Manage secret password screen
      // GoRoute(
      //   path: AppRoutes.manageSecretPassword.path,
      //   name: AppRoutes.manageSecretPassword.name,
      //   builder: (context, state) {
      //     final passwordSettings =
      //         state.extra as List<UserPasswordSettingsModel>?;
      //     if (passwordSettings == null) {
      //       debugPrint('No password settings provided');
      //     }
      //     return BlocProvider(
      //       create: (context) => ManagePasswordSettingsBloc(getIt.get())
      //         ..add(ManagePasswordSettingsEvent.load(passwordSettings ?? [])),
      //       child: const ManagePasswordScreen(),
      //     );
      //   },
      // ),

      // Add booking - date selecting screen
      // GoRoute(
      //   path: AppRoutes.addBookingDate.path,
      //   name: AppRoutes.addBookingDate.name,
      //   builder: (context, state) => const AddBookingDateSelectingScreen(),
      // ),

      // Add booking - select service screen
      GoRoute(
        path: AppRoutes.addBookingSelectService.path,
        name: AppRoutes.addBookingSelectService.name,
        builder: (context, state) {
          final queryParams = state.uri.queryParameters;
          final pickupDate = queryParams['pickup_date'];
          final returnDate = queryParams['return_date'];
          final isEdit = queryParams['is_edit'] == 'true';
          // final isSameDateAsOldBooking =
          //      == 'true';
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final pickupTime = extra['pickup_time'] as TimeOfDay?;
          final returnTime = extra['return_time'] as TimeOfDay?;
          final addBookingModel =
              extra['add_booking_model'] as RequestBookingModel?;
          final preSelectedData =
              extra['pre_selected_data'] as List<ProductSelectedModel>?;

          if (pickupDate == null ||
              returnDate == null ||
              pickupDate.isEmpty ||
              returnDate.isEmpty ||
              (!isEdit && addBookingModel == null)) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid booking date and data. Please try again.'),
              ),
            );
          }
          return SelectServiceScreen(
            onServiceSelected: (service, ctx) async {
              // debugPrint('Selected service: ${service.name}');

              final bookingData = addBookingModel?.copyWith(
                serviceId: service.id,
              );

              final data = await ctx.pushNamed(
                AppRoutes.selectProducts.name,
                pathParameters: {'service_id': service.id.toString()},
                queryParameters: {
                  'pickup_date': pickupDate,
                  'return_date': returnDate,
                  'is_same_date_as_old_booking':
                      queryParams['is_same_date_as_old_booking'],
                },
                extra: <String, dynamic>{
                  'pickup_time': pickupTime,
                  'return_time': returnTime,
                  'pre_selected_data': preSelectedData,
                },
              );
              log(
                'Returned from product selection with data: $data, type: ${data.runtimeType}',
              );
              if (data != null &&
                  (data is List<ProductSelectedModel> && data.isNotEmpty)) {
                if (isEdit) {
                  //if editing a booking, pop twice to go back to edit screen with new data
                  NavigatorX(context).pop(data);
                  return;
                }
                //if adding new booking, go to product review screen
                await context.pushNamed(
                  AppRoutes.addBookingProductReview.name,
                  extra: {
                    'selected_products': data,
                    'add_booking_model': bookingData,
                  },
                );
              } else {
                log('No products selected, returning to date selection');
                return;
              }
            },
          );
        },
      ),

      // Add booking - product review screen
      GoRoute(
        path: AppRoutes.addBookingProductReview.path,
        name: AppRoutes.addBookingProductReview.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final selectedProducts =
              extra['selected_products'] as List<ProductSelectedModel>?;
          final addBookingModel =
              extra['add_booking_model'] as RequestBookingModel?;
          if (selectedProducts == null) {
            debugPrint('No selected products provided');
          }

          if (addBookingModel == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid booking details. Please try again.'),
              ),
            );
          }
          return BlocProvider(
            create: (context) =>
                AddBookingProductsCubit()..setAll(selectedProducts ?? []),
            child: AddBookingProductScreen(addBookingModel: addBookingModel),
          );
        },
      ),

      // Add booking - booking details(client and staff) screen
      GoRoute(
        path: AppRoutes.addBookingDetails.path,
        name: AppRoutes.addBookingDetails.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final addBookingModel =
              extra['add_booking_model'] as RequestBookingModel?;
          if (addBookingModel == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid booking details. Please try again.'),
              ),
            );
          }
          return AddBookingClientDetailsScreen(
            addBookingModel: addBookingModel,
          );
        },
      ),

      // Add booking - payment screen
      GoRoute(
        path: AppRoutes.addBookingPayment.path,
        name: AppRoutes.addBookingPayment.name,
        builder: (context, state) {
          final whatsappNumber =
              state.uri.queryParameters['whatsapp_number'] ?? '';
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final addBookingModel =
              extra['add_booking_model'] as RequestBookingModel?;
          if (addBookingModel == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid booking details. Please try again.'),
              ),
            );
          }
          return AddBookingPaymentScreen(
            newBooking: addBookingModel,
            whatsAppPhoneNumber: whatsappNumber,
          );
        },
      ),

      // Success animation screen
      GoRoute(
        path: AppRoutes.successAnimation.path,
        name: AppRoutes.successAnimation.name,
        builder: (context, state) {
          final afterSuccess = state.extra as VoidCallback?;
          final message = state.uri.queryParameters['message'] ?? 'Success';
          return SuccessAnimationScreen(
            text: message,
            afterSuccess: afterSuccess,
          );
        },
      ),

      // Product details screen
      GoRoute(
        path: AppRoutes.productDetails.path,
        name: AppRoutes.productDetails.name,
        builder: (context, state) {
          final productId = state.pathParameters['id']?.toIntOrNull();
          final serviceId = state.uri.queryParameters['service_id']
              ?.toIntOrNull();
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final mainServiceType =
              extra['main_service_type'] as MainServiceType?;
          if (productId == null ||
              mainServiceType == null ||
              serviceId == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid product details. Please try again.'),
              ),
            );
          }
          return BlocProvider(
            create: (context) =>
                ProductInfoBloc(repository: getIt.get())
                  ..add(ProductInfoEvent.loadProductInfo(productId)),
            child: ProductInfoScreen(
              serviceId: serviceId,
              productId: productId,
              mainServiceType: mainServiceType,
            ),
          );
        },
      ),

      // Transfer product screen
      GoRoute(
        path: AppRoutes.productTransfer.path,
        name: AppRoutes.productTransfer.name,
        builder: (context, state) {
          final variantId = state.pathParameters['variant_id']?.toIntOrNull();
          final serviceId = state.uri.queryParameters['service_id']
              ?.toIntOrNull();
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final mainServiceType =
              extra['main_service_type'] as MainServiceType?;
          final product = extra['product'] as ProductModel?;
          if (variantId == null ||
              mainServiceType == null ||
              serviceId == null ||
              product == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid product details. Please try again.'),
              ),
            );
          }
          return TransferProductScreen(
            serviceId: serviceId,
            product: product,
            variantId: variantId,
            mainServiceType: mainServiceType,
          );
        },
      ),

      // Transfer product select and transfer screen
      GoRoute(
        path: AppRoutes.productSelectAndTransfer.path,
        name: AppRoutes.productSelectAndTransfer.name,
        builder: (context, state) {
          final fromVariantId = state.uri.queryParameters['from_variant_id']
              ?.toIntOrNull();
          final toShopId = state.uri.queryParameters['to_shop_id']
              ?.toIntOrNull();
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final fromProduct = extra['from_product'] as ProductInfoModel?;
          if (fromVariantId == null ||
              fromProduct == null ||
              toShopId == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid product details. Please try again.'),
              ),
            );
          }
          return MultiBlocProvider(
            providers: [
                // BlocProvider(
                //   create: (context) =>
                    // MatchingProductBloc(repository: getIt.get())..add(
                    //   MatchingProductEvent.loadMatchingProducts(
                    //     fromVariantId: fromVariantId,
                    //     toShopId: toShopId,
                    //   ),
                    // ),
              // ),
              // BlocProvider(
              //   // create: (context) =>
              //   //     TransferProductCubit(repository: getIt.get()),
              // ),
            ],
            child: TransferProductSelectAndTransferProductScreen(
              fromVariantId: fromVariantId,
              toShopId: toShopId,
              fromProduct: fromProduct,
            ),
          );
        },
      ),

      // Transfer animation screen
      // GoRoute(
      //   path: AppRoutes.productTransferAnimation.path,
      //   name: AppRoutes.productTransferAnimation.name,
      //   builder: (context, state) => TransferAnimationScreen(
      //     afterSuccess: () {
      //       context
      //         ..pop()
      //         ..pop()
      //         ..pop(true)
      //         ..showSnackBar('Product transferred successfully');
      //     },
      //   ),
      // ),

      // Add or edit product screen
      GoRoute(
        path: AppRoutes.productAdd.path,
        name: AppRoutes.productAdd.name,
        builder: (context, state) {
          final serviceId = state.pathParameters['service_id']?.toIntOrNull();
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final product = extra['product'] as ProductModel?;
          if (serviceId == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid product details. Please try again.'),
              ),
            );
          }
          return AddOrEditProductScreen(serviceId: serviceId, product: product);
        },
      ),

      // Product growth screen
      GoRoute(
        path: AppRoutes.productGrowth.path,
        name: AppRoutes.productGrowth.name,
        builder: (context, state) {
          final productId = state.pathParameters['id']?.toIntOrNull();
          if (productId == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('Invalid product details. Please try again.'),
              ),
            );
          }
          return BlocProvider(
            create: (context) =>
                ProductGrowthBloc()
                  ..add(ProductGrowthEvent.loadProductGrowthData(productId)),
            child: ProductGrowthScreen(productId: productId),
          );
        },
      ),

      // Product all bookings screen
      GoRoute(
        path: AppRoutes.productBookings.path,
        name: AppRoutes.productBookings.name,
        builder: (context, state) {
          final productId = state.pathParameters['id']?.toIntOrNull();
          if (productId == null) {
            return const CustomRouteErrorScreen(
              message: 'Invalid product details. Please try again.',
            );
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProductBookingUpcomingBloc(
                  repository: getIt.get(),
                )..add(ProductBookingUpcomingEvent.loadBookings(productId)),
              ),
              BlocProvider(
                create: (context) => ProductBookingCompletedBloc(
                  repository: getIt.get(),
                )..add(ProductBookingCompletedEvent.loadBookings(productId)),
              ),
            ],
            child: ProductAllBookingsScreen(productId: productId),
          );
        },
      ),

      // Add measurements screen
      GoRoute(
        path: AppRoutes.addCustomization.path,
        name: AppRoutes.addCustomization.name,
        builder: (context, state) {
          final measurements = state.extra as List<MeasurementValueModel>?;
          if (measurements == null) {
            return const CustomRouteErrorScreen(
              message: 'Invalid measurements. Please try again.',
            );
          }

          return AddCustomizationScreen(addedMeasurements: measurements);
        },
      ),

      // Add old booking - select service screen
      GoRoute(
        path: AppRoutes.addOldBookingSelectService.path,
        name: AppRoutes.addOldBookingSelectService.name,
        builder: (context, state) {
          final pickupDate = state.uri.queryParameters['pickup_date'];
          final returnDate = state.uri.queryParameters['return_date'];

          final preSelectedData = state.extra as List<ProductSelectedModel>?;

          if (pickupDate == null ||
              returnDate == null ||
              pickupDate.isEmpty ||
              returnDate.isEmpty) {
            return const CustomRouteErrorScreen(
              message: 'Invalid old booking dates. Please try again.',
            );
          }
          return SelectServiceScreen(
            onServiceSelected: (service, ctx) async {
              final data = await ctx.pushNamed(
                AppRoutes.selectProducts.name,
                pathParameters: {'service_id': service.id.toString()},
                queryParameters: {
                  'pickup_date': pickupDate,
                  'return_date': returnDate,
                  'use_available': 'false',
                },
                extra: <String, dynamic>{'pre_selected_data': preSelectedData},
              );
              log(
                'Returned from product selection with data: $data, type: ${data.runtimeType}',
              );
              NavigatorX(context).pop(data);
            },
          );
        },
      ),

      // Add Sales  - select service screen
      GoRoute(
        path: AppRoutes.addSalesSelectService.path,
        name: AppRoutes.addSalesSelectService.name,
        builder: (context, state) {
          final pickupDate = state.uri.queryParameters['pickup_date'];
          final returnDate = state.uri.queryParameters['return_date'];

          final preSelectedData = state.extra as List<ProductSelectedModel>?;

          if (pickupDate == null ||
              returnDate == null ||
              pickupDate.isEmpty ||
              returnDate.isEmpty) {
            return const CustomRouteErrorScreen(
              message: 'Invalid sales dates. Please try again.',
            );
          }
          return SelectServiceScreen(
            onServiceSelected: (service, ctx) async {
              final data = await ctx.pushNamed(
                AppRoutes.selectProducts.name,
                pathParameters: {'service_id': service.id.toString()},
                queryParameters: {
                  'pickup_date': pickupDate,
                  'return_date': returnDate,
                  'use_available': 'false',
                  'is_sales': 'true',
                },
                extra: <String, dynamic>{'pre_selected_data': preSelectedData},
              );
              log(
                'Returned from product selection with data: $data, type: ${data.runtimeType}',
              );
              NavigatorX(context).pop(data);
            },
          );
        },
      ),

      // Staff Analytics sales
      // GoRoute(
      //   path: AppRoutes.staffAnalyticsSales.path,
      //   name: AppRoutes.staffAnalyticsSales.name,
      //   builder: (context, state) {
      //     final staffId = state.pathParameters['id']?.toIntOrNull();
      //     final year = state.uri.queryParameters['year']?.toIntOrNull();
      //     final month = state.extra as Month?;
      //     if (staffId == null || month == null || year == null) {
      //       return const CustomRouteErrorScreen(
      //         message: 'Invalid staff analytics. Please try again.',
      //       );
      //     }

      //     return BlocProvider(
      //       create: (context) =>
      //           StaffAnalyticsSalesBloc(repository: getIt.get())..add(
      //             StaffAnalyticsSalesEvent.loadSales(
      //               staffId: staffId,
      //               month: month.number,
      //               year: year,
      //             ),
      //           ),
      //       child: StaffAnalyticsSalesScreen(
      //         month: month,
      //         staffId: staffId,
      //         year: year,
      //       ),
      //     );
      //   },
      // ),

      // Staff Analytics bookings
      // GoRoute(
      //   path: AppRoutes.staffAnalyticsBookings.path,
      //   name: AppRoutes.staffAnalyticsBookings.name,
      //   builder: (context, state) {
      //     final staffId = state.pathParameters['id']?.toIntOrNull();
      //     final year = state.uri.queryParameters['year']?.toIntOrNull();
      //     final month = state.extra as Month?;
      //     if (staffId == null || month == null || year == null) {
      //       return const CustomRouteErrorScreen(
      //         message: 'Invalid staff analytics. Please try again.',
      //       );
      //     }

      //     return BlocProvider(
      //       create: (context) =>
      //           StaffAnalyticsBookingsBloc(repository: getIt.get())..add(
      //             StaffAnalyticsBookingsEvent.loadBookings(
      //               staffId: staffId,
      //               month: month.number,
      //               year: year,
      //             ),
      //           ),
      //       child: StaffAnalyticsBookingsScreen(
      //         month: month,
      //         staffId: staffId,
      //         year: year,
      //       ),
      //     );
      //   },
      // ),

      // staff deleted screen
      // GoRoute(
      //   path: AppRoutes.staffsDeleted.path,
      //   name: AppRoutes.staffsDeleted.name,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) =>
      //         StaffDeletedListBloc(repository: getIt.get())
      //           ..add(const StaffDeletedListEvent.loadStaffs()),
      //     child: const StaffDeletedListScreen(),
      //   ),
      // ),
    ],

    // Handle errors globally
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.error.toString()),
            const SizedBox(height: 20),
            CustomNormalElevatedButton(
              text: 'Go to Home',
              onPressed: () {
                context.goNamed(AppRoutes.home.name);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class CustomRouteErrorScreen extends StatelessWidget {
  const CustomRouteErrorScreen({
    super.key,
    this.message = 'Invalid details. Please try again.',
  });
  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Center(child: Text(message)),
  );
}
