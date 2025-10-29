import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsLocationDetailsSection extends StatelessWidget {
  const BookingDetailsLocationDetailsSection({
    super.key,
    required this.locationStart,
    required this.locationFrom,
    required this.locationTo,
  });

  final String locationStart;
  final String locationFrom;
  final String locationTo;

  @override
  Widget build(BuildContext context) => BookingDetailsSection(
    title: '',
    padding: 18.padding,
    child: Column(
      spacing: 15,
      children: [
        Row(
          children: [
            const Expanded(child: _BookingDetailsText('Start Location')),
            Expanded(
              child: _BookingDetailsText(
                locationStart.isNotEmpty ? locationStart : 'Not available',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(child: _BookingDetailsText('Pickup Location')),
            Expanded(
              child: _BookingDetailsText(
                locationFrom.isNotEmpty ? locationFrom : 'Not available',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(child: _BookingDetailsText('Destination')),
            Expanded(
              child: _BookingDetailsText(
                locationTo.isNotEmpty ? locationTo : 'Not available',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _BookingDetailsText extends StatelessWidget {
  const _BookingDetailsText(this.text, {this.textAlign});
  final String text;
  final TextAlign? textAlign;
  final double fontSize = 14;
  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
  );
}
