import 'dart:developer';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';

import 'package:bookie_buddy_web/features/all_booking/view/widgets/all_booking_empty_widget.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/core/models/desktop_booking_model/desktop_booking_item_model_extensions.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBookingFutureTab extends StatelessWidget {
  final ValueNotifier<DateFilterModel> dateFilterNotifier;
  final TextEditingController searchController;
  const AllBookingFutureTab({
    super.key,
    required this.dateFilterNotifier,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllBookingBloc>();
    return BlocListener<AllBookingBloc, AllBookingState>(
      listener: (context, state) {
        state.mapOrNull(
          loaded: (s) {
            if (s.actionError != null) {
              context.showSnackBar(s.actionError!, isError: true);
            }
          },
        );
      },
      child: RefreshIndicator.adaptive(
        onRefresh: () async => _fetchBookingsWithFilter(context),
        child: BlocBuilder<AllBookingBloc, AllBookingState>(
          builder: (context, state) => state.when(
            initial: () => const Center(child: Text('No bookings')),
            error: (error) => CustomErrorWidget(
              errorText: error,
              onRetry: () => _fetchBookingsWithFilter(context),
            ),
            loading: () => kIsWeb
                ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) => const BookingCardShimmer(),
                  )
                : const BookingListShimmer(itemCount: 10),
            loaded: (bookings, nextPageUrl, isPaginating, startDate, endDate,
                searchQuery, status, statusCounts, actionError) {
              if (bookings.isEmpty) {
                return AllBookingEmptyWidget(
                  dateFilterNotifier: dateFilterNotifier,
                  onClearButtonPressed: () => _clearDateFilter(context),
                );
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200 &&
                      nextPageUrl != null &&
                      !isPaginating) {
                    bloc.add(const AllBookingEvent.loadNextPageBookings());
                  }

                  return false;
                },
                child: kIsWeb
                    ? GridView.builder(
                        key: const PageStorageKey('all-booking-future-grid'),
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: bookings.length + (isPaginating ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < bookings.length) {
                            final booking = bookings[index];

                            return BookingCard(
                              booking: booking.toBookingsModel(),
                              onTap: () async {
                                final result = await context.push(
                                  BookingDetailsScreen(bookingId: booking.id),
                                );
                                // If deleted or modified, refresh the entire list
                                if (result == true) {
                                  log('Booking deleted, removing from list');
                                  // Reload bookings to reflect changes
                                  _fetchBookingsWithFilter(context);
                                }
                              },
                            );
                          } else {
                            return const BookingCardShimmer();
                          }
                        },
                      )
                    : ListView.builder(
                        key: const PageStorageKey('all-booking-future-list'),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: bookings.length + (isPaginating ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < bookings.length) {
                            final booking = bookings[index];

                            return BookingCard(
                              booking: booking.toBookingsModel(),
                              onTap: () async {
                                final result = await context.push(
                                  BookingDetailsScreen(bookingId: booking.id),
                                );
                                // If deleted or modified, refresh the entire list
                                if (result == true) {
                                  log('Booking deleted, removing from list');
                                  // Reload bookings to reflect changes
                                  _fetchBookingsWithFilter(context);
                                }
                              },
                            );
                          } else {
                            return const BookingCardShimmer();
                          }
                        },
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _clearDateFilter(BuildContext context) {
    dateFilterNotifier.value = const DateFilterModel();

    _fetchBookingsWithFilter(context);
  }

  void _fetchBookingsWithFilter(BuildContext context) {
    // Add your date filter parameters to the bloc event
    // You'll need to modify your AllBookingEvent to accept date parameters
    context.read<AllBookingBloc>().add(
          AllBookingEvent.loadBookings(
            startDate:
                dateFilterNotifier.value.startDate?.format(reverse: true),
            endDate: dateFilterNotifier.value.endDate?.format(reverse: true),
            searchQuery: searchController.text.trim().isEmpty
                ? null
                : searchController.text.trim(),
          ),
        );
  }
}
