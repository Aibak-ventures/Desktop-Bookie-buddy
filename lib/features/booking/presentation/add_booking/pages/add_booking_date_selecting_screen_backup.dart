// // ignore_for_file: library_private_types_in_public_api
// import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
// import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
// import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
// import 'package:bookie_buddy_web/features/add_booking/view/widgets/calender_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class AddBookingDateSelectingScreen extends StatefulWidget {
//   const AddBookingDateSelectingScreen({
//     this.addBookingModel = const RequestBookingModel(),
//     super.key,
//   });

//   final RequestBookingModel addBookingModel;

//   @override
//   State<AddBookingDateSelectingScreen> createState() =>
//       _AddBookingDateSelectingScreenState();
// }

// class _AddBookingDateSelectingScreenState
//     extends State<AddBookingDateSelectingScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final returnDateController =
//       TextEditingController(text: DateTime.now().add(1.days()).format());
//   final pickupDateNotifier = ValueNotifier<DateTime>(DateTime.now());
//   final coolingPeriodDateController = TextEditingController();

//   late final int coolingPeriodDuration;
//   TimeOfDay? pickupTime;
//   TimeOfDay? returnTime;
//   final pickupTimeController = TextEditingController();
//   final returnTimeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     coolingPeriodDuration =
//         context.read<UserCubit>().state?.shopSettings.coolingPeriodDuration ?? 0;
//     coolingPeriodDateController.text = returnDateController.text
//         .parseToDateTime()
//         .add(coolingPeriodDuration.days())
//         .format();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isWideScreen = screenWidth > 900;
//     final isWeb = screenWidth > 768;

//     return Scaffold(
//       backgroundColor: isWeb ? const Color(0xFFF5F7FA) : null,
//       appBar: AppBar(
//         title: const Text('Create New Booking'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: isWeb ? Colors.transparent : null,
//       ),
//       body: Container(
//         width: double.infinity,
//         child: SingleChildScrollView(
//           child: Center(
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: isWeb ? 1200 : double.infinity,
//               ),
//               padding: isWeb
//                   ? const EdgeInsets.all(40)
//                   : const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: isWeb ? _buildWebLayout(isWideScreen) : _buildMobileLayout(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildWebLayout(bool isWideScreen) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header section
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(32),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade50, Colors.purple.shade50],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade600,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.calendar_today,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Schedule Your Booking',
//                           style: TextStyle(
//                             fontSize: 32.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue.shade800,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Select your preferred dates and times to get started with your booking',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.grey.shade700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 40),

//         // Main content with calendar and form
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left: Calendar section
//             Expanded(
//               flex: isWideScreen ? 3 : 2,
//               child: Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade200,
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Select Pickup Date',
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ValueListenableBuilder(
//                       valueListenable: pickupDateNotifier,
//                       builder: (context, selectedDate, child) => Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.event,
//                               color: Colors.blue.shade600,
//                             ),
//                             const SizedBox(width: 12),
//                             Text(
//                               'Selected: ${selectedDate.format()}',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.blue.shade800,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     CalenderWidget(
//                       onDateSelected: (selectedDate) {
//                         pickupDateNotifier.value = selectedDate;
//                       },
//                       initialSelectedDate: pickupDateNotifier.value,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(width: isWideScreen ? 32 : 16),

//             // Right: Form fields
//             Expanded(
//               flex: 2,
//               child: Column(
//                 children: [
//                   // Return date card
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Return Date',
//                           style: TextStyle(
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         CustomTextField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select return date.';
//                             }
//                             final selectedDate = value.parseToDateTime();
//                             if (selectedDate.isBefore(pickupDateNotifier.value)) {
//                               return 'Return date cannot be before pickup date.';
//                             }
//                             return null;
//                           },
//                           hintText: 'Select Return Date',
//                           controller: returnDateController,
//                           prefixIcon: const Icon(Icons.calendar_month_outlined),
//                           ignorePointers: true,
//                         ).onTap(() => selectReturnDate(context)),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // Time selection card
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.access_time,
//                               color: Colors.orange.shade600,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Time (Optional)',
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Pickup Time',
//                                     style: TextStyle(
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey.shade700,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   CustomTextField(
//                                     validator: (value) {
//                                       if (isReturnAndPickupSameDay) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please select pickup time.';
//                                         }
//                                         final selectedTime = value.parseToTimeOfDay();
//                                         final returnTimeOfDay = returnTime ?? TimeOfDay.now().clearedTime;
//                                         if (selectedTime != null && selectedTime.isAfter(returnTimeOfDay)) {
//                                           return 'Pickup time cannot be after return time on the same day.';
//                                         }
//                                       }
//                                       return null;
//                                     },
//                                     controller: pickupTimeController,
//                                     hintText: 'Pickup Time',
//                                     prefixIcon: const Icon(Icons.access_time),
//                                     ignorePointers: true,
//                                   ).onTap(() async {
//                                     final picked = await showTimePicker(
//                                       context: context,
//                                       initialTime: pickupTime ?? TimeOfDay.now().clearedTime,
//                                     );
//                                     if (picked != null) {
//                                       pickupTime = picked;
//                                       pickupTimeController.text = picked.formatTime12Hour();
//                                     }
//                                   }),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Return Time',
//                                     style: TextStyle(
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey.shade700,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   CustomTextField(
//                                     validator: (value) {
//                                       if (isReturnAndPickupSameDay) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please select return time.';
//                                         }
//                                         final selectedTime = value.parseToTimeOfDay();
//                                         final pickupTimeOfDay = pickupTime ?? TimeOfDay.now().clearedTime;
//                                         if (selectedTime != null && selectedTime.isBefore(pickupTimeOfDay)) {
//                                           return 'Return time cannot be before pickup time on the same day.';
//                                         }
//                                       }
//                                       return null;
//                                     },
//                                     controller: returnTimeController,
//                                     hintText: 'Return Time',
//                                     prefixIcon: const Icon(Icons.access_time),
//                                     ignorePointers: true,
//                                   ).onTap(() async {
//                                     final picked = await showTimePicker(
//                                       context: context,
//                                       initialTime: returnTime ?? TimeOfDay.now().clearedTime,
//                                     );
//                                     if (picked != null) {
//                                       returnTime = picked;
//                                       returnTimeController.text = picked.formatTime12Hour();
//                                     }
//                                   }),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // Cooling period card
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade200,
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.ac_unit,
//                               color: Colors.green.shade600,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Cooling Period (Optional)',
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           'Additional time after return for maintenance or processing',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         CustomTextField(
//                           validator: (isReturnAndPickupSameDay
//                               ? (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please select cooling period date.';
//                                   }
//                                   final selectedDate = value.parseToDateTime();
//                                   final minDate = returnDateController.text.parseToDateTime();
//                                   if (selectedDate.isBefore(minDate)) {
//                                     return 'Cooling period date cannot be before return date.';
//                                   }
//                                   return null;
//                                 }
//                               : null),
//                           controller: coolingPeriodDateController,
//                           hintText: 'Select cooling period',
//                           prefixIcon: const Icon(Icons.calendar_month_outlined),
//                           ignorePointers: true,
//                         ).onTap(() => selectCoolingPeriodDate(context)),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   // Next button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: onNextPressed,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue.shade600,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.arrow_forward, color: Colors.white),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Continue to Service Selection',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildMobileLayout() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 900),
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Left: Calendar
//                   Expanded(
//                     flex: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: DecoratedBox(
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.purple.shade200),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: CalenderWidget(
//                           onDateSelected: (selectedDate) {
//                             pickupDateNotifier.value = selectedDate;
//                           },
//                           initialSelectedDate: pickupDateNotifier.value,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 16),

//                   // Right: Form fields
//                   Expanded(
//                     flex: 2,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Return Date", style: _labelStyle(context)),
//                           8.verticalSpace,
//                           CustomTextField(
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please select return date.';
//                               }
//                               final selectedDate = value.parseToDateTime();
//                               if (selectedDate.isBefore(pickupDateNotifier.value)) {
//                                 return 'Return date cannot be before pickup date.';
//                               }
//                               return null;
//                             },
//                             hintText: 'Select Return Date',
//                             controller: returnDateController,
//                             prefixIcon: const Icon(Icons.calendar_month_outlined),
//                             ignorePointers: true,
//                           ).onTap(() => selectReturnDate(context)),
//                           16.verticalSpace,

//                           Text('Time (Optional)', style: _labelStyle(context)),
//                           8.verticalSpace,
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: CustomTextField(
//                                   validator: (value) {
//                                     if (isReturnAndPickupSameDay) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please select pickup time.';
//                                       }
//                                       final selectedTime = value.parseToTimeOfDay();
//                                       final returnTimeOfDay = returnTime ?? TimeOfDay.now().clearedTime;
//                                       if (selectedTime != null && selectedTime.isAfter(returnTimeOfDay)) {
//                                         return 'Pickup time cannot be after return time on the same day.';
//                                       }
//                                     }
//                                     return null;
//                                   },
//                                   controller: pickupTimeController,
//                                   hintText: 'Pickup Time',
//                                   prefixIcon: const Icon(Icons.access_time),
//                                   ignorePointers: true,
//                                 ).onTap(() async {
//                                   final picked = await showTimePicker(
//                                     context: context,
//                                     initialTime: pickupTime ?? TimeOfDay.now().clearedTime,
//                                   );
//                                   if (picked != null) {
//                                     pickupTime = picked;
//                                     pickupTimeController.text = picked.formatTime12Hour();
//                                   }
//                                 }),
//                               ),
//                               12.horizontalSpace,
//                               Expanded(
//                                 child: CustomTextField(
//                                   validator: (value) {
//                                     if (isReturnAndPickupSameDay) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please select return time.';
//                                       }
//                                       final selectedTime = value.parseToTimeOfDay();
//                                       final pickupTimeOfDay = pickupTime ?? TimeOfDay.now().clearedTime;
//                                       if (selectedTime != null && selectedTime.isBefore(pickupTimeOfDay)) {
//                                         return 'Return time cannot be before pickup time on the same day.';
//                                       }
//                                     }
//                                     return null;
//                                   },
//                                   controller: returnTimeController,
//                                   hintText: 'Return Time',
//                                   prefixIcon: const Icon(Icons.access_time),
//                                   ignorePointers: true,
//                                 ).onTap(() async {
//                                   final picked = await showTimePicker(
//                                     context: context,
//                                     initialTime: returnTime ?? TimeOfDay.now().clearedTime,
//                                   );
//                                   if (picked != null) {
//                                     returnTime = picked;
//                                     returnTimeController.text = picked.formatTime12Hour();
//                                   }
//                                 }),
//                               ),
//                             ],
//                           ),
//                           24.verticalSpace,

//                           Text("Cooling Period Date (Optional)", style: _labelStyle(context)),
//                           8.verticalSpace,
//                           CustomTextField(
//                             validator: (isReturnAndPickupSameDay
//                                 ? (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please select cooling period date.';
//                                     }
//                                     final selectedDate = value.parseToDateTime();
//                                     final minDate = returnDateController.text.parseToDateTime();
//                                     if (selectedDate.isBefore(minDate)) {
//                                       return 'Cooling period date cannot be before return date.';
//                                     }
//                                     return null;
//                                   }
//                                 : null),
//                             controller: coolingPeriodDateController,
//                             hintText: 'Select cooling period',
//                             prefixIcon: const Icon(Icons.calendar_month_outlined),
//                             ignorePointers: true,
//                           ).onTap(() => selectCoolingPeriodDate(context)),
//                           32.verticalSpace,

//                           Center(
//                             child: CustomElevatedButton(
//                               text: 'Next',
//                               width: double.infinity,
//                               onPressed: onNextPressed,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//   }

//   TextStyle _labelStyle(BuildContext context) => TextStyle(
//         fontWeight: FontWeight.w600,
//         fontSize: 16.sp,
//         color: Colors.black,
//       );

//   bool get isReturnAndPickupSameDay => pickupDateNotifier.value.dateOnly
//       .isSameDay(returnDateController.text.parseToDateTime().dateOnly);

//   Future<void> onNextPressed() async {
//     if (!(_formKey.currentState?.validate() ?? false)) {
//       context.showSnackBar(
//         'Please select return date.',
//         title: 'Date Error',
//         isError: true,
//       );
//       return;
//     }

//     final pickupDate = pickupDateNotifier.value.format(reverse: true);
//     final returnDate = returnDateController.text.formatToUiDate();
//     final coolingPeriodDate = coolingPeriodDateController.text.formatToUiDate();

//     final navigatorContext = context;

//     if (navigatorContext.mounted) {
//       try {
//         await navigatorContext.pushNamed(
//           AppRoutes.addBookingSelectService.name,
//           queryParameters: {
//             'pickup_date': pickupDate,
//             'return_date': returnDate,
//           },
//           extra: {
//             'pickup_time': pickupTime,
//             'return_time': returnTime,
//             'add_booking_model': widget.addBookingModel.copyWith(
//               pickupDate: pickupDate,
//               returnDate: returnDate,
//               pickupTime: pickupTime,
//               returnTime: returnTime,
//               coolingPeriodDate:
//                   coolingPeriodDate == returnDate ? null : coolingPeriodDate,
//             ),
//           },
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(navigatorContext).showSnackBar(
//           const SnackBar(
//             content: Text('Navigation error. Please try again.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> selectCoolingPeriodDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: coolingPeriodDateController.text.parseToDateTime(),
//       firstDate: returnDateController.text.parseToDateTime(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );

//     if (picked != null) {
//       coolingPeriodDateController.text = picked.format();
//     }
//   }

//   Future<void> selectReturnDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: returnDateController.text.parseToDateTime(),
//       firstDate: pickupDateNotifier.value,
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );

//     if (picked != null) {
//       returnDateController.text = picked.format();
//       coolingPeriodDateController.text =
//           picked.add(coolingPeriodDuration.days()).format();
//     }
//   }

//   @override
//   void dispose() {
//     returnDateController.dispose();
//     pickupTimeController.dispose();
//     returnTimeController.dispose();
//     coolingPeriodDateController.dispose();
//     pickupDateNotifier.dispose();
//     super.dispose();
//   }
// }

// extension StringTimeExtensions on String {
//   /// Parses a 12-hour time string like '10:30 AM' or '4:15 PM' to TimeOfDay.
//   TimeOfDay? parseToTimeOfDay() {
//     try {
//       final format = RegExp(r'(\d+):(\d+)\s*(AM|PM)', caseSensitive: false);
//       final match = format.firstMatch(this);
//       if (match == null) return null;

//       int hour = int.parse(match.group(1)!);
//       final int minute = int.parse(match.group(2)!);
//       final String ampm = match.group(3)!.toUpperCase();

//       if (ampm == 'PM' && hour != 12) hour += 12;
//       if (ampm == 'AM' && hour == 12) hour = 0;

//       return TimeOfDay(hour: hour, minute: minute);
//     } catch (_) {
//       return null;
//     }
//   }
// }
