import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_details_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsDateSection extends StatelessWidget {
  const BookingDetailsDateSection({
    super.key,
    required this.booking,
    required this.isHaveCoolingPeriod,
  });

  final BookingDetailsModel booking;
  final bool isHaveCoolingPeriod;

  @override
  Widget build(BuildContext context) => BookingDetailsSection(
        title: '',
        padding: 12.padding,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 15.w,
          runSpacing: 15.w,
          children: [
            BookingDetailsDetailsColumn(
              label: 'Booked date',
              value: booking.bookedDate.formatToUiDate(),
            ),
            if (isHaveCoolingPeriod) 50.width,
            BookingDetailsDetailsColumn(
              label: 'Pickup date',
              value: booking.pickupDate?.formatToUiDate() ?? 'N/A',
            ),
            BookingDetailsDetailsColumn(
              label: 'Return date',
              value: booking.returnDate.formatToUiDate(),
            ),
            if (isHaveCoolingPeriod)
              BookingDetailsDetailsColumn(
                label: 'Cooling period',
                value: booking.coolingPeriodDate!.formatToUiDate(),
              ),
          ],
        ),
      );
}
