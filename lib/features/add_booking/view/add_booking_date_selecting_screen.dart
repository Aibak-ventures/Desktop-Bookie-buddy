// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/ui/screens/select_service_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/cubit_add_booking_products/add_booking_products_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/widgets/calender_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_product_screen.dart';
import 'dart:developer';

class AddBookingDateSelectingScreen extends StatefulWidget {
  const AddBookingDateSelectingScreen({
    this.addBookingModel = const RequestBookingModel(),
    super.key,
  });

  final RequestBookingModel addBookingModel;

  @override
  State<AddBookingDateSelectingScreen> createState() =>
      _AddBookingDateSelectingScreenState();
}

class _AddBookingDateSelectingScreenState
    extends State<AddBookingDateSelectingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final returnDateController =
      TextEditingController(text: DateTime.now().add(1.days()).format());
  final pickupDateNotifier = ValueNotifier<DateTime>(DateTime.now());
  final coolingPeriodDateController = TextEditingController(); // Initially empty
  
  bool coolingPeriodManuallySelected = false; // Track if user manually selected cooling period

  late final int coolingPeriodDuration;
  TimeOfDay? pickupTime;
  TimeOfDay? returnTime;
  final pickupTimeController = TextEditingController();
  final returnTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    coolingPeriodDuration =
        context.read<UserCubit>().state?.shopSettings.coolingPeriodDuration ?? 0;
    // Don't auto-populate cooling period - let user select manually if needed
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 900;
    final isWeb = screenWidth > 768;

    return Scaffold(
      backgroundColor: isWeb ? const Color(0xFFF5F7FA) : null,
      appBar: AppBar(
        title: const Text('Create New Booking'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isWeb ? Colors.transparent : null,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isWeb ? 1200 : double.infinity,
              ),
              padding: isWeb
                  ? const EdgeInsets.all(40)
                  : const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: isWeb ? _buildWebLayout(isWideScreen) : _buildMobileLayout(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebLayout(bool isWideScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.purple.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Schedule Your Booking',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Select your preferred dates and times to get started with your booking',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Main content with calendar and form
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Calendar section
            Expanded(
              flex: isWideScreen ? 3 : 2,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Pickup Date',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: pickupDateNotifier,
                      builder: (context, selectedDate, child) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.event,
                              color: Colors.blue.shade600,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Selected: ${selectedDate.format()}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CalenderWidget(
                      onDateSelected: (selectedDate) {
                        pickupDateNotifier.value = selectedDate;
                        // Automatically set return date to pickup date + 1 day
                        final newReturnDate = selectedDate.add(1.days());
                        returnDateController.text = newReturnDate.format();
                        // Only update cooling period if user has manually selected it
                        if (coolingPeriodManuallySelected) {
                          coolingPeriodDateController.text =
                              newReturnDate.add(coolingPeriodDuration.days()).format();
                        }
                      },
                      initialSelectedDate: pickupDateNotifier.value,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: isWideScreen ? 32 : 16),

            // Right: Form fields
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // Return date card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Return Date',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select return date.';
                            }
                            final selectedDate = value.parseToDateTime();
                            final pickupDate = pickupDateNotifier.value;
                            // Only check if return date is before pickup date (allow same date)
                            if (selectedDate.isBefore(pickupDate.dateOnly)) {
                              return 'Return date cannot be before pickup date.';
                            }
                            return null;
                          },
                          hintText: 'Select Return Date',
                          controller: returnDateController,
                          prefixIcon: const Icon(Icons.calendar_month_outlined),
                          ignorePointers: true,
                        ).onTap(() => selectReturnDate(context)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Time selection card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.orange.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Time (Optional)',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup Time',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    validator: (value) => null, // No validation - time is optional
                                    controller: pickupTimeController,
                                    hintText: 'Pickup Time',
                                    prefixIcon: const Icon(Icons.access_time),
                                    ignorePointers: true,
                                  ).onTap(() async {
                                    final picked = await showTimePicker(
                                      context: context,
                                      initialTime: pickupTime ?? TimeOfDay.now(),
                                    );
                                    if (picked != null) {
                                      // Check if same day and same time as return
                                      final returnDateStr = returnDateController.text;
                                      final pickupDate = pickupDateNotifier.value;
                                      
                                      if (returnDateStr.isNotEmpty) {
                                        final returnDate = returnDateStr.parseToDateTime();
                                        
                                        if (pickupDate.isSameDay(returnDate) && 
                                            returnTime != null && picked == returnTime) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Pickup and return time cannot be the same on the same day'),
                                              backgroundColor: Colors.orange,
                                            ),
                                          );
                                          return;
                                        }
                                      }
                                      
                                      pickupTime = picked;
                                      pickupTimeController.text = picked.formatTime12Hour();
                                    }
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Return Time',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    validator: (value) => null, // No validation - time is optional
                                    controller: returnTimeController,
                                    hintText: 'Return Time',
                                    prefixIcon: const Icon(Icons.access_time),
                                    ignorePointers: true,
                                  ).onTap(() async {
                                    final picked = await showTimePicker(
                                      context: context,
                                      initialTime: returnTime ?? TimeOfDay.now(),
                                    );
                                    if (picked != null) {
                                      // Check if same day and same time as pickup
                                      final returnDateStr = returnDateController.text;
                                      final pickupDate = pickupDateNotifier.value;
                                      
                                      if (returnDateStr.isNotEmpty) {
                                        final returnDate = returnDateStr.parseToDateTime();
                                        
                                        if (pickupDate.isSameDay(returnDate) && 
                                            pickupTime != null && picked == pickupTime) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Return and pickup time cannot be the same on the same day'),
                                              backgroundColor: Colors.orange,
                                            ),
                                          );
                                          return;
                                        }
                                      }
                                      
                                      returnTime = picked;
                                      returnTimeController.text = picked.formatTime12Hour();
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Cooling period card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.ac_unit,
                              color: Colors.green.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Cooling Period (Optional)',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Additional time after return for maintenance or processing',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          validator: (value) => null, // No validation - cooling period is optional
                          controller: coolingPeriodDateController,
                          hintText: 'Select cooling period',
                          prefixIcon: const Icon(Icons.calendar_month_outlined),
                          ignorePointers: true,
                        ).onTap(() => selectCoolingPeriodDate(context)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Next button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => onNextPressed(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_forward, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Continue to Service Selection',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Calendar
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple.shade200),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        // CalenderWidget(
                        //   onDateSelected: (selectedDate) {
                        //     pickupDateNotifier.value = selectedDate;
                        //     // Automatically set return date to pickup date + 1 day
                        //     final newReturnDate = selectedDate.add(1.days());
                        //     returnDateController.text = newReturnDate.format();
                        //     // Update cooling period date based on new return date
                        //     coolingPeriodDateController.text =
                        //         newReturnDate.add(coolingPeriodDuration.days()).format();
                        //   },
                        //   initialSelectedDate: pickupDateNotifier.value,
                        // ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Right: Form fields
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Return Date", style: _labelStyle(context)),
                          8.verticalSpace,
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select return date.';
                              }
                              final selectedDate = value.parseToDateTime();
                              final pickupDate = pickupDateNotifier.value;
                              // Only check if return date is before pickup date (allow same date)
                              if (selectedDate.isBefore(pickupDate.dateOnly)) {
                                return 'Return date cannot be before pickup date.';
                              }
                              return null;
                            },
                            hintText: 'Select Return Date',
                            controller: returnDateController,
                            prefixIcon: const Icon(Icons.calendar_month_outlined),
                            ignorePointers: true,
                          ).onTap(() => selectReturnDate(context)),
                          16.verticalSpace,

                          Text('Time (Optional)', style: _labelStyle(context)),
                          8.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  validator: (value) => null, // No validation - time is optional
                                  controller: pickupTimeController,
                                  hintText: 'Pickup Time',
                                  prefixIcon: const Icon(Icons.access_time),
                                  ignorePointers: true,
                                ).onTap(() async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: pickupTime ?? TimeOfDay.now(),
                                    builder: (context, child) => MediaQuery(
                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                      child: child!,
                                    ),
                                  );
                                  if (picked != null) {
                                    // If pickup date is today, ensure pickup time is after current time
                                    final pickupDate = pickupDateNotifier.value;
                                    if (pickupDate.isSameDay(DateTime.now()) && picked.isBefore(TimeOfDay.now())) {
                                      context.showSnackBar(
                                        'Pickup time must be after current time',
                                        title: 'Time Error',
                                        isError: true,
                                      );
                                      return;
                                    }
                                    
                                    // If pickup and return are on same day and return time is set, ensure pickup is before return
                                    final returnDate = returnDateController.text.parseToDateTime();
                                    if (pickupDate.isSameDay(returnDate) && returnTime != null) {
                                      if (!picked.isBefore(returnTime!)) {
                                        context.showSnackBar(
                                          'Pickup time must be before return time on the same day',
                                          title: 'Time Error',
                                          isError: true,
                                        );
                                        return;
                                      }
                                    }
                                    
                                    pickupTime = picked;
                                    pickupTimeController.text = picked.formatTime12Hour();
                                  }
                                }),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: CustomTextField(
                                  validator: (value) => null, // No validation - time is optional
                                  controller: returnTimeController,
                                  hintText: 'Return Time',
                                  prefixIcon: const Icon(Icons.access_time),
                                  ignorePointers: true,
                                ).onTap(() async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: returnTime ?? TimeOfDay.now(),
                                    builder: (context, child) => MediaQuery(
                                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                      child: child!,
                                    ),
                                  );
                                  if (picked != null) {
                                    // Validate return time if on same day as pickup
                                    final pickupDate = pickupDateNotifier.value;
                                    final returnDate = returnDateController.text.parseToDateTime();
                                    
                                    // If return date is today, ensure return time is after current time
                                    if (returnDate.isSameDay(DateTime.now()) && picked.isBefore(TimeOfDay.now())) {
                                      context.showSnackBar(
                                        'Return time must be after current time',
                                        title: 'Time Error',
                                        isError: true,
                                      );
                                      return;
                                    }
                                    
                                    // If pickup and return are on same day, ensure return time is after pickup time
                                    if (pickupDate.isSameDay(returnDate) && pickupTime != null) {
                                      if (!picked.isAfter(pickupTime!)) {
                                        context.showSnackBar(
                                          'Return time must be after pickup time on the same day',
                                          title: 'Time Error',
                                          isError: true,
                                        );
                                        return;
                                      }
                                    }
                                    
                                    returnTime = picked;
                                    returnTimeController.text = picked.formatTime12Hour();
                                  }
                                }),
                              ),
                            ],
                          ),
                          24.verticalSpace,

                          Text("Cooling Period Date (Optional)", style: _labelStyle(context)),
                          8.verticalSpace,
                          CustomTextField(
                            validator: (value) => null, // No validation - cooling period is optional
                            controller: coolingPeriodDateController,
                            hintText: 'Select cooling period date (optional)',
                            prefixIcon: const Icon(Icons.calendar_month_outlined),
                            ignorePointers: true,
                          ).onTap(() => selectCoolingPeriodDate(context)),
                          32.verticalSpace,

                          Center(
                            child: CustomElevatedButton(
                              text: 'Next',
                              width: double.infinity,
                              onPressed: () => onNextPressed(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle _labelStyle(BuildContext context) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: Colors.black,
      );

  bool get isReturnAndPickupSameDay => pickupDateNotifier.value.dateOnly
      .isSameDay(returnDateController.text.parseToDateTime().dateOnly);

  Future<void> onNextPressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      context.showSnackBar(
        'Please select return date.',
        title: 'Date Error',
        isError: true,
      );
      return;
    }

    // Comprehensive booking validation
    final pickupDate = pickupDateNotifier.value;
    final returnDate = returnDateController.text.parseToDateTime();
    
    // Check if same day booking with invalid times
    if (pickupDate.isSameDay(returnDate)) {
      // For same day bookings, ensure both times are provided
      if (pickupTime == null || returnTime == null) {
        context.showSnackBar(
          'For same-day bookings, both pickup and return times are required.',
          title: 'Time Required',
          isError: true,
        );
        return;
      }
      
      // Convert TimeOfDay to minutes for comparison
      final pickupMinutes = pickupTime!.hour * 60 + pickupTime!.minute;
      final returnMinutes = returnTime!.hour * 60 + returnTime!.minute;
      
      // Return time must be at least 1 hour after pickup time for same day
      if (returnMinutes <= pickupMinutes) {
        context.showSnackBar(
          'Return time must be after pickup time on the same day.',
          title: 'Invalid Time',
          isError: true,
        );
        return;
      }
      
      // Minimum rental duration check (at least 1 hour for same day)
      if (returnMinutes - pickupMinutes < 60) {
        context.showSnackBar(
          'Minimum rental duration is 1 hour for same-day bookings.',
          title: 'Duration Too Short',
          isError: true,
        );
        return;
      }
    }
    
    // For different day bookings, if times are provided, validate them
    if (!pickupDate.isSameDay(returnDate)) {
      // If it's next day and times are provided, check if return is actually later
      if (pickupTime != null && returnTime != null) {
        final pickupDateTime = DateTime(
          pickupDate.year, 
          pickupDate.month, 
          pickupDate.day,
          pickupTime!.hour, 
          pickupTime!.minute
        );
        final returnDateTime = DateTime(
          returnDate.year, 
          returnDate.month, 
          returnDate.day,
          returnTime!.hour, 
          returnTime!.minute
        );
        
        if (returnDateTime.isBefore(pickupDateTime)) {
          context.showSnackBar(
            'Return date and time cannot be before pickup date and time.',
            title: 'Invalid Schedule',
            isError: true,
          );
          return;
        }
      }
    }
    
    // Additional business logic validation
    final now = DateTime.now();
    if (pickupTime != null) {
      final pickupDateTime = DateTime(
        pickupDate.year,
        pickupDate.month,
        pickupDate.day,
        pickupTime!.hour,
        pickupTime!.minute,
      );
      
      // Cannot book in the past
      if (pickupDateTime.isBefore(now)) {
        context.showSnackBar(
          'Cannot book pickup time in the past.',
          title: 'Invalid Time',
          isError: true,
        );
        return;
      }
    }

    final pickupDateFormatted = pickupDateNotifier.value.format(reverse: true);
    final returnDateFormatted = returnDateController.text.formatToUiDate();
    // Only send cooling period if user has manually selected it and it's different from return date
    final coolingPeriodDate = coolingPeriodManuallySelected && coolingPeriodDateController.text.isNotEmpty
        ? coolingPeriodDateController.text.formatToUiDate()
        : null;
    final isEdit = widget.addBookingModel.staffId != null;

    if (context.mounted) {
      try {
        final bookingData = widget.addBookingModel.copyWith(
          pickupDate: pickupDateFormatted,
          returnDate: returnDateFormatted,
          pickupTime: pickupTime,
          returnTime: returnTime,
          coolingPeriodDate: coolingPeriodDate, // Will be null if not manually selected
        );
        
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SelectServiceScreen(
              onServiceSelected: (service, ctx) async {
                // debugPrint('Selected service: ${service.name}');

                final updatedBookingData = bookingData.copyWith(
                  serviceId: service.id,
                );

                // Navigate to select products screen
                final selectedProducts = await Navigator.of(ctx).push<List<ProductSelectedModel>>(
                  MaterialPageRoute(
                    builder: (context) => SelectProductScreen(
                      serviceId: service.id,
                      pickupDate: pickupDateFormatted,
                      returnDate: returnDateFormatted,
                      pickupTime: pickupTime,
                      returnTime: returnTime,
                      preSelectedData: null,
                    ),
                  ),
                );

                log(
                  'Returned from product selection with data: $selectedProducts, type: ${selectedProducts.runtimeType}',
                );

                if (selectedProducts != null && selectedProducts.isNotEmpty) {
                  if (isEdit) {
                    // If editing a booking, pop twice to go back to edit screen with new data
                    Navigator.of(ctx).pop(selectedProducts);
                    return;
                  }
                  // If adding new booking, go to product review screen
                  await Navigator.of(ctx).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AddBookingProductsCubit()..setAll(selectedProducts),
                        child: AddBookingProductScreen(addBookingModel: updatedBookingData),
                      ),
                    ),
                  );
                } else {
                  log('No products selected, returning to date selection');
                  return;
                }
              },
            ),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Navigation error. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> selectCoolingPeriodDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: coolingPeriodDateController.text.isNotEmpty 
          ? coolingPeriodDateController.text.parseToDateTime()
          : returnDateController.text.parseToDateTime().add(coolingPeriodDuration.days()),
      firstDate: returnDateController.text.parseToDateTime(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
 
    if (picked != null) {
      coolingPeriodDateController.text = picked.format();
      coolingPeriodManuallySelected = true; // Mark as manually selected
    }
  }

  Future<void> selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: returnDateController.text.parseToDateTime(),
      firstDate: pickupDateNotifier.value,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      returnDateController.text = picked.format();
      
      // Auto-populate cooling period date when return date changes
      // Add cooling period duration to return date
      final coolingPeriodDate = picked.add(coolingPeriodDuration.days());
      coolingPeriodDateController.text = coolingPeriodDate.format();
      
      // Show snackbar to inform user about auto-populated cooling period
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cooling period date automatically set to ${coolingPeriodDate.format()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green.shade600,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    returnDateController.dispose();
    pickupTimeController.dispose();
    returnTimeController.dispose();
    coolingPeriodDateController.dispose();
    pickupDateNotifier.dispose();
    super.dispose();
  }
}

extension StringTimeExtensions on String {
  /// Parses a 12-hour time string like '10:30 AM' or '4:15 PM' to TimeOfDay.
  TimeOfDay? parseToTimeOfDay() {
    try {
      final format = RegExp(r'(\d+):(\d+)\s*(AM|PM)', caseSensitive: false);
      final match = format.firstMatch(this);
      if (match == null) return null;

      int hour = int.parse(match.group(1)!);
      final int minute = int.parse(match.group(2)!);
      final String ampm = match.group(3)!.toUpperCase();

      if (ampm == 'PM' && hour != 12) hour += 12;
      if (ampm == 'AM' && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
  }
}