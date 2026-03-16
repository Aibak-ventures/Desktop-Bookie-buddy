// import 'dart:developer';

// import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
// import 'package:bookie_buddy_web/core/theme/app_colors.dart';
// import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
// import 'package:bookie_buddy_web/features/product/view/widgets/booked_dates_tile.dart';
// import 'package:bookie_buddy_web/features/product/view_model/bloc/product_bookings_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductBookedDatesDialog extends StatelessWidget {
//   const ProductBookedDatesDialog({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       title: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: AppColors.green.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           "Booked Dates",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: AppColors.green,
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       content: BlocBuilder<ProductBookingsBloc, ProductBookingsState>(
//         builder: (context, state) {
//           return state.when(
//             loading: () => _listBuilder(
//               context: context,
//               children: List.generate(
//                 3,
//                 (index) => BookedDatesTile(
//                   onTap: () {},
//                   text: 'Loading...',
//                 ),
//               ),
//             ),
//             error: _emptyBuilder,
//             loaded: (bookedDates) {
//               return bookedDates.isEmpty
//                   ? _emptyBuilder('No booked dates available')
//                   : _listBuilder(
//                       context: context,
//                       children: bookedDates.map(
//                         (event) {
//                           log('event: $event');
//                           try {
//                             final date = event['event_date'];
//                             final bookingId = event['id'];
//                             final parsedDate = DateTime.parse(date);
//                             final formattedDate = parsedDate.format();
//                             return BookedDatesTile(
//                               onTap: () {
//                                 context.push(
//                                   BookingDetailsScreen(
//                                     bookingId: bookingId,
//                                   ),
//                                 );
//                               },
//                               text: formattedDate,
//                             );
//                           } catch (e) {
//                             print('Error formatting date: $e');
//                             return const SizedBox();
//                           }
//                         },
//                       ).toList(),
//                     );
//             },
//           );
//         },
//       ),
//       actions: [
//         SizedBox(
//           width: double.infinity,
//           child: TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: AppColors.green.withValues(alpha: 0.1),
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text(
//               "Close",
//               style: TextStyle(
//                 color: AppColors.green,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//       contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
//       actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
//     );
//   }

//   Container _listBuilder(
//       {required BuildContext context, required List<Widget> children}) {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.4,
//       ),
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: children,
//         ),
//       ),
//     );
//   }

//   SizedBox _emptyBuilder(String text) {
//     return SizedBox(
//       height: 100,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.calendar_today,
//               size: 40,
//               color: Colors.grey,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               text,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: Colors.grey[600],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
