import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_card.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_monthly_data_entity/product_monthly_data_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/widgets/monthly_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Right panel for [ProductDetailsScreen]: monthly bar chart + tabbed bookings.
class ProductDetailsRightPanel extends StatelessWidget {
  final ProductEntity product;
  final List<BookingEntity> bookings;
  final List<ProductMonthlyDataEntity> monthlySummary;
  final TabController tabController;

  const ProductDetailsRightPanel({
    super.key,
    required this.product,
    required this.bookings,
    required this.monthlySummary,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly Growth header
          const Row(
            children: [
              Icon(Icons.bar_chart, size: 20),
              SizedBox(width: 8),
              Text(
                'Monthly Growth',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: MonthlyBarChart(monthlyData: monthlySummary, height: 180),
          ),

          const SizedBox(height: 16),
          const SizedBox(height: 16),

          // Bookings section
          const Text(
            'Bookings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: TabBar(
              controller: tabController,
              labelColor: AppColors.purple,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: AppColors.purple,
              indicatorWeight: 2,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildBookingsList(
                  context,
                  bookings,
                  'No upcoming bookings',
                ),
                _buildBookingsList(
                  context,
                  bookings,
                  'No completed bookings',
                  isOngoing: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(
    BuildContext context,
    List<BookingEntity> bookings,
    String emptyMessage, {
    bool isOngoing = false,
  }) {
    if (bookings.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.event_busy_outlined,
                size: 48,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 12),
              Text(
                emptyMessage,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 12),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BookingCard(
            booking: booking,
            useReturnDate: isOngoing,
            onTap: () {
              context.read<BookingDetailsDrawerCubit>().openDrawer(booking.id!);
            },
          ),
        );
      },
    );
  }
}
