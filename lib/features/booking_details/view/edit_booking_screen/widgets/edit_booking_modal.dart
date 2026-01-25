import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_additional_charges_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_additional_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_button.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_client_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_date_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_location_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_time_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_product_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBookingModal extends StatefulWidget {
  final BookingDetailsModel booking;

  const EditBookingModal({
    super.key,
    required this.booking,
  });

  @override
  State<EditBookingModal> createState() => _EditBookingModalState();
}

class _EditBookingModalState extends State<EditBookingModal> {
  final _formController = EditBookingFormStateController();

  @override
  void initState() {
    super.initState();
    _formController.setInitialValues(context: context, booking: widget.booking);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  Future<void> _handleClose() async {
    if (_formController.hasUnsavedChanges(widget.booking)) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true && mounted) {
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.92,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Content
            Expanded(
              child: Form(
                key: _formController.formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          InkWell(
            onTap: _handleClose,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios,
                      size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          const Text(
            'Edit Booking',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 12),
          // Booking ID chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6132E4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '#${widget.booking.invoiceId}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6132E4),
              ),
            ),
          ),
          const Spacer(),
          // Close button
          IconButton(
            onPressed: _handleClose,
            icon: Icon(Icons.close, color: Colors.grey.shade600),
            tooltip: 'Close',
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Dates, Times, Client, Staff, Notes etc.
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Section (Pickup, Return, Cooling Period)
                  EditBookingDateSection(formController: _formController),

                  const SizedBox(height: 20),

                  // Time Section
                  EditBookingTimeSection(formController: _formController),

                  const SizedBox(height: 20),

                  // Client & Staff Details in Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: EditBookingClientDetailsSection(
                          clientNameController:
                              _formController.clientNameController,
                          clientPhone1Controller:
                              _formController.clientPhone1Controller,
                          clientPhone2Controller:
                              _formController.clientPhone2Controller,
                          clientAddressController:
                              _formController.clientAddressController,
                          isClientSearchEnabledNotifier:
                              _formController.isClientSearchEnabledNotifier,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: EditBookingSectionColumn(
                          title: 'Staff Details',
                          child: StaffSearchNameField(
                            nameController: _formController.staffNameController,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Location Details (if vehicle)
                  if (widget.booking.bookedItems.firstOrNull?.mainServiceType
                          .isVehicle ??
                      false) ...[
                    const SizedBox(height: 20),
                    EditBookingLocationDetailsSection(
                      locationStartController:
                          _formController.locationStartController,
                      locationFromController:
                          _formController.locationFromController,
                      locationToController:
                          _formController.locationToController,
                    ),
                  ],

                  // Notes
                  const SizedBox(height: 20),
                  EditBookingSectionColumn(
                    title: 'Notes',
                    child: CustomTextField(
                      controller: _formController.descriptionController,
                      validator: (value) => AppInputValidators.isEmpty(value)
                          ? null
                          : AppInputValidators.description(value),
                      hintText: 'Enter notes about this booking...',
                      maxLines: 3,
                    ),
                  ),

                  // Additional Details & Charges
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: EditBookingAdditionalDetailsSection(
                          securityAmountController:
                              _formController.securityAmountController,
                          discountAmountController:
                              _formController.discountAmountController,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: EditBookingAdditionalChargesSection(
                          additionalChargesNotifier:
                              _formController.additionalChargesNotifier,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Middle Column: Product Selection Section
        Expanded(
          flex: 5,
          child: EditBookingProductSection(
            selectedProductsNotifier: _formController.selectedProductsNotifier,
            formController: _formController,
            pickupDate:
                _formController.pickUpdDateController.text.parseToDateTime(),
            returnDate:
                _formController.returnDateController.text.parseToDateTime(),
            pickupTime: _formController.pickupTime,
            returnTime: _formController.returnTime,
          ),
        ),

        const SizedBox(width: 12),

        // Right Column: Actions Sidebar
        SizedBox(
          width: 300,
          child: _buildRightSidebar(),
        ),
      ],
    );
  }

  Widget _buildRightSidebar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // Update Booking Button
          EditBookingButton(
            formController: _formController,
            booking: widget.booking,
          ),

          const SizedBox(height: 12),

          // Cancel Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: _handleClose,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Booking Summary Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Summary',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSummaryRow(
                  'Status',
                  widget.booking.deliveryStatus?.name ?? 'N/A',
                  valueColor:
                      _getStatusColor(widget.booking.deliveryStatus?.name),
                ),
                const Divider(height: 16),
                _buildSummaryRow(
                  'Total Amount',
                  '₹${widget.booking.totalAmount}',
                  valueColor: const Color(0xFF6132E4),
                  isBold: true,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  'Paid',
                  '₹${widget.booking.actualPaidAmount}',
                  valueColor: Colors.green.shade600,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  'Balance',
                  '₹${widget.booking.totalAmount - widget.booking.actualPaidAmount}',
                  valueColor: Colors.orange.shade600,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Info card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Changes will be saved immediately after clicking Update Booking',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade900,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: valueColor ?? Colors.black87,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    switch (status.toLowerCase()) {
      case 'booked':
        return Colors.blue.shade600;
      case 'delivered':
        return Colors.orange.shade600;
      case 'returned':
        return Colors.green.shade600;
      case 'cancelled':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}

/// Helper function to show Edit Booking Modal
Future<void> showEditBookingModal({
  required BuildContext context,
  required BookingDetailsModel booking,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (dialogContext) => BlocProvider(
      create: (_) => UpdateBookingCubit(
        bookingRepository: getIt<BookingRepository>(),
        clientRepository: getIt<ClientRepository>(),
      ),
      child: EditBookingModal(booking: booking),
    ),
  );
}
