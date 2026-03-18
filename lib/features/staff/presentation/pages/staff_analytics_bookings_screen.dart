import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/route/app_routes.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_analytics_bookings_bloc/staff_analytics_bookings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StaffAnalyticsBookingsScreen extends StatelessWidget {
  const StaffAnalyticsBookingsScreen({
    super.key,
    required this.month,
    required this.staffId,
    required this.year,
  });
  final Month month;
  final int staffId;
  final int year;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('${month.value} Bookings')),
        body: Padding(
          padding: 12.padding,
          child: BlocBuilder<StaffAnalyticsBookingsBloc,
              StaffAnalyticsBookingsState>(
            builder: (context, state) => state.when(
              loading: () => ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => const BookingCardShimmer(),
              ),
              loaded: (bookings, nextPageUrl, isPaginating, _1, _2, _3) =>
                  RefreshIndicator.adaptive(
                onRefresh: () async => _fetchData(context),
                child: bookings.isEmpty
                    ? const EmptyDataWidget(
                        message: 'No bookings found for this month',
                        isScrollable: true,
                        isShowIcon: false,
                        height: 0.75,
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (!isPaginating &&
                              scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent - 100) {
                            context.read<StaffAnalyticsBookingsBloc>().add(
                                  const StaffAnalyticsBookingsEvent
                                      .loadNextPageBookings(),
                                );
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: bookings.length + (isPaginating ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= bookings.length) {
                              return const BookingCardShimmer();
                            }
                            final booking = bookings[index];
                            return BookingCard(
                              booking: booking,
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.bookingDetails.name,
                                  pathParameters: {'id': booking.id.toString()},
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
              error: (message) => CustomErrorWidget(
                errorText: message,
                onRetry: () {
                  _fetchData(context);
                },
              ),
            ),
          ),
        ),
      );

  void _fetchData(BuildContext context) {
    context.read<StaffAnalyticsBookingsBloc>().add(
          StaffAnalyticsBookingsEvent.loadBookings(
            staffId: staffId,
            month: month.number,
            year: year,
          ),
        );
  }
}
