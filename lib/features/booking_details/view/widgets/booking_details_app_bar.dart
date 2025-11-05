import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/edit_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/dialogs/show_delete_booking_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/generate_booking_pdf.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/enums.dart';

class BookingDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  BookingDetailsAppBar({super.key});
  final isProcessing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) => AppBar(backgroundColor: Colors.black,
    title: const Text('Booking Details',style: TextStyle(color: AppColors.white),),
    actions: [
      ValueListenableBuilder<bool>(
        valueListenable: isProcessing,
        builder: (context, value, child) =>
            BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
              builder: (context, state) {
                final booking = state.maybeWhen(
                  orElse: () => null,
                  loaded: (b) => b,
                );
                final isLoading = booking == null;
                return PopupMenuButton<String>(
  icon: const Icon(Icons.download, color: AppColors.black),
  tooltip: 'Download/Print Options',
  enabled: !value && !isLoading,
  itemBuilder: (context) => const [
    PopupMenuItem(
      value: 'pdf',
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf),
          SizedBox(width: 8),
          Text('Download PDF'),
        ],
      ),
    ),
    PopupMenuItem(
      value: 'print',
      child: Row(
        children: [
          Icon(Icons.print),
          SizedBox(width: 8),
          Text('Print Invoice'),
        ],
      ),
    ),
  ],
  onSelected: (action) async {
    if (booking == null) return;
    isProcessing.value = true;
    final shopData = context.read<UserCubit>().state?.shopDetails;
    if (shopData == null) {
      CustomSnackBar(message: 'Shop data not available');
      isProcessing.value = false;
      return;
    }

    try {
      if (action == 'pdf') {
        await GenerateBookingPdf.shareInvoice(
          context: context,
          bookingDetails: booking,
          shopDetails: shopData,
        );
      } else if (action == 'print') {
        await GenerateBookingPdf.printInvoice(
          context: context,
          bookingDetails: booking,
          shopDetails: shopData,
        );
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      CustomSnackBar(message: 'Failed to generate: $e');
    } finally {
      isProcessing.value = false;
    }
  },
);

              },
            ),
      ),
      // BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
      //   builder: (context, state) {
      //     final booking = state.maybeWhen(orElse: () => null, loaded: (b) => b);
      //     final isBookingCompleted =
      //         booking?.bookingStatus == BookingStatus.completed;
      //     return PopupMenuButton(
      //       borderRadius: 5.radiusBorder,
      //       color: Colors.white,
      //       tooltip: 'Actions',
      //       icon: const Icon(Icons.more_vert),
      //       itemBuilder: (context) {
      //         bool isEditVisible = true;
      //         if (booking != null &&
      //             booking.bookedItems.any(
      //               (element) => element.variantId == null,
      //             )) {
      //           debugPrint('variantId is null, returning from edit action');
      //           isEditVisible = false;
      //         }
      //         return [
      //           //edit
      //           if (isEditVisible && !isBookingCompleted)
      //             PopupMenuItem<int>(
      //               value: 0,
      //               onTap: () {
      //                 if (booking == null) {
      //                   debugPrint(
      //                     'booking is null, returning from edit action',
      //                   );
      //                   return;
      //                 }

      //                 // TODO: Implement secure action dialog
      //                 // performSecureActionDialog(
      //                 //   context,
      //                 //   SecretPasswordLocations.bookingEdit,
      //                 //   onSuccess: () {
      //                     StaffModel? existingStaff;
      //                     if (booking.staffId != null) {
      //                       existingStaff = StaffModel(
      //                         id: booking.staffId!,
      //                         name: booking.staffName ?? 'Staff Name',
      //                         phoneNumber: '',
      //                       );
      //                     }
      //                     context
      //                       ..read<StaffSearchCubit>().clearSelectedStaff()
      //                       ..read<StaffSearchCubit>().getAllStaffs(
      //                         booking.staffId,
      //                         existingStaff,
      //                       )
      //                       ..read<ClientCubit>().clearSelected()
      //                       ..push(
      //                         BlocProvider(
      //                           create: (context) => UpdateBookingCubit(
      //                             bookingRepository: getIt.get(),
      //                             clientRepository: getIt.get(),
      //                           ),
      //                           child: EditBookingScreen(booking: booking),
      //                         ),
      //                       );
      //                   // },
      //                 // );
      //               },
      //               child: const Row(
      //                 spacing: 5,
      //                 children: [
      //                   Icon(Icons.edit_outlined, color: AppColors.purple),
      //                   Text('Edit'),
      //                 ],
      //               ),
      //             ),

      //           // delete
      //           // PopupMenuItem<int>(
      //           //   value: 1,
      //           //   onTap: () {
      //           //     if (booking == null) {
      //           //       debugPrint(
      //           //         'booking is null, returning from delete action',
      //           //       );
      //           //       return;
      //           //     }

      //           //     performSecureActionDialog(
      //           //       context,
      //           //       SecretPasswordLocations.bookingDelete,
      //           //       onSuccess: () async {
      //           //         await showDeleteBookingDialog(context, booking.id);
      //           //       },
      //           //     );
      //           //   },
      //           //   child: const Row(
      //           //     spacing: 5,
      //           //     children: [
      //           //       Icon(Icons.delete_outline, color: AppColors.redTomato),
      //           //       Text('Delete'),
      //           //     ],
      //           //   ),
      //           // ),
      //         ];
      //       },
      //     );
      //   },
      // ),
    ],
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
