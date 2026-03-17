import 'dart:developer';

import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Controller to encapsulate all Edit Booking form state, controllers,
/// notifiers and lifecycle. Mirrors the style used by AddOrEditSalesFormStateController.
class EditBookingFormStateController {
  // Keep a reference to the original booking for comparisons/fallbacks
  BookingDetailsModel? originalBooking;

  // Form key
  final formKey = GlobalKey<FormState>();

  // Basic info
  final descriptionController = TextEditingController();
  final staffNameController = TextEditingController();
  // final selectedPurchaseMode = ValueNotifier<PurchaseMode>(PurchaseMode.normal);

  // Dates
  final returnDateController = TextEditingController();
  final pickUpdDateController = TextEditingController();
  final coolingPeriodDateController = TextEditingController();

  // Location
  final locationStartController = TextEditingController();
  final locationFromController = TextEditingController();
  final locationToController = TextEditingController();

  // Client
  final clientNameController = TextEditingController();
  final clientPhone1Controller = TextEditingController();
  final clientPhone2Controller = TextEditingController();
  final clientAddressController = TextEditingController();
  final isClientSearchEnabledNotifier = ValueNotifier<bool>(false);

  // Amounts
  final discountAmountController = TextEditingController();
  final securityAmountController = TextEditingController();

  // Time
  late TimeOfDay pickupTime;
  late TimeOfDay returnTime;
  final pickupTimeController = TextEditingController();
  final returnTimeController = TextEditingController();

  // Products
  final selectedProductsNotifier = ValueNotifier<List<ProductSelectedModel>>(
    const [],
  );

  final additionalChargesNotifier = ValueNotifier<List<AdditionalChargesModel>>(
    const [],
  );

  void dispose() {
    descriptionController.dispose();
    returnDateController.dispose();
    coolingPeriodDateController.dispose();
    staffNameController.dispose();
    pickUpdDateController.dispose();
    // selectedPurchaseMode.dispose();
    selectedProductsNotifier.dispose();

    // client
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    clientAddressController.dispose();
    isClientSearchEnabledNotifier.dispose();

    // location
    locationStartController.dispose();
    locationFromController.dispose();
    locationToController.dispose();

    // amounts
    discountAmountController.dispose();
    securityAmountController.dispose();

    // time
    pickupTimeController.dispose();
    returnTimeController.dispose();

    // additional charges
    additionalChargesNotifier.dispose();
  }

  // --- Derived guards ---
  // bool get isPickupDateBeforeCurrentDate {
  //   final txt = pickUpdDateController.text;
  //   final dt = txt.isNullOrEmpty
  //       ? originalBooking?.pickupDate?.parseToDateTime()
  //       : txt.parseToDateTime();
  //   if (dt == null) return false;
  //   return dt.dateOnly.isBefore(DateTime.now().dateOnly);
  // }

  bool get isReturnDateBeforeCurrentDate {
    final txt = returnDateController.text;
    final dt = txt.isNullOrEmpty
        ? originalBooking?.returnDate.parseToDateTime()
        : txt.parseToDateTime();
    if (dt == null) return false;
    return dt.dateOnly.isBefore(DateTime.now().dateOnly);
  }

  // Initialize from an existing booking
  void setInitialValues({
    required BuildContext context,
    required BookingDetailsModel booking,
  }) {
    originalBooking = booking;

    descriptionController.text = booking.description ?? '';

    staffNameController.text = booking.staffName ?? 'Staff Name';

    additionalChargesNotifier.value = List<AdditionalChargesModel>.from(
      booking.additionalCharges,
    );

    // amounts
    discountAmountController.text = booking.discountAmount?.toString() ?? '';
    securityAmountController.text = booking.securityAmount?.toString() ?? '';

    // dates
    returnDateController.text = booking.returnDate.formatToUiDate();
    pickUpdDateController.text = booking.pickupDate?.formatToUiDate() ?? '';
    coolingPeriodDateController.text =
        booking.coolingPeriodDate?.formatToUiDate() ?? '';

    // products
    selectedProductsNotifier.value = booking.bookedItems
        .map(
          (productInfo) => ProductSelectedModel(
            variant: productInfo,
            amount: productInfo.amount,
            measurements: productInfo.measurements,
            quantity: productInfo.quantity,
          ),
        )
        .toList();

    // client
    context.read<ClientCubit>().selectClient(booking.client);
    clientNameController.text = booking.client.name;
    clientPhone1Controller.text = booking.client.phone1.toString();
    clientPhone2Controller.text = booking.client.phone2?.toString() ?? '';
    clientAddressController.text = booking.address ?? '';
    isClientSearchEnabledNotifier.value = true;

    // location
    locationStartController.text = booking.otherDetails.locationStart ?? '';
    locationFromController.text = booking.otherDetails.locationFrom ?? '';
    locationToController.text = booking.otherDetails.locationTo ?? '';

    // time
    pickupTime = booking.pickupDate?.parseToDateTime().toTimeOfDay ??
        const TimeOfDay(hour: 0, minute: 0);
    returnTime = booking.returnDate.parseToDateTime().toTimeOfDay;

    pickupTimeController.text = booking.pickupDate?.formatToUiTime() ?? '';
    returnTimeController.text = booking.returnDate.formatToUiTime();
  }

  // ---------- Helpers ----------
  bool isReturnAndPickupSameDay(DateTime pickupDate, DateTime returnDate) =>
      pickupDate.dateOnly.isSameDay(returnDate.dateOnly);

  bool validateTimeOnSameDay(
    BuildContext context, {
    DateTime? pickupDate,
    DateTime? returnDate,
  }) {
    // Enforce time constraints relative to current time when dates are today
    final pickDate = pickupDate ?? pickUpdDateController.text.parseToDateTime();
    final retDate = returnDate ?? returnDateController.text.parseToDateTime();

    // Same-day ordering between pickup and return (disallow equal)
    if (isReturnAndPickupSameDay(pickDate, retDate)) {
      if (pickupTime.hour > returnTime.hour ||
          (pickupTime.hour == returnTime.hour &&
              pickupTime.minute >= returnTime.minute)) {
        context.showSnackBar(
          'On the same day, return time must be after pickup time.',
          title: 'Time Error',
          isError: true,
        );
        return false;
      }
    }

    // Enforce return time after now when return date is today
    if (retDate.isSameDay(DateTime.now())) {
      if (returnTime.isBefore(TimeOfDay.now())) {
        context.showSnackBar(
          'Return time must be after current time',
          title: 'Time Error',
          isError: true,
        );
        return false;
      }
    }

    return true;
  }

  // pickup date function
  Future<void> selectPickupDate({
    required BuildContext context,
  }) async {
    final initial = originalBooking?.pickupDate?.parseToDateTime();
    final lastDate = returnDateController.text.parseToDateTime();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          pickUpdDateController.text.parseToDateTime().isBefore(DateTime.now())
              ? DateTime.now()
              : pickUpdDateController.text.parseToDateTime(),
      firstDate: DateTime.now(), // ✅ only today and future
      lastDate: lastDate.isBefore(DateTime.now().add(const Duration(days: 365)))
          ? DateTime.now().add(const Duration(days: 365))
          : lastDate,
    );

    if (picked != null) {
      if (validateTimeOnSameDay(context, pickupDate: picked)) {
        pickUpdDateController.text = picked.format();

        final currentReturn = returnDateController.text.parseToDateTime();
        if (currentReturn.isBefore(picked)) {
          final newReturn = picked.add(1.days());
          returnDateController.text = newReturn.format();

          if (coolingPeriodDateController.text.isNullOrEmpty) return;

          // Preserve existing cooling period offset from previous return date
          final oldCooling = coolingPeriodDateController.text.parseToDateTime();
          final offsetDays = currentReturn.difference(oldCooling).inDays.abs();
          coolingPeriodDateController.text =
              newReturn.add(offsetDays.days()).format();
        }
      }
    }
  }

  // return date function
  Future<void> selectReturnDate({
    required BuildContext context,
  }) async {
    final pickupDate = pickUpdDateController.text.parseToDateTime();
    final initialDate = returnDateController.text.parseToDateTime();

    final firstDate = pickupDate.isAfter(DateTime.now())
        ? pickupDate
        : DateTime.now(); // ✅ ensures no past dates

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && validateTimeOnSameDay(context, returnDate: picked)) {
      returnDateController.text = picked.format();

      if (coolingPeriodDateController.text.isNullOrEmpty) return;

      final coolingPeriodDays = initialDate
          .difference(coolingPeriodDateController.text.parseToDateTime())
          .inDays
          .abs();

      coolingPeriodDateController.text =
          picked.add(coolingPeriodDays.days()).format();
    }
  }

  Future<void> selectCoolingPeriodDate(BuildContext context) async {
    final firstDate = returnDateController.text.parseToDateTime();
    final initialDate = coolingPeriodDateController.text.isNullOrEmpty
        ? firstDate
        : coolingPeriodDateController.text.parseToDateTime();
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: firstDate.isAfter(initialDate) ? firstDate : initialDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      coolingPeriodDateController.text = picked.format();
    }
  }

  bool hasUnsavedChanges(BookingDetailsModel booking) {
    final isLocationChanged = isFieldChanged(
          booking.otherDetails.locationTo ?? '',
          locationToController.text,
        ) ||
        isFieldChanged(
          booking.otherDetails.locationFrom ?? '',
          locationFromController.text,
        ) ||
        isFieldChanged(
          booking.otherDetails.locationStart ?? '',
          locationStartController.text,
        );

    final oldPickupTime = booking.pickupDate?.parseToDateTime().toTimeOfDay;
    final oldReturnTime = booking.returnDate.parseToDateTime().toTimeOfDay;

    final pickupTime =
        pickupTimeController.text.to24HourTimeOfDayFrom12Format();
    final returnTime =
        returnTimeController.text.to24HourTimeOfDayFrom12Format();

    final isPickupTimeChanged = oldPickupTime != pickupTime;
    final isReturnTimeChanged = oldReturnTime != returnTime;

    final newClient = ClientRequestModel(
      id: booking.client.id,
      name: isFieldChanged(booking.client.name, clientNameController.text)
          ? clientNameController.text.trim()
          : null,
      phone1: booking.client.phone1.toString().hasNumberChangedComparedTo(
                clientPhone1Controller.text,
              )
          ? clientPhone1Controller.text.trim().toInt()
          : null,
      phone2: booking.client.phone2.toString().hasNumberChangedComparedTo(
                clientPhone2Controller.text,
              )
          ? clientPhone2Controller.text.trim().toIntOrNull()
          : null,
    );

    final isClientChanged = newClient.toJson().isNotEmpty;

    final isPickupDateChanged = isFieldChanged(
      booking.pickupDate?.formatToUiDate() ?? '',
      pickUpdDateController.text,
    );
    final isReturnDateChanged = isFieldChanged(
      booking.returnDate.formatToUiDate(),
      returnDateController.text,
    );

    final isDescriptionChanged = isFieldChanged(
      booking.description ?? '',
      descriptionController.text,
    );

    final isStaffNameChanged = isFieldChanged(
      booking.staffName ?? '',
      staffNameController.text,
    );

    final isClientAddressChanged = isFieldChanged(
      booking.address ?? '',
      clientAddressController.text,
    );

    // check amount changes
    final isSecurityAmountChanged = isFieldChanged(
      booking.securityAmount?.toString() ?? '0',
      securityAmountController.text.trim(),
    );
    final isDiscountAmountChanged = isFieldChanged(
      booking.discountAmount?.toString() ?? '0',
      discountAmountController.text.trim(),
    );

    final isProductsChanged = getChangedProductIds(
      oldIds: booking.bookedItems
          .map(
            (productInfo) => ProductSelectedModel(
              variant: productInfo,
              amount: productInfo.amount,
              measurements: productInfo.measurements,
              quantity: productInfo.quantity,
            ),
          )
          .toList(),
      newIds: selectedProductsNotifier.value,
    ).isNotEmpty;

    return isLocationChanged ||
        isPickupTimeChanged ||
        isReturnTimeChanged ||
        isClientChanged ||
        isPickupDateChanged ||
        isReturnDateChanged ||
        isDescriptionChanged ||
        isStaffNameChanged ||
        isClientAddressChanged ||
        isSecurityAmountChanged ||
        isProductsChanged ||
        isDiscountAmountChanged;
  }

  List<int> getChangedProductIds({
    required List<ProductSelectedModel> oldIds,
    required List<ProductSelectedModel> newIds,
  }) {
    String serialize(ProductSelectedModel e) {
      final sortedMeasurements = List<MeasurementValueModel>.from(
        e.measurements,
      )..sort((a, b) => a.key.compareTo(b.key));
      final measurementString = sortedMeasurements
          .map((entry) => '${entry.key}:${entry.value}')
          .join(',');

      return '${e.variant.id}|${e.amount}|${e.quantity}|$measurementString';
    }

    final oldMap = {for (final e in oldIds) serialize(e): e.variant.id};
    final newMap = {for (final e in newIds) serialize(e): e.variant.id};

    log('Old Map: $oldMap,\nNew Map: $newMap', name: 'ProductChanges');

    final changedKeys = {
      ...oldMap.keys.where((k) => !newMap.containsKey(k)),
      ...newMap.keys.where((k) => !oldMap.containsKey(k)),
    };

    final changedIds = changedKeys.map((k) => oldMap[k] ?? newMap[k]!).toSet();

    return changedIds.toList();
  }

  bool isFieldChanged(String oldValue, String newValue) =>
      oldValue.trim() != newValue.trim();
}
