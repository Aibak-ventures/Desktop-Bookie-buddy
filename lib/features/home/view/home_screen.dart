import 'package:bookie_buddy_web/core/api/baseurl.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/home/models/desktop_dashboard_response.dart';
import 'package:bookie_buddy_web/features/home/view/widgets/carousel_home.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final void Function(String statusTab)? onNavigateToBookings;

  const HomeScreen({super.key, this.onNavigateToBookings});

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
                          child: BlocBuilder<DashboardBloc, DashboardState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                loaded: (_, __, carouselData, ___, ____, _____,
                                    ______) {
                                  return SizedBox(
                                    height: 120,
                                    child: CarouselHome(
                                      data: carouselData,
                                      onNavigateToBookings: onNavigateToBookings,
                                    ),
                                  );
                                },
                                orElse: () => SizedBox(
                                  height: 120,
                                  child: CarouselHome(
                                    data: DesktopDashboardCarouselData.empty(),
                                    onNavigateToBookings: onNavigateToBookings,
                                  ),
                                ),
                              );
                            },
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
                        _buildTwoColumnBookings(context),
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

  /// Two column layout showing Upcoming and Returns bookings with Today/Tomorrow/Upcoming grouping
  Widget _buildTwoColumnBookings(
    BuildContext context,
  ) {
    return SizedBox(
      height: 600, // Fixed height for scrollable columns
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (upcomingGrouped, returnsGrouped, _, __, ___, ____, _____) {
              // Calculate total counts
              final upcomingCount = upcomingGrouped.values
                  .fold<int>(0, (sum, list) => sum + list.length);
              final returnsCount = returnsGrouped.values
                  .fold<int>(0, (sum, list) => sum + list.length);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upcoming Column
                  Expanded(
                    child: _buildBookingColumn(
                      context,
                      title: 'Upcoming Bookings',
                      icon: Icons.schedule,
                      groupedBookings: upcomingGrouped,
                      totalCount: upcomingCount,
                      color: const Color(0xFF667eea),
                      useReturnDate: false,
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Returns Column (renamed from Ongoing)
                  Expanded(
                    child: _buildBookingColumn(
                      context,
                      title: 'Returns Booking',
                      icon: Icons.assignment_return,
                      groupedBookings: returnsGrouped,
                      totalCount: returnsCount,
                      color: const Color(0xFFff8a00),
                      useReturnDate: true,
                    ),
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildBookingColumn(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Map<String, List<BookingsModel>> groupedBookings,
    required int totalCount,
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
          // Header with total count
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
                    '$totalCount',
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
          // Booking List with Today/Tomorrow/Upcoming sections
          if (totalCount == 0)
            const Expanded(
              child: Center(
                child: NoResultFoundAnimationWidget(isScrollable: false),
              ),
            )
          else
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Today Section
                  if (groupedBookings['today']?.isNotEmpty == true) ...[
                    _buildDateSection(
                      context,
                      title: 'Today',
                      bookings: groupedBookings['today']!,
                      color: Colors.red,
                      useReturnDate: useReturnDate,
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Tomorrow Section
                  if (groupedBookings['tomorrow']?.isNotEmpty == true) ...[
                    _buildDateSection(
                      context,
                      title: 'Tomorrow',
                      bookings: groupedBookings['tomorrow']!,
                      color: Colors.orange,
                      useReturnDate: useReturnDate,
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Upcoming Section
                  if (groupedBookings['upcoming']?.isNotEmpty == true) ...[
                    _buildDateSection(
                      context,
                      title: 'Upcoming',
                      bookings: groupedBookings['upcoming']!,
                      color: Colors.blue,
                      useReturnDate: useReturnDate,
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDateSection(
    BuildContext context, {
    required String title,
    required List<BookingsModel> bookings,
    required Color color,
    required bool useReturnDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Container(
              width: 4,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${bookings.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Bookings list
        ...bookings.map((booking) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: BookingCard(
                booking: booking,
                useReturnDate: useReturnDate,
                onTap: () async {
                  final bookingCubit = context.read<BookingSelectionCubit>();
                  bookingCubit.selectBooking(booking);

                  await context.push(
                    BookingDetailsScreen(bookingId: booking.id!),
                  );

                  if (bookingCubit.state.isModified) {
                    final updated = bookingCubit.state.selectedBooking;

                    context.read<DashboardBloc>().add(
                          DashboardEvent.updateData(
                            updated,
                            shouldRefresh: bookingCubit.state.shouldRefresh,
                          ),
                        );

                    bookingCubit.reset();
                  }
                },
              ),
            )),
      ],
    );
  }
}
