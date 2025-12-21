import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_booking_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking_past/all_booking_past_bloc.dart';
import 'package:bookie_buddy_web/features/completed_bookings/view/completed_bookings_screen.dart';
import 'package:bookie_buddy_web/features/home/models/carousel_data_model/carousel_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselHome extends StatelessWidget {
  final CarouselDataModel data;

  const CarouselHome({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Row(
        children: [
          Expanded(
            child: _buildCard(
              context,
              title: 'Upcoming',
              value: data.upComingCount.toString(),
              gradient: const [
                Color(0xFF4C0FFF),
                Color(0xFF8A63FE),
              ],
              icon: Icons.schedule,
              onTap: () => _openAllBookings(context),
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
              onTap: () => context.push( CompletedBookingsScreen()),
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
              onTap: () => _openExpiredBookings(context),
            ),
          ),
        ],
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white, size: 32),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_outward,
                  color: Colors.white,
                  size: 20,
                ),
              ).onTap(onTap),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _openAllBookings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AllBookingBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (_) => AllBookingPastBloc(repository: getIt.get()),
            ),
          ],
          child:  AllBookingScreen(),
        ),
      ),
    );
  }

  void _openExpiredBookings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AllBookingBloc(repository: getIt.get()),
            ),
            BlocProvider(
              create: (_) => AllBookingPastBloc(repository: getIt.get()),
            ),
          ],
          child:  AllBookingScreen(index: 1),
        ),
      ),
    );
  }
}
