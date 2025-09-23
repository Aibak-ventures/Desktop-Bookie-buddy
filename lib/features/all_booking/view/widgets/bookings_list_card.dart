// import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
// import 'package:bookie_buddy_web/core/models/booking_model.dart';
// import 'package:bookie_buddy_web/core/theme/app_colors.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class BookingsListCard extends StatelessWidget {
//   const BookingsListCard({
//     required this.booking,
//     required this.firstDate,
//     required this.onTap,
//     super.key,
//   });

//   final BookingsModel booking;
//   final String firstDate;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final isAfterReturnDate = booking.returnDate == null
//         ? false
//         : DateTime.now()
//             .isAfter(booking.returnDate!.parseToDateTime().add(1.days()));
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//           border: Border.all(
//               color:
//                   isAfterReturnDate ? Colors.red : AppColors.lightVioletColor,
//               width: 2),
//         ),
//         child: GestureDetector(
//           onTap: onTap,
//           child: ListTile(
//             leading: Container(
//               decoration: BoxDecoration(
//                 color:
//                     isAfterReturnDate ? Colors.red : AppColors.lightVioletColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               height: context.mediaQueryHeight(0.18),
//               width: context.mediaQueryWidth(0.3),
//               child: Center(
//                 child: CustomText(
//                   text: firstDate,
//                   size: 0.04,
//                   color: AppColors.white,
//                   weight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             title: CustomText(
//               text: booking.clientName ?? "",
//               size: 0.04,
//               color: AppColors.black,
//               weight: FontWeight.w600,
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomText(
//                     text: 'Type : ${booking.serviceName}',
//                     size: 0.04,
//                     color: AppColors.black),
//               ],
//             ),
//             trailing: isAfterReturnDate
//                 ? const Tooltip(
//                     message: 'Product is not returned yet',
//                     child: ImageIcon(
//                       AssetImage('assets/icons/invalid-date-icon.png'),
//                       size: 32,
//                       color: Colors.red,
//                     ),
//                   )
//                 : Icon(
//                     Icons.schedule_outlined,
//                     color: Colors.blue[800],
//                   ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BookingsListCardShimmer extends StatelessWidget {
//   const BookingsListCardShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//           border: Border.all(color: Colors.grey.shade400, width: 2),
//         ),
//         child: ListTile(
//           leading: Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.lightVioletColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               height: context.mediaQueryHeight(0.18),
//               width: context.mediaQueryWidth(0.3),
//             ),
//           ),
//           title: Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: Container(
//               height: 20,
//               width: 100,
//               color: Colors.white,
//             ),
//           ),
//           subtitle: Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 6),
//                 Container(
//                   height: 16,
//                   width: 140,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//           trailing: Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: const Icon(
//               Icons.schedule_outlined,
//               color: Colors.white, // Can be shimmered too
//             ),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
//         ),
//       ),
//     );
//   }
// }
