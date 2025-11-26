import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/buttons/custom_swipe_button.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/dialogs/complete_booking_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteElevatedButton extends StatelessWidget {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final CustomSwipeButtonController? swipeButtonController;
  CompleteElevatedButton({
    super.key,
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.swipeButtonController,
  });

  @override
  Widget build(BuildContext context) {
    final booking = context.read<BookingDetailsBloc>().getBooking();

    final isBookingCompleted =
        booking?.bookingStatus == BookingStatus.completed;
    final balanceAmount = (booking?.totalAmount ?? 0) -
        (booking?.paidAmount ?? 0) -
        (booking?.discountAmount ?? 0);

    return !isBookingCompleted
        ? CustomSwipeButton(
            text: 'Swipe to Complete',
            height: 55.h,
            isFailure: isFailure,
            isLoading: isLoading,
            isSuccess: isSuccess,
            controller: swipeButtonController,
            onSwipe: () async {
              if (booking == null) return;
              swipeButtonController?.setLoading();
              if (balanceAmount > 0) {
                context.showSnackBar(
                  'Collect ₹$balanceAmount before completing.',
                  title: 'Payment Pending',
                  isError: true,
                );
                debugPrint('Balance amount: $balanceAmount');
                swipeButtonController?.setFailure();
                return;
              }

              if (booking.deliveryStatus != DeliveryStatus.returned) {
                context.showSnackBar(
                  "Change the delivery status to 'Returned' before completing this booking.",
                  title: 'Return Pending',
                  isError: true,
                );
                swipeButtonController?.setFailure();
                return;
              }

              await showCompleteBookingDialog(
                context: context,
                onCancel: () => swipeButtonController?.reset(),
                onConfirm: () async {
                  context.read<BookingDetailsBloc>().add(
                        BookingDetailsEvent.updateBookingStatus(
                          bookingId: booking.id,
                          bookingStatus: BookingStatus.completed,
                        ),
                      );

                  context.read<BookingSelectionCubit>().markModified(
                        shouldRefresh: true,
                      );
                },
              );
            },
          )
        : CustomElevatedButton(
            height: 65.h,
            text: 'Booking completed',
            subText:
                'On - ${booking?.bookingCompletedDate?.formatToUiDate() ?? booking?.returnDate.formatToUiDate() ?? ''}',
            backgroundColor: AppColors.green2Light,
            textColor: AppColors.green2,
            isNormal: !isBookingCompleted,
            width: double.infinity,
            onPressed: () {},
          );
  }
}
