import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/edit_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/generate_booking_pdf.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/enums.dart';

class BookingDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  BookingDetailsAppBar({
    super.key,
  });
  final isProcessing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Booking Details',
      ),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: isProcessing,
          builder: (context, value, child) {
            return BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
              builder: (context, state) {
                final booking = state.maybeWhen(
                  orElse: () => null,
                  loaded: (b) => b,
                );
                final isLoading = booking == null;
                return IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: value ||
                          isLoading //if the data is loading the function is disabled
                      ? null
                      : () async {
                          isProcessing.value = true;
                          final shopData = context.read<UserCubit>().state;
                          if (shopData == null) {
                            CustomSnackBar(
                              message: 'Shop data not available',
                            );
                            isProcessing.value = false;
                            return;
                          }
                          try {
                            await GenerateBookingPdf.shareInvoice(
                              context: context,
                              bookingDetails: booking,
                              businessImageUrl: shopData.shopeImage!,
                              businessName: shopData.shopName,
                              businessPhone: shopData.shopPhone,
                              businessLocation: shopData.shopAddress,
                              termsAndConditions: shopData.termsAndConditions,
                            );
                          } catch (e, stack) {
                            log(e.toString(), stackTrace: stack);
                            CustomSnackBar(
                              message: 'Failed to generate PDF: $e',
                            );
                          } finally {
                            isProcessing.value = false;
                          }
                        },
                );
              },
            );
          },
        ),
        BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
          builder: (context, state) {
            final booking = state.maybeWhen(
              orElse: () => null,
              loaded: (b) => b,
            );
            final isBookingCompleted =
                booking?.bookingStatus == BookingStatus.completed;
            return PopupMenuButton(
              borderRadius: 5.radiusBorder,
              color: Colors.white,
              tooltip: 'Actions',
              icon: const Icon(
                Icons.more_vert,
              ),
              itemBuilder: (context) {
                bool isEditVisible = true;
                if (booking != null &&
                    booking.bookedItems.any(
                      (element) => element.variantId == null,
                    )) {
                  print('variantId is null, returning from edit action');
                  isEditVisible = false;
                }
                return [
                  //edit
                  if (isEditVisible && !isBookingCompleted)
                    PopupMenuItem<int>(
                      value: 0,
                      onTap: () {
                        if (booking == null) {
                          print('booking is null, returning from edit action');
                          return;
                        }

                        context.push(BlocProvider(
                          create: (context) => UpdateBookingCubit(),
                          child: EditBookingScreen(booking: booking),
                        ));
                      },
                      child: const Row(
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: AppColors.purple,
                          ),
                          Text('Edit'),
                        ],
                      ),
                    ),

                  // delete
                  PopupMenuItem<int>(
                    value: 1,
                    onTap: () {
                      if (booking == null) {
                        print('booking is null, returning from delete action');
                        return;
                      }

                      performSecureActionDialog(
                        context,
                        'delete',
                        bookingId: booking.id,
                      );
                    },
                    child: const Row(
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: AppColors.redTomato,
                        ),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ];
              },
            );
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
