import 'package:bookie_buddy_web/core/constants/enums/booking_list_filter_enum.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/pages/all_bookings_desktop_screen.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_carousel_entity/desktop_dashboard_carousel_entity.dart';
import 'package:flutter/material.dart';

class CarouselDashboard extends StatelessWidget {
  final DesktopDashboardCarouselEntity data;
  final void Function(BookingListFilter statusTab)? onNavigateToBookings;

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
                gradient: const [Color(0xFF4C0FFF), Color(0xFF8A63FE)],
                icon: Icons.schedule,
                onTap: () => _openAllBookingsWithTab(
                  context,
                  BookingListFilter.upcoming,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildCard(
                context,
                title: 'Completed',
                value: data.completedCount.toString(),
                gradient: const [Color(0xFF015DFF), Color(0xFF05ADFF)],
                icon: Icons.check_circle,
                onTap: () => _openAllBookingsWithTab(
                  context,
                  BookingListFilter.completed,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildCard(
                context,
                title: 'Expired',
                value: data.expiredCount.toString(),
                gradient: const [Color(0xFFFF4757), Color(0xFFFF6B7A)],
                icon: Icons.event_busy,
                onTap: () => _openAllBookingsWithTab(
                  context,
                  BookingListFilter.notReturned,
                ),
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
            color: gradient.first.withValues(alpha: 0.3),
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
                  color: Colors.white.withValues(alpha: 0.2),
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
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigate to AllBookingsDesktopScreen with specific tab
  void _openAllBookingsWithTab(
    BuildContext context,
    BookingListFilter statusTab,
  ) {
    // Use callback if available (navigates within bottom bar)
    if (onNavigateToBookings != null) {
      onNavigateToBookings!(statusTab);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AllBookingsDesktopScreen(initialStatusTab: statusTab),
      ),
    );
  }
}
