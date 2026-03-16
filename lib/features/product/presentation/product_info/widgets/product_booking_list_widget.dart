import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:flutter/material.dart';

class ProductBookingListWidget extends StatelessWidget {
  const ProductBookingListWidget({
    super.key,
    required this.bookings,
    required this.pageStorageKey,
  });

  final List<BookingsModel> bookings;
  final String pageStorageKey;

  @override
  Widget build(BuildContext context) {
    return bookings.isEmpty
        ? const NoResultFoundAnimationWidget(
            adjustHeightTop: 0.15,
          )
        : ListView.builder(
            key: PageStorageKey(pageStorageKey),
            itemCount: bookings.length,
            // shrinkWrap: true,
            itemBuilder: (context, index) {
              final booking = bookings[index];

              return BookingCard(
                booking: booking,
                onTap: () async {
                  await context.push(
                    BookingDetailsScreen(
                      bookingId: booking.id!,
                    ),
                  );
                },
              );
            },
          );
  }
}
