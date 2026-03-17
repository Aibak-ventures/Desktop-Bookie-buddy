import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/widgets/edit_booking_date_selection_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/widgets/edit_booking_edit_product_list_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/widgets/edit_booking_right_panel.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';

class EditBookingScreen extends StatefulWidget {
  final BookingDetailsModel booking;
  const EditBookingScreen({required this.booking, super.key});

  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  // Unified controller managing all form state
  final _formController = EditBookingFormStateController();

  // State for date/time
  late DateTime pickupDate;
  late DateTime returnDate;
  DateTime? coolingPeriodDate;
  TimeOfDay? pickupTime;
  TimeOfDay? returnTime;
  TimeOfDay? coolingPeriodTime;

  // Track if it's a sales booking
  bool isSalesMode = false;

  // Selected products notifier
  late ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;

  // Additional charges notifier
  late ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;

  // Payment controllers
  final advanceAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formController.setInitialValues(context: context, booking: widget.booking);

    // Initialize dates from booking (convert String to DateTime)
    pickupDate = widget.booking.pickupDate?.parseToDateTime() ?? DateTime.now();
    returnDate = widget.booking.returnDate.parseToDateTime();
    coolingPeriodDate = widget.booking.coolingPeriodDate?.parseToDateTime();

    // Extract time from dates
    pickupTime = widget.booking.pickupDate?.parseToDateTime().toTimeOfDay;
    returnTime = widget.booking.returnDate.parseToDateTime().toTimeOfDay;
    coolingPeriodTime =
        widget.booking.coolingPeriodDate?.parseToDateTime().toTimeOfDay;

    // Determine if it's a sales booking (typically sales don't have pickup dates)
    isSalesMode =
        widget.booking.pickupDate == null || widget.booking.pickupDate!.isEmpty;

    // Initialize notifiers
    selectedProductsNotifier = _formController.selectedProductsNotifier;
    additionalChargesNotifier = _formController.additionalChargesNotifier;

    // Initialize advance amount
    advanceAmountController.text = widget.booking.paidAmount.toString();
  }

  @override
  void dispose() {
    advanceAmountController.dispose();
    _formController.dispose();
    super.dispose();
  }

  //---------- Discard Changes Handlers ----------
  void handlePop(bool didPop, dynamic result) async {
    if (didPop) {
      return;
    }

    if (_formController.hasUnsavedChanges(widget.booking)) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard ?? false) {
        if (mounted) Navigator.pop(context, result);
      }
    } else {
      if (mounted) Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: handlePop,
      child: Container(
        color: const Color(0xFFF5F6FA),
        height: screenHeight,
        child: Form(
          key: _formController.formKey,
          child: Column(
            children: [
              // Compact Header
              _buildCompactHeader(),
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: _buildMainContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          InkWell(
            onTap: () => handlePop(false, null),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Text(
            isSalesMode ? 'Edit Sale' : 'Edit Booking',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Side: Dates + Products
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Selection Section
              EditBookingDateSelectionSection(
                pickupDate: pickupDate,
                returnDate: returnDate,
                coolingPeriodDate: coolingPeriodDate,
                pickupTime: pickupTime,
                returnTime: returnTime,
                coolingPeriodTime: coolingPeriodTime,
                onPickupDateChanged: (d) => setState(() => pickupDate = d),
                onReturnDateChanged: (d) => setState(() => returnDate = d),
                onCoolingPeriodDateChanged: (d) =>
                    setState(() => coolingPeriodDate = d),
                onPickupTimeChanged: (t) => setState(() => pickupTime = t),
                onReturnTimeChanged: (t) => setState(() => returnTime = t),
                onCoolingPeriodTimeChanged: (t) =>
                    setState(() => coolingPeriodTime = t),
                isSalesMode: isSalesMode,
              ),
              const SizedBox(height: 16),

              // Product List Section
              Expanded(
                child: EditBookingEditProductListSection(
                  selectedProductsNotifier: selectedProductsNotifier,
                  formController: _formController,
                  pickUpdDateController: _formController.pickUpdDateController,
                  returnDateController: _formController.returnDateController,
                  coolingPeriodDateController:
                      _formController.coolingPeriodDateController,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Right panel: Staff, Client, Summary
        SizedBox(
          width: 340,
          child: EditBookingRightPanel(
            formController: _formController,
            booking: widget.booking,
            selectedProductsNotifier: selectedProductsNotifier,
            additionalChargesNotifier: additionalChargesNotifier,
            advanceAmountController: advanceAmountController,
            discountAmountController: _formController.discountAmountController,
            securityAmountController: _formController.securityAmountController,
          ),
        ),
      ],
    );
  }
}
