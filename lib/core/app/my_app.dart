// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/save_product_cubit/save_product_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_list_bloc/staff_list_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/routing/app_router.dart';
import 'package:bookie_buddy_web/core/theme/app_theme.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/product_search_cubit/product_search_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/bloc_add_booking/add_booking_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/bloc_client_save/client_save_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/cubit_add_booking_products/add_booking_products_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/completed_bookings/view_model/bloc_completed_bookings/completed_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/product_bloc/product_bloc.dart';
import 'package:bookie_buddy_web/features/profile/presentation/bloc/bug_report_cubit/bug_report_cubit.dart';
import 'package:bookie_buddy_web/features/expense/presentation/bloc/save_expense_cubit/save_expense_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddBookingProductsCubit()),
        BlocProvider(create: (context) => AuthBloc(loginUseCase: getIt.get())),
        BlocProvider(
          create: (context) =>
              UserCubit(repository: getIt.get())..loadUserIfNot(),
        ),
        BlocProvider(
            create: (context) => SaveExpenseCubit(
                saveExpenseUsecase: getIt.get(),
                saveProductExpenseUsecase: getIt.get())),
        BlocProvider(
            create: (context) => AllBookingBloc(repository: getIt.get())),
        BlocProvider(
            create: (context) =>
                CompletedBookingsBloc(repository: getIt.get())),
        BlocProvider(
            create: (context) => BookingDetailsBloc(repository: getIt.get())),
        BlocProvider(
            create: (context) =>
                AddBookingBloc(bookingRepository: getIt.get())),
        BlocProvider(
            create: (context) => SelectProductBloc(
                  getAvailableProducts: getIt(),
                  getProducts: getIt(),
                  searchAndFilterProducts: getIt(),
                )),
        BlocProvider(
          create: (context) => ServiceBloc(repository: getIt.get())
            ..add(const ServiceEvent.loadServices()),
        ),
        BlocProvider(create: (context) => SelectedProductsCubit()),
        BlocProvider(
          create: (context) => DashboardBloc(
            getDashboardDesktopDataUseCase: getIt.get(),
            userCubit: context.read<UserCubit>(),
          )..add(
              const DashboardEvent.loadDashboardData(),
            ),
        ),
        BlocProvider(
          create: (context) => StaffListBloc(
            getStaffs: getIt.get(),
            addStaff: getIt.get(),
            editStaff: getIt.get(),
            deleteStaff: getIt.get(),
          )..add(const StaffListEvent.loadStaffs()),
        ),
        BlocProvider(create: (context) => BookingDetailsPaymentHistoryCubit()),
        BlocProvider(
            create: (context) => ProductBloc(
                  getProducts: getIt.get(),
                  searchAndFilterProducts: getIt.get(),
                )),
        BlocProvider(
          create: (context) => StaffSearchCubit(getStaffs: getIt.get()),
        ),
        BlocProvider(
            create: (context) => SaveProductCubit(
                  saveProduct: getIt.get(),
                )),
        BlocProvider(create: (context) => BookingSelectionCubit()),
        BlocProvider(
          create: (context) =>
              ShopListBloc(shopRepo: getIt.get(), userRepo: getIt.get()),
        ),
        BlocProvider(
          create: (context) => ClientCubit(getClients: getIt.get()),
        ),
        BlocProvider(
          create: (context) => ClientSaveBloc(addClient: getIt.get()),
        ),
        BlocProvider(
            create: (context) =>
                ProductSearchCubit(searchAllProductsUseCase: getIt.get())),
        BlocProvider(
            create: (context) =>
                BugReportCubit(submitBugReportUseCase: getIt.get())),
      ],
      child: MaterialApp(
        title: 'BookieBuddy',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        // darkTheme: AppTheme.darkTheme, // Dark theme is not complete
        themeMode: ThemeMode.light,
        locale: const Locale('en', 'US'), // 12-hour format
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English (12-hour format)
        ],
        builder: (context, child) {
          // Force minimum size at Material App level
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(
                MediaQuery.of(context).size.width < 1280
                    ? 1280
                    : MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height < 720
                    ? 720
                    : MediaQuery.of(context).size.height,
              ),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const SplashScreen(),
      ),
    );
  }
}
