// import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
// import 'package:bookie_buddy_web/core/models/booking_details_model.dart';
// import 'package:bookie_buddy_web/core/theme/app_borders.dart';
// import 'package:bookie_buddy_web/core/theme/app_colors.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_sized_box.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_text.dart';
// import 'package:flutter/material.dart';

// class ClientAndProductDetailsWidget extends StatelessWidget {
//   const ClientAndProductDetailsWidget({
//     required this.booking,
//     super.key,
//   });

//   final BookingDetailsModel booking;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const CustomText(
//           text: 'Client Details & Products',
//           size: 0.05,
//           color: Colors.black,
//           weight: FontWeight.w500,
//         ),
//         const CustomSizedBoxHeight(0.015),
//         // Requirements
//         Center(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.lightVioletColor, width: 2),
//               borderRadius: BorderRadius.circular(AppBorders.radius9),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const CustomText(
//                   text: 'Client Details',
//                   size: 0.045,
//                   color: AppColors.green,
//                   weight: FontWeight.w600,
//                 ),
//                 const CustomSizedBoxHeight(0.015),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: 'Name : ${booking.client.clientName} ',
//                       size: 0.04,
//                       color: Colors.black,
//                       weight: FontWeight.w500,
//                     ),
//                     CustomText(
//                       text: 'Phone 1 : ${booking.client.clientPhone1} ',
//                       size: 0.04,
//                       color: Colors.black,
//                       weight: FontWeight.w500,
//                     ),
//                     booking.client.clientPhone2 == null
//                         ? const SizedBox()
//                         : CustomText(
//                             text: 'Phone 2 : ${booking.client.clientPhone2} ',
//                             size: 0.04,
//                             color: Colors.black,
//                             weight: FontWeight.w500,
//                           ),
//                     CustomText(
//                       text: 'Address : ${booking.client.clientAddress} ',
//                       size: 0.04,
//                       color: Colors.black,
//                       weight: FontWeight.w500,
//                     ),
//                   ],
//                 ),
//                 const CustomSizedBoxHeight(0.025),
//                 booking.productDetails?.isEmpty ?? true
//                     ? const SizedBox()
//                     : const CustomText(
//                         text: 'Products',
//                         size: 0.045,
//                         color: AppColors.green,
//                         weight: FontWeight.w600,
//                       ),
//                 booking.productDetails?.isEmpty ?? true
//                     ? const SizedBox()
//                     : const CustomSizedBoxHeight(0.015),
//                 Row(
//                   children: [
//                     // Display images and names for each sub-service
//                     Expanded(
//                       child: Wrap(
//                         spacing: 8.0, // Add spacing between items
//                         children: booking.productDetails == null
//                             ? []
//                             : booking.productDetails!
//                                 .asMap()
//                                 .entries
//                                 .map((entry) {
//                                 final subService = entry.value;
//                                 final isLast = entry.key ==
//                                     booking.productDetails!.length - 1;
//                                 return Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(bottom: 5),
//                                       child:
//                                           buildImage(subService.image, context),
//                                     ), // Use the image from SubServiceInfo
//                                     const SizedBox(
//                                         width:
//                                             4), // Add spacing between image and name
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: context.mediaQueryHeight(0.18),
//                                           child: CustomText(
//                                             text: subService
//                                                 .name, // Use the name from SubServiceInfo
//                                             size: 0.04,
//                                             color: Colors.black,
//                                             weight: FontWeight.w500,
//                                             //  textOverflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                         CustomText(
//                                           text:
//                                               'Rs.${subService.amount.toString()}', // Use the name from SubServiceInfo
//                                           size: 0.04,
//                                           color: Colors.black,
//                                           weight: FontWeight.w500,
//                                         ),
//                                       ],
//                                     ),
//                                     if (!isLast) // Add a comma unless it's the last item
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.symmetric(horizontal: 4),
//                                         child: CustomText(
//                                           text: ',',
//                                           size: 0.04,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                   ],
//                                 );
//                               }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//                 booking.productDetails?.isEmpty ?? true
//                     ? const SizedBox()
//                     : const CustomSizedBoxHeight(0.025),
//                 booking.description?.isEmpty ?? true
//                     ? const SizedBox()
//                     : const CustomText(
//                         text: 'Description',
//                         size: 0.045,
//                         color: AppColors.green,
//                         weight: FontWeight.w600,
//                       ),
//                 booking.description?.isEmpty ?? true
//                     ? const SizedBox()
//                     : const CustomSizedBoxHeight(0.015),
//                 CustomText(
//                   text: booking.description ?? " ",
//                   size: 0.04,
//                   color: Colors.black,
//                   weight: FontWeight.w500,
//                 ),
//                 const CustomSizedBoxHeight(0.025),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildImage(String? image, BuildContext context) {
//     if (image == null || image.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return CustomNetworkImage(
//       imageUrl: image,
//       imageBuilder: (context, imageProvider) {
//         return CircleAvatar(
//           radius: 30,
//           backgroundImage: imageProvider,
//           onBackgroundImageError: (_, __) => const Icon(Icons.error),
//           backgroundColor: Colors.grey[200], // Optional fallback background
//         );
//       },
//       placeholder: (context, url) => CircleAvatar(
//         radius: 30,
//         backgroundColor: Colors.grey[200], // Optional fallback background
//       ),
//     );
//   }
// }
