import 'dart:developer';

import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/home/models/booking_grouped_model/booking_grouped_model.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBookingListWidget extends StatefulWidget {
  const HomeBookingListWidget({super.key});

  @override
  State<HomeBookingListWidget> createState() => _HomeBookingListWidgetState();
}

class _HomeBookingListWidgetState extends State<HomeBookingListWidget>
    with SingleTickerProviderStateMixin {
  final searchTextController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final bloc = context.read<DashboardBloc>();
      // Refresh data when tab changes
      bloc.add(const DashboardEvent.loadDashboardData());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();
    final isDesktop = kIsWeb ||
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;

    return Column(
      children: [
        // Add TabBar for Upcoming and Returns
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Returns'),
          ],
        ),
        const SizedBox(height: 8),

        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const BookingListShimmer(
                itemCount: 12,
                alwaysScrollable: false,
              ),
              error: (error) => SizedBox(
                height: context.mediaQueryHeight(0.33),
                child: CustomErrorWidget(
                  errorText: error,
                  onRetry: () => bloc.add(
                    const DashboardEvent.loadDashboardData(
                      useOldState: true,
                    ),
                  ),
                ),
              ),
              loaded:
                  (upcomingGrouped, returnsGrouped, _, __, ___, ____, _____) {
                // Determine current data based on tab
                final isOngoing = _tabController.index == 1;
                final currentGrouped =
                    isOngoing ? returnsGrouped : upcomingGrouped;

                // Convert to BookingGroupedModel format for display
                final group = currentGrouped.entries
                    .map((e) => BookingGroupedModel(
                          date: e.key,
                          bookings: e.value,
                        ))
                    .where((group) => group.bookings.isNotEmpty)
                    .toList();

                return group.isEmpty
                    ? const NoResultFoundAnimationWidget(
                        isScrollable: false,
                      )
                    : isDesktop
                        ? _buildDesktopBookingList(
                            context, group, false, bloc, false)
                        : _buildMobileBookingList(
                            context, group, false, bloc, false);
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDesktopBookingList(
      BuildContext context,
      List<BookingGroupedModel> group,
      bool isPaginating,
      DashboardBloc bloc,
      bool isOngoing) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group.length + (isPaginating ? 1 : 0),
          itemBuilder: (context, groupIndex) {
            if (groupIndex == group.length && isPaginating) {
              return const BookingCardShimmer();
            }

            final sub = group[groupIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group Header - Desktop Style
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getGroupIcon(sub.date),
                        color: const Color(0xFF6B7280),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getGroupTitle(sub.date),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF667eea).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${sub.bookings.length}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF667eea),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Booking Cards - Desktop Layout
                ...sub.bookings.map<Widget>(
                  (BookingsModel booking) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: BookingCard(
                      booking: booking,
                      useReturnDate: isOngoing,
                      onTap: () async {
                        final bookingCubit =
                            context.read<BookingSelectionCubit>();
                        bookingCubit.selectBooking(booking);

                        await context.push(
                          BookingDetailsScreen(bookingId: booking.id!),
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
                          log('update booking called');

                          /// Optional: reset it
                          bookingCubit.reset();
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildMobileBookingList(
      BuildContext context,
      List<BookingGroupedModel> group,
      bool isPaginating,
      DashboardBloc bloc,
      bool isOngoing) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: group.length + (isPaginating ? 1 : 0),
      itemBuilder: (context, groupIndex) {
        if (groupIndex == group.length && isPaginating) {
          return const BookingCardShimmer();
        }

        final sub = group[groupIndex];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                _getGroupTitle(sub.date),
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            // Booking List
            ...sub.bookings.map<Widget>((BookingsModel booking) {
              return BookingCard(
                booking: booking,
                useReturnDate: isOngoing == true,
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
                    log('update booking called');

                    /// Optional: reset it
                    bookingCubit.reset();
                  }
                },
              );
            }),
          ],
        );
      },
    );
  }

  IconData _getGroupIcon(String dateKey) {
    switch (dateKey) {
      case 'today':
        return Icons.today;
      case 'tomorrow':
        return Icons.event;
      case 'upcoming':
        return Icons.schedule;
      default:
        return Icons.calendar_today;
    }
  }

  String _getGroupTitle(String dateKey) {
    switch (dateKey) {
      case 'today':
        return 'Today';
      case 'tomorrow':
        return 'Tomorrow';
      case 'upcoming':
        return 'Upcoming';
      default:
        return dateKey;
    }
  }
}
