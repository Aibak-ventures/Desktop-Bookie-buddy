import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/complete_booking_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteElevatedButton extends StatelessWidget {
  const CompleteElevatedButton({super.key});
  @override
  Widget build(BuildContext context) {
    final booking = context
        .read<BookingDetailsBloc>()
        .state
        .maybeWhen(orElse: () => null, loaded: (booking) => booking);

    // If booking is null, show a disabled button
    if (booking == null) {
      return CustomElevatedButton(
        height: 55.h,
        text: 'Complete Work',
        width: double.infinity,
        isNormal: true,

        onPressed: () {}, // No-op
      );
    }

    final isBookingCompleted = booking.bookingStatus == BookingStatus.completed;
    final balanceAmount = booking.totalAmount -
        booking.paidAmount -
        (booking.discountAmount ?? 0);

    return CustomElevatedButton(
      height: isBookingCompleted ? 65.h : 55.h,
      text: isBookingCompleted ? 'Work completed' : 'Complete Work',
      subText: isBookingCompleted
          ? 'On - ${booking.bookingCompletedDate?.formatToUiDate() ?? booking.returnDate.formatToUiDate()}'
          : null,
      backgroundColor: isBookingCompleted ? AppColors.green2Light : null,
      textColor: isBookingCompleted ? AppColors.green2 : null,
      isNormal: !isBookingCompleted,
      width: double.infinity,
      onPressed: isBookingCompleted
          ? () {}
          : () {
              if (balanceAmount > 0) {
                CustomSnackBar(
                  title: "Pending Payment",
                  message:
                      "Please clear the balance amount of ₹$balanceAmount before completing the work",
                );
                return;
              }

              if (booking.deliveryStatus != DeliveryStatus.delivered) {
                CustomSnackBar(
                  title: "Pending Delivery",
                  message:
                      "Please complete the delivery before completing the work",
                );
                return;
              }

              showCompleteBookingDialog(
                context: context,
                onConfirm: () async {
                  context.read<BookingDetailsBloc>().add(
                        BookingDetailsEvent.updateBookingStatus(
                          bookingId: booking.id,
                          bookingStatus: BookingStatus.completed,
                        ),
                      );

                  context
                      .read<BookingSelectionCubit>()
                      .markModified(shouldRefresh: true);
                },
              );
            },
    );
  }
}
