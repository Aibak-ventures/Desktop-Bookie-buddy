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

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: handlePop,
    child: Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
      body: SingleChildScrollView(
        padding: context.isMobile ? 16.padding : (40, 16).padding,
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
                clientAddressController:
                    _formController.clientAddressController,
                isClientSearchEnabledNotifier:
                    _formController.isClientSearchEnabledNotifier,
              ),

              // location details
              // Only show if it's a vehicle
              if (widget
                  .booking
                  .bookedItems
                  .firstOrNull!
                  .mainServiceType
                  .isVehicle)
                EditBookingLocationDetailsSection(
                  locationStartController:
                      _formController.locationStartController,
                  locationFromController:
                      _formController.locationFromController,
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

              // purchase mode
              // buildPurchaseModeSection(),

              // save button
              EditBookingButton(
                formController: _formController,
                booking: widget.booking,
              ),
              0.01.heightCustom,
            ],
          ),
        ),
      ),
    ),
  );

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
}
