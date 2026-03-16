import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/widgets/product_booking_list_widget.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_booking_upcoming_bloc/product_booking_upcoming_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBookingUpcomingTab extends StatelessWidget {
  const ProductBookingUpcomingTab({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context
            .read<ProductBookingUpcomingBloc>()
            .add(ProductBookingUpcomingEvent.loadBookings(productId));
      },
      child:
          BlocBuilder<ProductBookingUpcomingBloc, ProductBookingUpcomingState>(
        builder: (context, state) {
          return state.when(
            error: (error) => CustomErrorWidget(
              errorText: error,
              onRetry: () => context
                  .read<ProductBookingUpcomingBloc>()
                  .add(ProductBookingUpcomingEvent.loadBookings(productId)),
            ),
            loading: BookingListShimmer.new,
            loaded: (bookings, nextPageUrl, isPaginating) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >
                          scrollInfo.metrics.maxScrollExtent - 100 &&
                      nextPageUrl != null &&
                      !isPaginating) {
                    context.read<ProductBookingUpcomingBloc>().add(
                          ProductBookingUpcomingEvent.loadNextBooking(
                            productId,
                          ),
                        );
                  }
                  return false;
                },
                child: ProductBookingListWidget(
                  bookings: bookings,
                  pageStorageKey: 'product-booking-upcoming-tab-key',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
