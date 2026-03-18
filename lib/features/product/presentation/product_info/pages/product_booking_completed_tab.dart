import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/widgets/product_booking_list_widget.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_booking_completed_bloc/product_booking_completed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBookingCompletedTab extends StatelessWidget {
  const ProductBookingCompletedTab({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context
            .read<ProductBookingCompletedBloc>()
            .add(ProductBookingCompletedEvent.loadBookings(productId));
      },
      child: BlocBuilder<ProductBookingCompletedBloc,
          ProductBookingCompletedState>(
        builder: (context, state) {
          return state.when(
            error: (error) => CustomErrorWidget(
              errorText: error,
              onRetry: () => context
                  .read<ProductBookingCompletedBloc>()
                  .add(ProductBookingCompletedEvent.loadBookings(productId)),
            ),
            loading: BookingListShimmer.new,
            loaded: (bookings, nextPageUrl, isPaginating) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >
                          scrollInfo.metrics.maxScrollExtent - 100 &&
                      nextPageUrl != null &&
                      !isPaginating) {
                    context.read<ProductBookingCompletedBloc>().add(
                          ProductBookingCompletedEvent.loadNextBooking(
                              productId),
                        );
                  }
                  return false;
                },
                child: ProductBookingListWidget(
                  bookings: bookings,
                  pageStorageKey: 'product-booking-completed-tab-key',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
