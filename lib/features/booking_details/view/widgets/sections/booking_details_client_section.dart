import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/utils/open_external_applications.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_details_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BookingDetailsClientSection extends StatelessWidget {
  const BookingDetailsClientSection({super.key, required this.booking});
  final BookingDetailsModel booking;
  @override
  Widget build(BuildContext context) => BookingDetailsSection(
        title: '',
        padding: 18.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: BookingDetailsDetailsColumn(
                label: 'Name',
                value: booking.client.name,
              ),
            ),
            BookingDetailsDetailsColumn(
              label: 'Phone 1',
              value: (booking.client.phone1 == 0)
                  ? 'Number not provided'
                  : booking.client.phone1.toString(),
              trailing: (booking.client.phone1 != 0)
                  ? [
                      _launchPhoneCall(phone: booking.client.phone1.toString()),
                      25.width,
                      _launchWhatsApp(phone: booking.client.phone1.toString()),
                    ]
                  : null,
            ),
            BookingDetailsDetailsColumn(
              label: 'Phone 2',
              value:
                  (booking.client.phone2 == null || booking.client.phone2 == 0)
                      ? 'Number not provided'
                      : booking.client.phone2.toString(),
              trailing: (booking.client.phone2 != null &&
                      booking.client.phone2 != 0)
                  ? [
                      _launchPhoneCall(phone: booking.client.phone2.toString()),
                      25.width,
                      _launchWhatsApp(phone: booking.client.phone2.toString()),
                    ]
                  : null,
            ),
            if (booking.address != null && booking.address!.isNotEmpty)
              BookingDetailsDetailsColumn(
                  label: 'Place', value: booking.address!),
          ],
        ),
      );
}

class _launchPhoneCall extends StatelessWidget {
  const _launchPhoneCall({required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) =>
      Icon(Icons.phone, size: 18.sp).onTapInkWell(
        () => OpenExternalApplications.makePhoneCall(phoneNumber: phone),
      );
}

class _launchWhatsApp extends StatelessWidget {
  const _launchWhatsApp({required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        AppAssets.whatsAppSvg,
        colorFilter: const ColorFilter.mode(
          Color.fromARGB(255, 33, 192, 92), // WhatsApp green color
          BlendMode.srcIn,
        ),
        semanticsLabel: 'WhatsApp Icon',
        width: 20,
        height: 20,
      ).onTapInkWell(
          () => OpenExternalApplications.launchWhatsApp(phone: phone));
}
