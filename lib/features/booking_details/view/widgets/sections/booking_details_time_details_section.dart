import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_details_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsTimeDetailsSection extends StatelessWidget {
  const BookingDetailsTimeDetailsSection({super.key, required this.booking});

  final BookingDetailsModel booking;

  @override
  Widget build(BuildContext context) => BookingDetailsSection(
        title: '',
        padding: 12.padding,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 15.w,
          runSpacing: 15.w,
          children: [
            Text(
              'Pickup Time',
              style: TextStyle(
                color: Color(0xFF707070),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
         
          ],
        ),
      );
}
