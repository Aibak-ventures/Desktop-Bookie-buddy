import 'package:bookie_buddy_web/features/accounts/presentation/common/bloc/accounts_cubit/accounts_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/save_product_cubit/save_product_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/theme/app_theme.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/shop_list_bloc/shop_list_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/bloc/booking_selection_cubit/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/product_search_cubit/product_search_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_payment_history_cubit/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/product_bloc/product_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/selected_products_cubit/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(loginUseCase: getIt.get())),
        BlocProvider(
          create: (context) => UserCubit(
            getUser: getIt.get(),
            logout: getIt.get(),
            switchShop: getIt.get(),
            registerFCMToken: getIt.get(),
            userRepository: getIt.get(),
          )..loadUserIfNot(),
        ),
        BlocProvider(
          create: (context) => AllBookingBloc(
            updateDeliveryStatus: getIt.get(),
            deleteBooking: getIt.get(),
            updateBookingStatus: getIt.get(),
            loadDesktopBookings: getIt.get(),
          ),
        ),
        BlocProvider(
          create: (context) => BookingDetailsBloc(
            getBooking: getIt.get(),
            updateDeliveryStatus: getIt.get(),
            updateBookingStatus: getIt.get(),
            updatePayment: getIt.get(),
            deletePayment: getIt.get(),
            cancelBooking: getIt.get(),
            deleteBooking: getIt.get(),
          ),
        ),
        BlocProvider(
          create: (context) => SelectProductBloc(
            getAvailableProducts: getIt(),
            getProducts: getIt(),
            searchAndFilterProducts: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              ServiceBloc(getShopServices: getIt.get())
                ..add(const ServiceEvent.loadServices()),
        ),
        BlocProvider(create: (context) => SelectedProductsCubit()),
        BlocProvider(
          create: (context) => DashboardBloc(
            getDashboardDesktopDataUseCase: getIt.get(),
            userCubit: context.read<UserCubit>(),
          )..add(const DashboardEvent.loadDashboardData()),
        ),
        BlocProvider(create: (context) => BookingDetailsPaymentHistoryCubit()),
        BlocProvider(
          create: (context) => ProductBloc(
            getProducts: getIt.get(),
            searchAndFilterProducts: getIt.get(),
          ),
        ),
        BlocProvider(
          create: (context) => StaffSearchCubit(getStaffs: getIt.get()),
        ),
        BlocProvider(
          create: (context) => SaveProductCubit(saveProduct: getIt.get()),
        ),
        BlocProvider(create: (context) => BookingSelectionCubit()),
        BlocProvider(
          create: (context) =>
              ShopListBloc(getShops: getIt.get(), userRepo: getIt.get()),
        ),
        BlocProvider(
          create: (context) =>
              ClientCubit(getClients: getIt.get(), getClientById: getIt.get()),
        ),
        BlocProvider(create: (context) => AccountsCubit(getAccounts: getIt())),
        BlocProvider(
          create: (context) =>
              ProductSearchCubit(searchAllProductsUseCase: getIt.get()),
        ),
      ],
      child: MaterialApp(
        title: 'Bookie Buddy',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        // darkTheme: AppTheme.darkTheme, // Dark theme is not complete
        themeMode: ThemeMode.light,
        locale: const Locale('en', 'US'), // 12-hour format
        localizationsDelegates: [
          ...PhoneFieldLocalization.delegates,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
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
