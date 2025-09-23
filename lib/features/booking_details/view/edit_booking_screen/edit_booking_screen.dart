import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_client_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_edit_product_list_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_location_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/edit_booking_button.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingScreen extends StatefulWidget {
  final BookingDetailsModel booking;
  const EditBookingScreen({required this.booking, Key? key}) : super(key: key);

  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final returnDateController = TextEditingController();
  final staffNameController = TextEditingController();
  final selectedPurchaseMode = ValueNotifier(PurchaseMode.normal);
  final pickUpdDateController = TextEditingController();

  //location
  final locationStartController = TextEditingController();
  final locationFromController = TextEditingController();
  final locationToController = TextEditingController();

  // client details controller
  final clientNameController = TextEditingController();
  final clientPhone1Controller = TextEditingController();
  final clientPhone2Controller = TextEditingController();
  final clientAddressController = TextEditingController();

  late TimeOfDay pickupTime;
  late TimeOfDay returnTime;

  final pickupTimeController = TextEditingController();
  final returnTimeController = TextEditingController();

  final selectedProductsNotifier =
      ValueNotifier<List<ProductSelectedModel>>([]); // Passed to backend
  late final bool isPickupDateBeforeCurrentDate;
  late final bool isReturnDateBeforeCurrentDate;

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.booking.description ?? "";
    selectedPurchaseMode.value = widget.booking.purchaseMode;
    staffNameController.text = widget.booking.staffName;
    returnDateController.text = widget.booking.returnDate.formatToUiDate();
    pickUpdDateController.text =
        widget.booking.pickupDate?.formatToUiDate() ?? "";

    isPickupDateBeforeCurrentDate =
        widget.booking.pickupDate?.parseToDateTime().isBefore(DateTime.now()) ??
            false;

    isReturnDateBeforeCurrentDate =
        widget.booking.returnDate.parseToDateTime().isBefore(DateTime.now());

    // selectedService = widget.booking.service.name;
    selectedProductsNotifier.value =
        widget.booking.bookedItems.map((productInfo) {
      return ProductSelectedModel(
        variant: productInfo,
        amount: productInfo.amount,
        measurements: productInfo.measurements,
        quantity: productInfo.quantity,
      );
    }).toList();

    log(selectedProductsNotifier.value.toString());
    //
    clientNameController.text = widget.booking.client.name;
    clientPhone1Controller.text = widget.booking.client.phone1.toString();
    clientPhone2Controller.text =
        widget.booking.client.phone2?.toString() ?? '';
    clientAddressController.text = widget.booking.address ?? '';

    //location
    locationStartController.text =
        widget.booking.otherDetails['location_start'] ?? '';
    locationFromController.text =
        widget.booking.otherDetails['location_from'] ?? '';
    locationToController.text =
        widget.booking.otherDetails['location_to'] ?? '';

    pickupTime = widget.booking.pickupDate?.parseToDateTime().toTimeOfDay ??
        const TimeOfDay(hour: 0, minute: 0);
    returnTime = widget.booking.returnDate.parseToDateTime().toTimeOfDay;

    pickupTimeController.text =
        widget.booking.pickupDate?.formatToUiTime() ?? '';
    returnTimeController.text = widget.booking.returnDate.formatToUiTime();
  }

  // pickup date function
  Future<void> selectPickupDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickUpdDateController.text.parseToDateTime(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      if (validateTimeOnSameDay(pickupDate: picked))
        pickUpdDateController.text = picked.format();
      if (returnDateController.text.parseToDateTime().isBefore(picked)) {
        returnDateController.text = picked.add(1.days()).format();
      }
    }
  }

  // return date function
  Future<void> selectReturnDate(BuildContext context) async {
    final firstDate = pickUpdDateController.text.parseToDateTime();
    final initialDate = returnDateController.text.parseToDateTime();
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: firstDate.isAfter(initialDate) ? firstDate : initialDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && validateTimeOnSameDay(returnDate: picked)) {
      returnDateController.text = picked.format();
    }
  }

  @override
  Widget build(BuildContext context) {
    log('isPickupDateBeforeCurrentDate: $isPickupDateBeforeCurrentDate, pickupDate: ${widget.booking.pickupDate?.parseToDateTime()}, date: ${DateTime.now().dateOnly.subtract(1.days())}, compare: ${widget.booking.pickupDate?.parseToDateTime().isBefore(DateTime.now().dateOnly.subtract(1.days()))}');
    log('isReturnDateBeforeCurrentDate: $isReturnDateBeforeCurrentDate, returnDate: ${widget.booking.returnDate.parseToDateTime()}');
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: handlePop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Booking',
          ),
        ),
        body: SingleChildScrollView(
          padding: context.isMobile ? 16.padding : (40, 16).padding,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 30.w,
              children: [
                // client details
                buildClientDetailsSection(),

                // location details
                // Only show if it's a vehicle
                if ((widget.booking.bookedItems.firstOrNull?.mainServiceType
                        .isVehicle) ??
                    false)
                  buildLocationDetailsSection(),

                // product details
                buildProductDetailsSection(),

                // product notes (description)
                EditBookingSectionColumn(
                  title: 'Notes',
                  child: CustomTextField(
                    controller: descriptionController,
                    validator: (value) => AppInputValidators.isEmpty(value)
                        ? null
                        : AppInputValidators.description(value),
                    hintText: 'Enter Notes',
                  ),
                ),
                //Times
                buildTimeSection(context),

                // dates
                buildDatesSection(context),

                // staff details
                EditBookingSectionColumn(
                  title: 'Staff Details',
                  child: CustomTextField(
                    controller: staffNameController,
                    keyboardType: TextInputType.name,
                    hintText: 'Enter Staff Name',
                    label: "Staff Name",
                    validator: AppInputValidators.name,
                  ),
                ),

                // purchase mode
                buildPurchaseModeSection(),

                // save button
                EditBookingButton(
                  selectedProductsNotifier: selectedProductsNotifier,
                  booking: widget.booking,
                  formKey: formKey,
                  pickUpdDateController: pickUpdDateController,
                  returnDateController: returnDateController,
                  descriptionController: descriptionController,
                  staffNameController: staffNameController,
                  selectedPurchaseMode: selectedPurchaseMode,
                  clientAddressController: clientAddressController,
                  clientNameController: clientNameController,
                  clientPhone1Controller: clientPhone1Controller,
                  clientPhone2Controller: clientPhone2Controller,
                  locationStartController: locationStartController,
                  locationFromController: locationFromController,
                  locationToController: locationToController,
                  pickupTimeController: pickupTimeController,
                  returnTimeController: returnTimeController,
                ),
                0.01.heightCustom,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Client Details
  Widget buildClientDetailsSection() {
    return EditBookingClientDetailsSection(
      clientNameController: clientNameController,
      clientPhone1Controller: clientPhone1Controller,
      clientPhone2Controller: clientPhone2Controller,
      clientAddressController: clientAddressController,
    );
  }

  // Product Details
  Widget buildProductDetailsSection() {
    return EditBookingEditProductListSection(
      selectedProductsNotifier: selectedProductsNotifier,
      isPickupDateBeforeCurrentDate: isPickupDateBeforeCurrentDate,
      pickUpdDateController: pickUpdDateController,
      returnDateController: returnDateController,
    );
  }

  Widget buildPurchaseModeSection() {
    return EditBookingSectionColumn(
      title: 'Purchase Mode',
      child: ValueListenableBuilder(
        valueListenable: selectedPurchaseMode,
        builder: (context, selected, child) => Column(
          children: [
            RadioListTile<PurchaseMode>(
              title: Text(PurchaseMode.normal.name),
              value: PurchaseMode.normal,
              groupValue: selected,
              onChanged: (value) {
                selectedPurchaseMode.value = value!;
              },
            ),
            RadioListTile<PurchaseMode>(
              title: Text(PurchaseMode.package.name),
              value: PurchaseMode.package,
              groupValue: selected,
              onChanged: (value) {
                selectedPurchaseMode.value = value!;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeSection(BuildContext context) {
    return EditBookingSectionColumn(
      title: 'Times',
      child: Column(
        spacing: 15.w,
        children: [
          CustomTextField(
            controller: pickupTimeController,
            label: 'Pickup Time',
            hintText: 'Select Pickup Time',
            ignorePointers: true,
            prefixIcon: const Icon(Icons.access_time),
            validator: null,
          ).onTap(() async {
            if (isPickupDateBeforeCurrentDate) {
              return;
            }

            final picked = await showTimePicker(
              context: context,
              initialTime: pickupTime,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              if (isReturnAndPickupSameDay(
                      pickUpdDateController.text.parseToDateTime(),
                      returnDateController.text.parseToDateTime()) &&
                  picked.isAfter(returnTime)) {
                // Invalid pickup time
                context.showSnackBar(
                  'Pickup time must be before return time',
                  title: 'Time Error',
                  isError: true,
                );
                return;
              }
              pickupTime = picked;
              pickupTimeController.text = picked.formatTime12Hour();
            }
          }),
          CustomTextField(
            controller: returnTimeController,
            label: 'Return Time',
            hintText: 'Select Return Time',
            ignorePointers: true,
            prefixIcon: const Icon(Icons.access_time),
            validator: null,
          ).onTap(() async {
            if (isReturnDateBeforeCurrentDate) {
              return;
            }

            final picked = await showTimePicker(
              context: context,
              initialTime: returnTime,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              if (isReturnAndPickupSameDay(
                      pickUpdDateController.text.parseToDateTime(),
                      returnDateController.text.parseToDateTime()) &&
                  picked.isBefore(pickupTime)) {
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
          }),
        ],
      ),
    );
  }

  Widget buildDatesSection(BuildContext context) {
    return EditBookingSectionColumn(
      title: 'Dates',
      child: Column(
        spacing: 15.w,
        children: [
          CustomTextField(
            ignorePointers: true,
            controller: pickUpdDateController,
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a pickup date';
              }
              return null;
            },
            hintText: 'Select Pickup Date',
            label: "Pickup Date",
          ).onTap(
            () => isPickupDateBeforeCurrentDate
                ? null
                : selectPickupDate(context),
          ),
          CustomTextField(
            ignorePointers: true,
            controller: returnDateController,
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a return date';
              }
              return null;
            },
            hintText: 'Select Return Date',
            label: "Return Date",
          ).onTap(
            () => isReturnDateBeforeCurrentDate
                ? null
                : selectReturnDate(context),
          ),
        ],
      ),
    );
  }

  Widget buildLocationDetailsSection() {
    return EditBookingLocationDetailsSection(
      locationStartController: locationStartController,
      locationFromController: locationFromController,
      locationToController: locationToController,
    );
  }

  @override
  void dispose() {
    //
    descriptionController.dispose();
    returnDateController.dispose();
    staffNameController.dispose();
    pickUpdDateController.dispose();
    selectedPurchaseMode.dispose();
    selectedProductsNotifier.dispose();

    //client
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    clientAddressController.dispose();

    //location
    locationStartController.dispose();
    locationFromController.dispose();
    locationToController.dispose();

    //time
    pickupTimeController.dispose();
    returnTimeController.dispose();
    super.dispose();
  }

  //---------- Discard Changes Handlers ----------
  void handlePop(bool didPop, dynamic result) async {
    if (didPop) {
      return;
    }

    if (hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard ?? false) {
        Navigator.pop(context, result); // allow pop
      }
      // else do nothing – cancel pop
    } else {
      Navigator.pop(context, result); // allow pop
    }
  }

  Future<bool?> showDiscardDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text('Are you sure you want to discard your changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Discard',
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool hasUnsavedChanges() {
    // final oldItems = widget.booking.bookedItems
    //     .map(
    //       (e) => ProductSelectedModel(
    //         variant: e,
    //         amount: e.amount,
    //         quantity: e.quantity,
    //       ),
    //     )
    //     .toList();

    // final newItems = selectedProductsNotifier.value;

    // final changedProduct = getChangedProductIds(
    //   oldProducts: oldItems,
    //   newProducts: newItems,
    // );

    final isLocationChanged = isFieldChanged(
          widget.booking.otherDetails['location_to'] ?? '',
          locationToController.text,
        ) ||
        isFieldChanged(
          widget.booking.otherDetails['location_from'] ?? '',
          locationFromController.text,
        ) ||
        isFieldChanged(
          widget.booking.otherDetails['location_start'] ?? '',
          locationStartController.text,
        );

    final oldPickupTime =
        widget.booking.pickupDate?.parseToDateTime().toTimeOfDay;
    final oldReturnTime =
        widget.booking.returnDate.parseToDateTime().toTimeOfDay;

    final pickupTime =
        pickupTimeController.text.to24HourTimeOfDayFrom12Format();
    final returnTime =
        returnTimeController.text.to24HourTimeOfDayFrom12Format();

    final isPickupTimeChanged = oldPickupTime != pickupTime;
    final isReturnTimeChanged = oldReturnTime != returnTime;

    final newClient = ClientRequestModel(
      id: widget.booking.client.id,
      name:
          isFieldChanged(widget.booking.client.name, clientNameController.text)
              ? clientNameController.text.trim()
              : null,
      phone1: widget.booking.client.phone1
              .toString()
              .hasNumberChangedComparedTo(clientPhone1Controller.text)
          ? clientPhone1Controller.text.trim().toInt()
          : null,
      phone2: widget.booking.client.phone2
              .toString()
              .hasNumberChangedComparedTo(clientPhone2Controller.text)
          ? clientPhone2Controller.text.trim().toIntOrNull()
          : null,
    );

    final isClientChanged = newClient.toJson().isNotEmpty;

    final isPickupDateChanged = isFieldChanged(
      widget.booking.pickupDate?.formatToUiDate() ?? '',
      pickUpdDateController.text,
    );
    final isReturnDateChanged = isFieldChanged(
      widget.booking.returnDate.formatToUiDate(),
      returnDateController.text,
    );

    final isDescriptionChanged = isFieldChanged(
        widget.booking.description ?? '', descriptionController.text);

    final isStaffNameChanged =
        isFieldChanged(widget.booking.staffName, staffNameController.text);

    final isClientAddressChanged = isFieldChanged(
        widget.booking.address ?? '', clientAddressController.text);

    // log('changedProduct $changedProduct');

    return isLocationChanged ||
        isPickupTimeChanged ||
        isReturnTimeChanged ||
        isClientChanged ||
        isPickupDateChanged ||
        isReturnDateChanged ||
        isDescriptionChanged ||
        isStaffNameChanged ||
        isClientAddressChanged;
  }

  bool isFieldChanged(String oldValue, String newValue) {
    return oldValue.trim() != newValue.trim();
  }

  bool isReturnAndPickupSameDay(
    DateTime pickupDate,
    DateTime returnDate,
  ) =>
      pickupDate.dateOnly.isSameDay(
        returnDate.dateOnly,
      );

  bool validateTimeOnSameDay({
    DateTime? pickupDate,
    DateTime? returnDate,
  }) {
    // print('isReturnAndPickupSameDay $isReturnAndPickupSameDay(pickupDate, returnDate)');
    if (isReturnAndPickupSameDay(
        pickupDate ?? pickUpdDateController.text.parseToDateTime(),
        returnDate ?? returnDateController.text.parseToDateTime())) {
      if (pickupTime.hour > returnTime.hour ||
          (pickupTime.hour == returnTime.hour &&
              pickupTime.minute >= returnTime.minute)) {
        // Invalid time combination
        context.showSnackBar(
          'On the same day, return time must be after pickup time.',
          title: 'Time Error',
          isError: true,
        );

        return false;
      }
    }

    return true;
  }
}
