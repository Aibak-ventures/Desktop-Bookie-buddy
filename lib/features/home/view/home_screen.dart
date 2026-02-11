import 'package:bookie_buddy_web/core/api/baseurl.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/home/models/dashboard_list_model.dart';
import 'package:bookie_buddy_web/features/home/view/widgets/carousel_home.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Current used domain: $baseUrl ✅');
    final bloc = context.read<DashboardBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: _buildDesktopLayout(context, bloc),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, DashboardBloc bloc) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, bloc),
              const SizedBox(height: 24),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    bloc.add(
                      const DashboardEvent.loadDashboardData(
                        useOldState: true,
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCard(
                          title: 'Overview',
                          child: SizedBox(
                            height: 120, // Reduced from 160
                            child: CarouselHome(data: bloc.carouselResponse),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Recent Bookings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Two column layout without tabs
                        SizedBox(
                          height: 600, // Fixed height for scrollable columns
                          child: BlocBuilder<DashboardBloc, DashboardState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                loaded: (dataGrouped, _, __, ___, ____) {
                                  return _buildTwoColumnBookings(
                                      context, dataGrouped, bloc);
                                },
                                orElse: () => const SizedBox.shrink(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DashboardBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<UserCubit, UserModel?>(
          builder: (context, user) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Hello ',
                    children: [
                      TextSpan(
                        text: '${user?.userFullName ?? 'Owner'}!',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF667eea),
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Have a nice day',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            );
          },
        ),
        IconButton(
          onPressed: () {
            bloc.add(
              const DashboardEvent.loadDashboardData(useOldState: true),
            );
          },
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  /// Two column layout showing Upcoming and Ongoing bookings
  Widget _buildTwoColumnBookings(
    BuildContext context,
    Map<String, List<DashboardListModel>> dataGrouped,
    DashboardBloc bloc,
  ) {
    final upcomingBookings = dataGrouped['upcoming']
            ?.where((item) => item.isBooking && item.booking != null)
            .toList() ??
        [];
    final ongoingBookings = dataGrouped['ongoing']
            ?.where((item) => item.isBooking && item.booking != null)
            .toList() ??
        [];

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
            bloc: bloc,
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
            bloc: bloc,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingColumn(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<DashboardListModel> bookings,
    required Color color,
    required bool useReturnDate,
    required DashboardBloc bloc,
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
                  final booking = bookings[index].booking!;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: BookingCard(
                      booking: booking,
                      useReturnDate: useReturnDate,
                      onTap: () async {
                        final bookingCubit =
                            context.read<BookingSelectionCubit>();
                        bookingCubit.selectBooking(booking);

                        await context.push(
                          BookingDetailsScreen(bookingId: booking.id!),
                        );

                        if (bookingCubit.state.isModified) {
                          final updated = bookingCubit.state.selectedBooking;

                          bloc.add(
                            DashboardEvent.updateData(
                              DashboardListModel(
                                isBooking: true,
                                booking: updated,
                              ),
                              shouldRefresh: bookingCubit.state.shouldRefresh,
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
