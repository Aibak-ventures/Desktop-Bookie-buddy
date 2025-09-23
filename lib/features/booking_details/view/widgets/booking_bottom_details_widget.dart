// import 'package:bookie_buddy_web/core/enums.dart';
// import 'package:bookie_buddy_web/core/models/booking_details_model.dart';
// import 'package:bookie_buddy_web/core/theme/app_colors.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_sized_box.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_text.dart';
// import 'package:bookie_buddy_web/features/wallet/view/widgets/perform_secure_action_dialog.dart';
// import 'package:flutter/material.dart';

// class BookingBottomDetailsWidget extends StatelessWidget {
//   const BookingBottomDetailsWidget({
//     required this.booking,
//     super.key,
//   });

//   final BookingDetailsModel booking;

//   @override
//   Widget build(BuildContext context) {
//     final isBookingCompleted = booking.bookingStatus == BookingStatus.completed;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const CustomText(
//               text: 'Staff Name',
//               size: 0.04,
//               color: AppColors.green,
//               weight: FontWeight.w600,
//             ),
//             const SizedBox(
//               width: 25,
//             ),
//             const CustomText(
//               text: ':',
//               size: 0.04,
//               color: AppColors.black,
//               weight: FontWeight.w600,
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             CustomText(
//               text: booking.staffName ?? '',
//               size: 0.04,
//               color: AppColors.black,
//               weight: FontWeight.w600,
//             ),
//           ],
//         ),
//         booking.purchaseMode != null
//             ? Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const CustomText(
//                     text: 'Purchase Mode',
//                     size: 0.04,
//                     color: AppColors.green,
//                     weight: FontWeight.w600,
//                   ),
//                   const SizedBox(
//                     width: 25,
//                   ),
//                   const CustomText(
//                     text: ':',
//                     size: 0.04,
//                     color: AppColors.black,
//                     weight: FontWeight.w600,
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   CustomText(
//                     text: booking.purchaseMode?.label ?? '',
//                     size: 0.04,
//                     color: AppColors.black,
//                     weight: FontWeight.w600,
//                   ),
//                 ],
//               )
//             : const SizedBox(),

//         isBookingCompleted
//             ? const Padding(
//                 padding: EdgeInsets.only(top: 40),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.check_circle_rounded,
//                       color: AppColors.green,
//                     ),
//                     SizedBox(width: 10),
//                     CustomText(
//                       text: 'Work Completed',
//                       size: 0.045,
//                       color: AppColors.green,
//                       weight: FontWeight.w600,
//                     ),
//                   ],
//                 ),
//               )
//             : const SizedBox.shrink(),

//         // Return an empty widget if conditions aren't met

//         const CustomSizedBoxHeight(0.04),
//         if (!isBookingCompleted) // Show edit and update button if work not completed
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   performSecureActionDialog(context, 'edit', booking: booking);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.green,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                 ),
//                 child: const Text(
//                   'Edit Booking',
//                   style: TextStyle(color: AppColors.white),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   performSecureActionDialog(
//                     context,
//                     'delete',
//                     bookingId: booking.id,
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                 ),
//                 child: const Text(
//                   'Delete Booking',
//                   style: TextStyle(color: AppColors.white),
//                 ),
//               ),
//             ],
//           ),
//         if (!isBookingCompleted) const CustomSizedBoxHeight(0.1),
//       ],
//     );
//   }
// }
