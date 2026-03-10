import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
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
  Widget build(BuildContext context) => Column(
        children: [
          BookingDetailsSection(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.w),
                    decoration: BoxDecoration(
                      color: booking.deliveryStatus.color.lighten(0.9),
                      borderRadius: 40.radiusBorder,
                    ),
                    child: RepaintBoundary(
                      child: DropdownButton<DeliveryStatus>(
                        isExpanded: true,
                        alignment: Alignment.center,
                        value: booking.deliveryStatus,
                        underline: const SizedBox(),
                        dropdownColor: AppColors.white,
                        isDense: true,
                        borderRadius: 10.radiusBorder,
                        onChanged:
                            booking.bookingStatus == BookingStatus.completed
                                ? null
                                : (newValue) {
                                    if (newValue != null &&
                                        newValue != booking.deliveryStatus) {
                                      _confirmStatusChange(context, newValue);
                                    }
                                  },
                        selectedItemBuilder: (BuildContext context) {
                          return DeliveryStatus.values.map((status) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                status.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: status.color,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                ),
                              ),
                            );
                          }).toList();
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
          ),
          // Booking Status Cards - Completed or Cancelled
          if (booking.bookingStatus == BookingStatus.completed ||
              booking.bookingStatus == BookingStatus.cancelled) ...[
            SizedBox(height: 16.h),
            _buildStatusIndicatorCard(booking),
          ],
        ],
      );

  Widget _buildStatusIndicatorCard(BookingDetailsModel booking) {
    final isCompleted = booking.bookingStatus == BookingStatus.completed;
    final statusColor = isCompleted ? Colors.green : Colors.red;
    final backgroundColor =
        isCompleted ? Colors.green.shade50 : Colors.red.shade50;
    final borderColor =
        isCompleted ? Colors.green.shade200 : Colors.red.shade200;
    final iconData = isCompleted ? Icons.check_circle : Icons.cancel;
    final statusText = isCompleted ? 'Booking Completed' : 'Booking Cancelled';
    final dateText = booking.bookingCompletedDate;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: 8.radiusBorder,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: statusColor,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
                if (dateText != null && dateText.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '${isCompleted ? "Completed" : "Cancelled"} at: ${dateText.formatToUiDate()}',
                    style: TextStyle(
                      color: statusColor.withOpacity(0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

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
