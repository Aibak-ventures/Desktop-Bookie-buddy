import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/home/models/booking_grouped_model/booking_grouped_model.dart';
import 'package:bookie_buddy_web/features/home/models/dashboard_list_model.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBookingListWidget extends StatelessWidget {
  HomeBookingListWidget({super.key});

  final searchTextController = TextEditingController();

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
        DefaultTabController(
          length: 2,
          child: TabBar(
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Returns'),
            ],
            onTap: (value) {
              if (value == 0) {
                bloc.add(const DashboardEvent.loadDashboardData());
              } else {
                bloc.add(
                  const DashboardEvent.loadDashboardData(isOngoing: true),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 8),

        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return state.when(
              loading: () => const BookingListShimmer(
                itemCount: 12,
                alwaysScrollable: false,
              ),
              error: (error) => SizedBox(
                height: context.mediaQueryHeight(0.33),
                child: CustomErrorWidget(
                  errorText: error,
                  onRetry: () =>
                      bloc.add(const DashboardEvent.loadDashboardData()),
                ),
              ),
              loaded: (dataGrouped, _, nextPageUrl, isPaginating, isOngoing) {
                final group = dataGrouped.entries
                    .where(
                      (group) => group.value.isNotEmpty,
                    )
                    .map((e) => BookingGroupedModel(
                        date: e.key,
                        bookings:
                            e.value.where((item) => item.isBooking).toList()))
                    .toList();

                return group.isEmpty
                    ? const NoResultFoundAnimationWidget(
                        isScrollable: false,
                      )
                    : isDesktop
                        ? _buildDesktopBookingList(
                            context, group, isPaginating, bloc, isOngoing)
                        : _buildMobileBookingList(
                            context, group, isPaginating, bloc, isOngoing);
              },
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
                ...sub.bookings.map(
                  (booking) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: BookingCard(
                      booking: booking.booking!,
                      useReturnDate: isOngoing,
                      onTap: () async {
                        final bookingCubit =
                            context.read<BookingSelectionCubit>();
                        bookingCubit.selectBooking(booking.booking!);

                        await context.push(
                          BookingDetailsScreen(bookingId: booking.booking!.id!),
                        );

                        if (bookingCubit.state.isModified) {
                          final updated = bookingCubit.state.selectedBooking;

                          context.read<DashboardBloc>().add(
                                DashboardEvent.updateData(
                                  DashboardListModel(
                                    isBooking: true,
                                    booking: updated,
                                  ),
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
            ...sub.bookings.map(
              (booking) => BookingCard(
               booking: booking.booking!,
                              useReturnDate: isOngoing == true,
                onTap: () async {
                  final bookingCubit = context.read<BookingSelectionCubit>();
                  bookingCubit.selectBooking(booking.booking!);

                  await context.push(
                    BookingDetailsScreen(bookingId: booking.booking!.id!),
                  );

                  if (bookingCubit.state.isModified) {
                    final updated = bookingCubit.state.selectedBooking;

                    context.read<DashboardBloc>().add(
                          DashboardEvent.updateData(
                            DashboardListModel(
                              isBooking: true,
                              booking: updated,
                            ),
                            shouldRefresh: bookingCubit.state.shouldRefresh,
                          ),
                        );
                    log('update booking called');

                    /// Optional: reset it
                    bookingCubit.reset();
                  }
                },
              ),
            ),
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
