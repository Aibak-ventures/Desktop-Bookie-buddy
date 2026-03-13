import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_bookings_desktop_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_sales/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_sales_details/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_sales_details_drawer/sales_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/desktop_dashboard_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselDashboard extends StatelessWidget {
  final DesktopDashboardCarouselData data;
  final void Function(String statusTab)? onNavigateToBookings;

  const CarouselDashboard({
    required this.data,
    this.onNavigateToBookings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Row(
          children: [
            Expanded(
              child: _buildCard(
                context,
                title: 'Upcoming',
                value: data.upcomingCount.toString(),
                gradient: const [
                  Color(0xFF4C0FFF),
                  Color(0xFF8A63FE),
                ],
                icon: Icons.schedule,
                onTap: () => _openAllBookingsWithTab(context, 'upcoming'),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildCard(
                context,
                title: 'Completed',
                value: data.completedCount.toString(),
                gradient: const [
                  Color(0xFF015DFF),
                  Color(0xFF05ADFF),
                ],
                icon: Icons.check_circle,
                onTap: () => _openAllBookingsWithTab(context, 'completed'),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildCard(
                context,
                title: 'Expired',
                value: data.expiredCount.toString(),
                gradient: const [
                  Color(0xFFFF4757),
                  Color(0xFFFF6B7A),
                ],
                icon: Icons.event_busy,
                onTap: () => _openAllBookingsWithTab(context, 'not_returned'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String value,
    required List<Color> gradient,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(10), // Reduced from 24
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(12), // Reduced from 16
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.3),
            blurRadius: 16, // Reduced from 20
            offset: const Offset(0, 6), // Reduced from 8
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white, size: 24), // Reduced from 32
              Container(
                padding: const EdgeInsets.all(6), // Reduced from 8
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6), // Reduced from 8
                ),
                child: const Icon(
                  Icons.arrow_outward,
                  color: Colors.white,
                  size: 16, // Reduced from 20
                ),
              ).onTap(onTap),
            ],
          ),
          // const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28, // Reduced from 32
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2), // Reduced from 4
          Text(
            title,
            style: TextStyle(
              fontSize: 14, // Reduced from 16
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigate to AllBookingsDesktopScreen with specific tab
  void _openAllBookingsWithTab(BuildContext context, String statusTab) {
    // Use callback if available (navigates within bottom bar)
    if (onNavigateToBookings != null) {
      onNavigateToBookings!(statusTab);
      return;
    }

    // Fallback to pushing a new route
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AllBookingBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (_) => BookingDetailsDrawerCubit(),
            ),
            BlocProvider(
              create: (_) => BookingDetailsBloc(
                repository: getIt.get<BookingRepository>(),
              ),
            ),
            BlocProvider(
              create: (_) => BookingDetailsPaymentHistoryCubit(),
            ),
            BlocProvider(
              create: (_) => AllSalesBloc(
                repository: getIt.get<SalesRepository>(),
              ),
            ),
            BlocProvider(
              create: (_) => SalesDetailsDrawerCubit(),
            ),
            BlocProvider(
              create: (_) => SalesDetailsBloc(
                repository: getIt.get<SalesRepository>(),
              ),
            ),
          ],
          child: AllBookingsDesktopScreen(initialStatusTab: statusTab),
        ),
      ),
    );
  }
}
