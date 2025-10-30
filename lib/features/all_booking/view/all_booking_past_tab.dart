import 'dart:developer';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view/widgets/all_booking_empty_widget.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking_past/all_booking_past_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBookingPastTab extends StatelessWidget {
  final ValueNotifier<DateFilterModel> dateFilterNotifier;
  final TextEditingController searchController;
  const AllBookingPastTab({
    super.key,
    required this.dateFilterNotifier,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllBookingPastBloc>();
    return RefreshIndicator.adaptive(
      onRefresh: () async => _fetchBookingsWithFilter(context),
      child: BlocBuilder<AllBookingPastBloc, AllBookingPastState>(
        builder: (context, state) => state.when(
          error: (error) => CustomErrorWidget(
            errorText: error,
            onRetry: () => _fetchBookingsWithFilter(context),
          ),
          loading: () => kIsWeb 
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => const BookingCardShimmer(),
                )
              : const BookingListShimmer(itemCount: 10),
          loaded:
              (
                bookings,
                nextPageUrl,
                isPaginating,
                startDate,
                endDate,
                searchQuery,
              ) {
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
                      bloc.add(
                        const AllBookingPastEvent.loadNextPageBookings(),
                      );
                    }

                    return false;
                  },
                  child: kIsWeb
                      ? GridView.builder(
                          key: const PageStorageKey('all-booking-past-grid'),
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                booking: booking,
                                onTap: () async {
                                  final bookingCubit =
                                      context.read<BookingSelectionCubit>()
                                        ..selectBooking(booking);

                                  final result = await context.push(
                                    BookingDetailsScreen(bookingId: booking.id!),
                                  );
                                  if (bookingCubit.state.isModified) {
                                    final updated =
                                        bookingCubit.state.selectedBooking;

                                    // Update that specific booking in your list
                                    bloc.add(
                                      AllBookingPastEvent.updateBooking(
                                        updated,
                                        shouldRefresh:
                                            bookingCubit.state.shouldRefresh,
                                        isDeleted: result == true,
                                      ),
                                    );
                                    log('update booking called');

                                    bookingCubit.reset();
                                  }
                                },
                              );
                            } else {
                              return const BookingCardShimmer();
                            }
                          },
                        )
                      : ListView.builder(
                          key: const PageStorageKey('all-booking-past-list'),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: bookings.length + (isPaginating ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < bookings.length) {
                              final booking = bookings[index];

                              return BookingCard(
                                booking: booking,
                                onTap: () async {
                                  final bookingCubit =
                                      context.read<BookingSelectionCubit>()
                                        ..selectBooking(booking);

                                  final result = await context.push(
                                    BookingDetailsScreen(bookingId: booking.id!),
                                  );
                                  if (bookingCubit.state.isModified) {
                                    final updated =
                                        bookingCubit.state.selectedBooking;

                                    // Update that specific booking in your list
                                    bloc.add(
                                      AllBookingPastEvent.updateBooking(
                                        updated,
                                        shouldRefresh:
                                            bookingCubit.state.shouldRefresh,
                                        isDeleted: result == true,
                                      ),
                                    );
                                    log('update booking called');

                                    bookingCubit.reset();
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
    );
  }

  void _clearDateFilter(BuildContext context) {
    dateFilterNotifier.value = const DateFilterModel();

    _fetchBookingsWithFilter(context);
  }

  void _fetchBookingsWithFilter(BuildContext context) {
    // Add your date filter parameters to the bloc event
    // You'll need to modify your AllBookingPastEvent to accept date parameters
    context.read<AllBookingPastBloc>().add(
      AllBookingPastEvent.loadBookings(
        startDate: dateFilterNotifier.value.startDate?.format(reverse: true),
        endDate: dateFilterNotifier.value.endDate?.format(reverse: true),
        searchQuery: searchController.text.trim().isEmpty
            ? null
            : searchController.text.trim(),
      ),
    );
  }
}
