import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/ui/screens/select_service_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_product_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view/widgets/calender_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddBookingDateSelectingScreen extends StatefulWidget {
  const AddBookingDateSelectingScreen({
    required this.addBookingModel,
    super.key,
  });

  final AddBookingModel addBookingModel;

  @override
  State<AddBookingDateSelectingScreen> createState() =>
      _AddBookingDateSelectingScreenState();
}

class _AddBookingDateSelectingScreenState
    extends State<AddBookingDateSelectingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final returnDateController = TextEditingController(
    text: DateTime.now().add(1.days()).format(), // One day after today
  );

  final pickupDateNotifier = ValueNotifier<DateTime>(DateTime.now());

  TimeOfDay? pickupTime;
  TimeOfDay? returnTime;

  final pickupTimeController = TextEditingController();
  final returnTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || 
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;

    return Scaffold(
      backgroundColor: isDesktop ? const Color(0xFFF5F7FA) : null,
      appBar: AppBar(
        title: const Text('Select Dates'),
        backgroundColor: isDesktop ? Colors.white : null,
        elevation: isDesktop ? 0.5 : null,
      ),
      body: ResponsiveWidget(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  bool get isReturnAndPickupSameDay =>
      pickupDateNotifier.value.dateOnly.isSameDay(
        returnDateController.text.parseToDateTime().dateOnly,
      );

  void validateTimeOnSameDay() {
    if (pickupTime != null && returnTime != null && isReturnAndPickupSameDay) {
      if (pickupTime!.hour > returnTime!.hour ||
          (pickupTime!.hour == returnTime!.hour &&
              pickupTime!.minute >= returnTime!.minute)) {
        // Invalid time combination
        context.showSnackBar(
          'On the same day, return time must be after pickup time.',
          title: 'Time Error',
          isError: true,
        );

        // Clear return time to force user to fix
        returnTime = null;
        returnTimeController.clear();
      }
    }
  }

  // Future<void> selectTime(
  //     BuildContext context, TextEditingController controller) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay(hour: DateTime.now().hour, minute: 00),
  //   );

  //   if (picked != null) {
  //     final time = picked.format(context);
  //     controller.text = time;
  //   }
  // }

  Future<void> selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: returnDateController.text.parseToDateTime(),
      firstDate: pickupDateNotifier.value,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      returnDateController.text = picked.format();
      validateTimeOnSameDay();
    }
  }

  @override
  void dispose() {
    // controllers
    returnDateController.dispose();
    pickupTimeController.dispose();
    returnTimeController.dispose();

    // notifiers
    pickupDateNotifier.dispose();

    super.dispose();
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildSectionHeader('Select Pickup Date'),
                    const SizedBox(height: 12),
                    _buildCalendarSection(context),
                    const SizedBox(height: 24),
                    _buildDateTimeSection(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Calendar
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('Select Pickup Date'),
                            const SizedBox(height: 20),
                            _buildCalendarSection(context),
                          ],
                        ),
                      ),
                    ),
                    // Right side - Date/Time inputs
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: _buildDateTimeSection(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side - Calendar
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          margin: const EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeader('Select Pickup Date'),
                              const SizedBox(height: 24),
                              _buildCalendarSection(context),
                            ],
                          ),
                        ),
                      ),
                      // Right side - Date/Time inputs
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: _buildDateTimeSection(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _buildContinueButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1a1a1a),
      ),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return Container(
      height: 400,
      child: Center(
        child: CalenderWidget(
          onDateSelected: (selectedDate) {
            pickupDateNotifier.value = selectedDate;
            validateTimeOnSameDay();
            final returnDate = returnDateController.text.parseToDateTime();
            if (returnDate.isBefore(selectedDate)) {
              returnDateController.text = selectedDate.add(1.days()).format();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDateTimeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Return Date'),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'Select Return Date',
          controller: returnDateController,
          ignorePointers: true,
          keyboardType: TextInputType.datetime,
          prefixIcon: const Icon(Icons.calendar_month, color: Color(0xFF667eea)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a return date';
            }
            return null;
          },
        ).onTap(() => selectReturnDate(context)),
        
        const SizedBox(height: 32),
        
        // Time section header with clear button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Time (Optional)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1a1a1a),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                pickupTime = null;
                pickupTimeController.clear();
                returnTime = null;
                returnTimeController.clear();
              },
              icon: const Icon(Icons.clear, size: 18),
              label: const Text('Clear'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF667eea),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Pickup Time
        CustomTextField(
          controller: pickupTimeController,
          label: 'Pickup Time',
          hintText: 'Select Pickup Time',
          ignorePointers: true,
          prefixIcon: const Icon(Icons.access_time, color: Color(0xFF667eea)),
          validator: null,
        ).onTap(() => _selectTime(context, true)),
        
        const SizedBox(height: 16),
        
        // Return Time
        CustomTextField(
          controller: returnTimeController,
          label: 'Return Time',
          hintText: 'Select Return Time',
          ignorePointers: true,
          prefixIcon: const Icon(Icons.access_time, color: Color(0xFF667eea)),
          validator: null,
        ).onTap(() => _selectTime(context, false)),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => _handleContinue(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF667eea),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isPickup) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: (isPickup ? pickupTime : returnTime) ?? TimeOfDay.now().clearedTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isPickup) {
        // Check if returnTime already selected and compare
        if (returnTime != null && picked.isAfter(returnTime!) && isReturnAndPickupSameDay) {
          context.showSnackBar(
            'Pickup time must be before return time',
            title: 'Time Error',
            isError: true,
          );
          return;
        }
        pickupTime = picked;
        pickupTimeController.text = picked.formatTime12Hour();
      } else {
        // Return time
        if (pickupTime != null && picked.isBefore(pickupTime!) && isReturnAndPickupSameDay) {
          context.showSnackBar(
            'Return time must be after pickup time',
            title: 'Time Error',
            isError: true,
          );
          return;
        }
        returnTime = picked;
        returnTimeController.text = picked.formatTime12Hour();
      }
    }
  }

  void _handleContinue(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      context.showSnackBar(
        'Please select return date and try again.',
        title: 'Date Error',
        isError: true,
      );
      return;
    }

    context.push(SelectServiceScreen(
      onServiceSelected: (service, ctx) async {
        log('pickup time: $pickupTime, return time: $returnTime');
        final data = await ctx.push(
          SelectProductScreen(
            serviceId: service.id,
            pickupDate: pickupDateNotifier.value.format(reverse: true),
            returnDate: returnDateController.text.formatToUiDate(),
            pickupTime: pickupTime,
            returnTime: returnTime,
          ),
        );
        ctx.push(
          AddBookingProductScreen(
            selectedProductsNotifier: ValueNotifier(data),
            addBookingModel: widget.addBookingModel.copyWith(
              serviceId: service.id,
              pickupDate: pickupDateNotifier.value.format(reverse: true),
              returnDate: returnDateController.text.formatToUiDate(),
              pickupTime: pickupTime,
              returnTime: returnTime,
            ),
          ),
        );
      },
    ));
  }
}
