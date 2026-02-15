import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Redesigned dashboard with two columns showing upcoming and ongoing bookings
class HomeBookingTwoColumnWidget extends StatelessWidget {
  const HomeBookingTwoColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Row(
            children: [
              Expanded(child: BookingListShimmer(itemCount: 6)),
              SizedBox(width: 24),
              Expanded(child: BookingListShimmer(itemCount: 6)),
            ],
          ),
          error: (error) => Center(
            child: Text('Error: $error'),
          ),
          loaded: (upcomingGrouped, returnsGrouped, _, __, ___, ____, _____) {
            // Get all bookings from groups
            final upcomingBookings =
                upcomingGrouped.values.expand((bookings) => bookings).toList();
            final ongoingBookings =
                returnsGrouped.values.expand((bookings) => bookings).toList();

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upcoming Column
                Expanded(
                  child: _buildBookingColumn(
                    context,
                    title: 'Upcoming Bookings',
                    icon: Icons.schedule,
                    bookings: upcomingBookings,
                    color: const Color(0xFF667eea),
                    useReturnDate: false,
                  ),
                ),
                const SizedBox(width: 24),
                // Ongoing Column
                Expanded(
                  child: _buildBookingColumn(
                    context,
                    title: 'Ongoing Bookings',
                    icon: Icons.access_time,
                    bookings: ongoingBookings,
                    color: const Color(0xFF06b6d4),
                    useReturnDate: true,
                  ),
                ),
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildBookingColumn(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<BookingsModel> bookings,
    required Color color,
    required bool useReturnDate,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${bookings.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Booking List
          if (bookings.isEmpty)
            const Expanded(
              child: Center(
                child: NoResultFoundAnimationWidget(isScrollable: false),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: BookingCard(
                      booking: booking,
                      useReturnDate: useReturnDate,
                      onTap: () async {
                        final bookingCubit =
                            context.read<BookingSelectionCubit>();
                        bookingCubit.selectBooking(booking);

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookingDetailsScreen(
                              bookingId: booking.id!,
                            ),
                          ),
                        );

                        if (bookingCubit.state.isModified) {
                          final updated = bookingCubit.state.selectedBooking;

                          context.read<DashboardBloc>().add(
                                DashboardEvent.updateData(
                                  updated,
                                  shouldRefresh:
                                      bookingCubit.state.shouldRefresh,
                                ),
                              );

                          bookingCubit.reset();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class BookingListShimmer extends StatelessWidget {
  final int itemCount;

  const BookingListShimmer({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
