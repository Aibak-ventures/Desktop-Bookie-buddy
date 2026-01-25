import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_details_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:flutter/material.dart';

class BookingDetailsOtherDetailsSection extends StatelessWidget {
  const BookingDetailsOtherDetailsSection({super.key, required this.booking});

  final BookingDetailsModel booking;

  @override
  Widget build(BuildContext context) => BookingDetailsSection(
        title: '',
        padding: 12.padding,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingDetailsDetailsColumn(
              label: 'Staff name',
              value: booking.staffName ?? 'N/A',
            ),
            BookingDetailsDetailsColumn(
              label: 'Purchase mode',
              value: booking.purchaseMode.name,
            ),
            if (booking.description != null &&
                booking.description!.isNotEmpty) ...[
              BookingDetailsDetailsColumn(
                label: 'Description',
                value: booking.description!,
              ),
            ],
          ],
        ),
      );
}
