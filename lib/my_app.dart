// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookie_buddy_web/features/staff/view_model/bloc_staff_list/staff_list_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:bookie_buddy_web/core/theme/app_theme.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_product_search/product_search_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/bloc_add_booking/add_booking_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/bloc_client_save/client_save_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/cubit_add_booking_products/add_booking_products_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/auth/view_model/bloc_auth/auth_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/completed_bookings/view_model/bloc_completed_bookings/completed_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/home/repository/dashboard_repository.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product/product_bloc.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_save_product/save_product_cubit.dart';
import 'package:bookie_buddy_web/features/profile/repository/bug_report_repository.dart';
import 'package:bookie_buddy_web/features/profile/view_model/cubit_bug_report/bug_report_cubit.dart';
import 'package:bookie_buddy_web/features/save_expense/view_model/cubit_save_expense/save_expense_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddBookingProductsCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (context) =>
              UserCubit(repository: getIt.get())..loadUserIfNot(),
        ),
        BlocProvider(create: (context) => SaveExpenseCubit()),
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
            create: (context) => SelectProductBloc(repository: getIt.get())),
        BlocProvider(
          create: (context) => ServiceBloc(repository: getIt.get())
            ..add(const ServiceEvent.loadServices()),
        ),
        BlocProvider(create: (context) => SelectedProductsCubit()),
        BlocProvider(
          create: (context) => DashboardBloc(
            repository: getIt.get<DashboardRepository>(),
            userCubit: context.read<UserCubit>(),
          )..add(
              const DashboardEvent.loadDashboardData(),
            ),
        ),
        BlocProvider(
          create: (context) => StaffListBloc(repository: getIt.get())
            ..add(const StaffListEvent.loadStaffs()),
        ),
        BlocProvider(
            create: (context) => BookingDetailsPaymentHistoryCubit()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(
            create: (context) => StaffSearchCubit(repository: getIt.get())),
        BlocProvider(
          create: (context) => StaffListBloc(repository: getIt.get())
            ..add(const StaffListEvent.loadStaffs()),
        ),
        BlocProvider(create: (context) => SaveProductCubit()),
        BlocProvider(create: (context) => BookingSelectionCubit()),
        BlocProvider(
          create: (context) =>
              ShopListBloc(shopRepo: getIt.get(), userRepo: getIt.get()),
        ),
        BlocProvider(create: (context) => ClientCubit(repository: getIt.get())),
        BlocProvider(
            create: (context) => ClientSaveBloc(repository: getIt.get())),
        BlocProvider(
            create: (context) => ProductSearchCubit(repository: getIt.get())),
        BlocProvider(
            create: (context) => BugReportCubit(BugReportRepository())),
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
