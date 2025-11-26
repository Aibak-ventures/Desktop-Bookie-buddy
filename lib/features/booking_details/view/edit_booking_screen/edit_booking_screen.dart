import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_additional_charges_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_additional_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_button.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_client_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_date_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_edit_product_list_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_location_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_time_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingScreen extends StatefulWidget {
  final BookingDetailsModel booking;
  const EditBookingScreen({required this.booking, super.key});

  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  // Unified controller managing all form state
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

  //---------- Discard Changes Handlers ----------
  void handlePop(bool didPop, dynamic result) async {
    if (didPop) {
      return;
    }

    if (_formController.hasUnsavedChanges(widget.booking)) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard ?? false) {
        Navigator.pop(context, result); // allow pop
      }
      // else do nothing – cancel pop
    } else {
      Navigator.pop(context, result); // allow pop
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        onPopInvokedWithResult: handlePop,
        child: Scaffold(
          backgroundColor: context.isDesktop ? const Color(0xFFF5F7FA) : null,
          appBar: AppBar(
            title: const Text('Edit Booking'),
            backgroundColor: context.isDesktop ? Colors.white : null,
            elevation: context.isDesktop ? 1 : null,
          ),
          body: context.isDesktop ? _buildWebLayout() : _buildMobileLayout(),
        ),
      );

  Widget _buildWebLayout() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          margin: const EdgeInsets.all(32),
          child: Form(
            key: _formController.formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Form Content (70%)
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.all(32),
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
                          'Booking Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Two-column grid for form sections
                        _buildWebFormGrid(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 24),

                // Action Panel (30%)
                Expanded(
                  flex: 3,
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
                          'Actions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Save/Update Button
                        EditBookingButton(
                          formController: _formController,
                          booking: widget.booking,
                        ),

                        const SizedBox(height: 16),

                        // Cancel Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade400),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
      ),
    );
  }

  Widget _buildWebFormGrid() {
    return Column(
      children: [
        // Row 1: Staff Details & Client Details
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: EditBookingSectionColumn(
                title: 'Staff Details',
                child: StaffSearchNameField(
                  nameController: _formController.staffNameController,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: EditBookingClientDetailsSection(
                clientNameController: _formController.clientNameController,
                clientPhone1Controller: _formController.clientPhone1Controller,
                clientPhone2Controller: _formController.clientPhone2Controller,
                clientAddressController:
                    _formController.clientAddressController,
                isClientSearchEnabledNotifier:
                    _formController.isClientSearchEnabledNotifier,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Row 2: Location Details (if vehicle) - Full Width
        if (widget.booking.bookedItems.firstOrNull?.mainServiceType.isVehicle ??
            false)
          Column(
            children: [
              EditBookingLocationDetailsSection(
                locationStartController:
                    _formController.locationStartController,
                locationFromController: _formController.locationFromController,
                locationToController: _formController.locationToController,
              ),
              const SizedBox(height: 32),
            ],
          ),

        // Row 3: Product Details - Full Width
        EditBookingEditProductListSection(
          selectedProductsNotifier: _formController.selectedProductsNotifier,
          formController: _formController,
          pickUpdDateController: _formController.pickUpdDateController,
          returnDateController: _formController.returnDateController,
          coolingPeriodDateController:
              _formController.coolingPeriodDateController,
        ),

        const SizedBox(height: 32),

        // Row 4: Notes & Time Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: EditBookingSectionColumn(
                title: 'Notes',
                child: CustomTextField(
                  controller: _formController.descriptionController,
                  validator: (value) => AppInputValidators.isEmpty(value)
                      ? null
                      : AppInputValidators.description(value),
                  hintText: 'Enter Notes',
                  maxLines: 4,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: EditBookingTimeSection(formController: _formController),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Row 5: Date Section - Full Width
        EditBookingDateSection(formController: _formController),

        const SizedBox(height: 32),

        // Row 6: Additional Details & Additional Charges
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
            const SizedBox(width: 24),
            Expanded(
              child: EditBookingAdditionalChargesSection(
                additionalChargesNotifier:
                    _formController.additionalChargesNotifier,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: 16.padding,
      child: Form(
        key: _formController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 30.w,
          children: [
            // staff details
            EditBookingSectionColumn(
              title: 'Staff Details',
              child: StaffSearchNameField(
                nameController: _formController.staffNameController,
              ),
            ),

            // client details
            EditBookingClientDetailsSection(
              clientNameController: _formController.clientNameController,
              clientPhone1Controller: _formController.clientPhone1Controller,
              clientPhone2Controller: _formController.clientPhone2Controller,
              clientAddressController: _formController.clientAddressController,
              isClientSearchEnabledNotifier:
                  _formController.isClientSearchEnabledNotifier,
            ),

            // location details
            // Only show if it's a vehicle
            if (widget.booking.bookedItems.firstOrNull?.mainServiceType
                    .isVehicle ??
                false)
              EditBookingLocationDetailsSection(
                locationStartController:
                    _formController.locationStartController,
                locationFromController: _formController.locationFromController,
                locationToController: _formController.locationToController,
              ),

            // product details
            EditBookingEditProductListSection(
              selectedProductsNotifier:
                  _formController.selectedProductsNotifier,
              formController: _formController,
              pickUpdDateController: _formController.pickUpdDateController,
              returnDateController: _formController.returnDateController,
              coolingPeriodDateController:
                  _formController.coolingPeriodDateController,
            ),

            // product notes (description)
            EditBookingSectionColumn(
              title: 'Notes',
              child: CustomTextField(
                controller: _formController.descriptionController,
                validator: (value) => AppInputValidators.isEmpty(value)
                    ? null
                    : AppInputValidators.description(value),
                hintText: 'Enter Notes',
              ),
            ),
            //Times
            EditBookingTimeSection(formController: _formController),

            // dates
            EditBookingDateSection(formController: _formController),

            // additional details
            EditBookingAdditionalDetailsSection(
              securityAmountController:
                  _formController.securityAmountController,
              discountAmountController:
                  _formController.discountAmountController,
            ),

            // additional charges
            EditBookingAdditionalChargesSection(
              additionalChargesNotifier:
                  _formController.additionalChargesNotifier,
            ),

            // save button
            EditBookingButton(
              formController: _formController,
              booking: widget.booking,
            ),
            0.01.heightCustom,
          ],
        ),
      ),
    );
  }
}
