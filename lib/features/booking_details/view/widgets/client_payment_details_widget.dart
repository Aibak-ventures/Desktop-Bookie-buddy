// import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
// import 'package:bookie_buddy_web/core/models/booking_details_model.dart';
// import 'package:bookie_buddy_web/core/theme/app_colors.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_sized_box.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_text.dart';
// import 'package:bookie_buddy_web/features/booking_details/view/widgets/alert_dialog_with_text_field.dart';
// import 'package:flutter/material.dart';

// class ClientPaymentDetailsWidget extends StatelessWidget {
//   const ClientPaymentDetailsWidget({
//     required this.booking,
//     super.key,
//   });

//   final BookingDetailsModel booking;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const CustomText(
//           text: 'Client Payment Details',
//           size: 0.05,
//           color: Colors.black,
//           weight: FontWeight.w500,
//         ),
//         const CustomSizedBoxHeight(0.015),
//         booking.paymentStatus == false
//             ? Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 207, 191, 235),
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: context.mediaQueryHeight(0.05),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 const CustomText(
//                                   text: 'Total Amount',
//                                   size: 0.04,
//                                   color: AppColors.black,
//                                   weight: FontWeight.w600,
//                                 ),
//                                 CustomText(
//                                   text: '${booking.totalAmount}',
//                                   size: 0.04,
//                                   color: AppColors.green,
//                                   weight: FontWeight.w600,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: context.mediaQueryHeight(0.05),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 const CustomText(
//                                   text: 'Advance Amount',
//                                   size: 0.04,
//                                   color: AppColors.black,
//                                   weight: FontWeight.w600,
//                                 ),
//                                 CustomText(
//                                   text: '${booking.advanceAmount}',
//                                   size: 0.04,
//                                   color: AppColors.purple,
//                                   weight: FontWeight.w600,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         if (booking.totalAmount != booking.advanceAmount)
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: context.mediaQueryHeight(0.05),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   const CustomText(
//                                     text: 'Balance Amount',
//                                     size: 0.04,
//                                     color: AppColors.black,
//                                     weight: FontWeight.w600,
//                                   ),
//                                   CustomText(
//                                     text:
//                                         '${booking.totalAmount - booking.advanceAmount}',
//                                     size: 0.04,
//                                     color: Colors.red,
//                                     weight: FontWeight.w600,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         GestureDetector(
//                           onTap: () {
//                             final int balance =
//                                 booking.totalAmount - booking.advanceAmount;
//                             showCustomAlertDialog(
//                               context: context,
//                               id: booking.id,
//                               balanceAmount: balance,
//                             );
//                           },
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 height: context.mediaQueryHeight(0.05),
//                                 width: context.mediaQueryWidth(0.45),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.yellow,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Center(
//                                     child: CustomText(
//                                   text: 'Update Payment',
//                                   size: 0.04,
//                                   color: AppColors.white,
//                                   weight: FontWeight.w500,
//                                 )),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             : const Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 40),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.check_circle_rounded,
//                       color: AppColors.green,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     CustomText(
//                       text: 'Payment Completed',
//                       size: 0.045,
//                       color: AppColors.green,
//                       weight: FontWeight.w600,
//                     ),
//                   ],
//                 ),
//               ),
//       ],
//     );
//   }
// }
