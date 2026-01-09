import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsInvoiceAndDeliveryStatusSection extends StatelessWidget {
  const BookingDetailsInvoiceAndDeliveryStatusSection({
    super.key,
    required this.booking,
  });

  final BookingDetailsModel booking;

  @override
  Widget build(BuildContext context) => BookingDetailsSection(
        title: '',
        child: null,
        leading: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking Id',
                style: TextStyle(
                  color: Color(0xFF707070),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: 8.padding,
                decoration: BoxDecoration(
                  color: AppColors.purpleLightShade,
                  borderRadius: 5.radiusBorder,
                ),
                child: Text(
                  'ID: ${booking.invoiceId}',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Delivery status
        trailing: Column(
          children: [
            Text(
              'Delivery Status',
              style: TextStyle(
                color: Color(0xFF707070),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 180),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.w),
                decoration: BoxDecoration(
                  color: booking.deliveryStatus.color.lighten(0.9),
                  borderRadius: 40.radiusBorder,
                ),
                child: RepaintBoundary(
                  child: DropdownButton<DeliveryStatus>(
                    alignment: Alignment.center,
                    value: booking.deliveryStatus,
                    underline: const SizedBox(),
                    dropdownColor: AppColors.white,
                    isDense: true,
                    borderRadius: 10.radiusBorder,
                    onChanged: booking.bookingStatus == BookingStatus.completed
                        ? null
                        : (newValue) {
                            if (newValue != null &&
                                newValue != booking.deliveryStatus) {
                              _confirmStatusChange(context, newValue);
                            }
                          },
                    items: DeliveryStatus.values
                        .map(
                          (status) => DropdownMenuItem<DeliveryStatus>(
                            alignment: Alignment.center,
                            value: status,
                            child: Text(
                              status.name,
                              style: TextStyle(
                                color: status.color,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void _confirmStatusChange(BuildContext context, DeliveryStatus newStatus) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Status Change'),
        content: Text(
          "Are you sure you want to change the status to '${newStatus.name}'?",
        ),
        actions: [
          TextButton(onPressed: () => ctx.pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              context.pop();

              context.read<BookingDetailsBloc>().add(
                    BookingDetailsEvent.updateDeliveryStatus(
                      bookingId: booking.id,
                      deliveryStatus: newStatus,
                    ),
                  );
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
