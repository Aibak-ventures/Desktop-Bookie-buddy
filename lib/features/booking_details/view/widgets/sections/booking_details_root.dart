import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_client_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_date_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_invoice_and_delivery_status_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_location_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_other_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_payment_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_product_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_time_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsRoot extends StatelessWidget {
  const BookingDetailsRoot({
    required this.booking,
    required this.paymentButtonKey,
    super.key,
  });

  final BookingDetailsModel booking;
  final GlobalKey paymentButtonKey;

  @override
  Widget build(BuildContext context) {
    final paymentHistoryCubit = context
        .read<BookingDetailsPaymentHistoryCubit>();
    final isPaymentCompleted =
        booking.paidAmount >=
        (booking.totalAmount - (booking.discountAmount ?? 0));
    final locationStart = booking.otherDetails.locationStart ?? '';
    final locationFrom = booking.otherDetails.locationFrom ?? '';
    final locationTo = booking.otherDetails.locationTo ?? '';
    final isHaveCoolingPeriod =
        booking.coolingPeriodDate != null &&
        !booking.coolingPeriodDate!.parseToDateTime().isSameDay(
          booking.returnDate.parseToDateTime(),
        );
    final productTotalAmount = booking.bookedItems.fold<int>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
    final additionalChargesTotal = booking.additionalCharges.fold<int>(
      0,
      (previousValue, element) => previousValue + (element.amount ?? 0),
    );
    if (kDebugMode) {
      log(booking.toString(), name: 'BookingDetailsWidget');
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 15.h,
      children: [
        // Title row with invoice id and delivery status
        BookingDetailsInvoiceAndDeliveryStatusSection(booking: booking),

        // Client details section
        BookingDetailsClientSection(booking: booking),

        // Vehicle location details section
        if (booking.bookedItems.firstOrNull?.mainServiceType.isVehicle ?? false)
          BookingDetailsLocationDetailsSection(
            locationStart: locationStart,
            locationFrom: locationFrom,
            locationTo: locationTo,
          ),

        // Product details section
        BookingDetailsProductSection(booking: booking),

        // Time details section
        BookingDetailsTimeDetailsSection(booking: booking),

        // Date details section
        BookingDetailsDateSection(
          booking: booking,
          isHaveCoolingPeriod: isHaveCoolingPeriod,
        ),

        // Payment details section
        BookingDetailsPaymentDetailsSection(
          paymentButtonKey: paymentButtonKey,
          booking: booking,
          productTotalAmount: productTotalAmount,
          additionalChargesTotal: additionalChargesTotal,
          paymentHistoryCubit: paymentHistoryCubit,
          isPaymentCompleted: isPaymentCompleted,
        ),

        // Other details section
        BookingDetailsOtherDetailsSection(booking: booking),

        15.height,
      ],
    );
  }
}
