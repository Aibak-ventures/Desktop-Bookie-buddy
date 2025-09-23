import 'dart:developer';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBookingButton extends StatelessWidget {
  const EditBookingButton({
    super.key,
    required this.selectedProductsNotifier,
    required this.booking,
    required GlobalKey<FormState> formKey,
    required this.pickUpdDateController,
    required this.returnDateController,
    required this.descriptionController,
    required this.staffNameController,
    required this.selectedPurchaseMode,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    required this.locationStartController,
    required this.locationFromController,
    required this.locationToController,
    required this.pickupTimeController,
    required this.returnTimeController,
  }) : _formKey = formKey;

  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final BookingDetailsModel booking;
  final GlobalKey<FormState> _formKey;
  final TextEditingController pickUpdDateController;
  final TextEditingController returnDateController;
  final TextEditingController descriptionController;
  final TextEditingController staffNameController;
  final ValueNotifier<PurchaseMode> selectedPurchaseMode;

//
  // client details controller
  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;

  //locating
  final TextEditingController locationStartController;
  final TextEditingController locationFromController;
  final TextEditingController locationToController;

  //times
  final TextEditingController pickupTimeController;
  final TextEditingController returnTimeController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateBookingCubit, UpdateBookingState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error) => context.showSnackBar(
            error,
            isError: true,
          ),
          failure: (error) {
            showUnavailableProductsDialog(
              context: context,
              unavailableDate: error["out_of_stock_date"],
              unavailableProducts: [error["variant_id"]],
              selectedProductsNotifier: selectedProductsNotifier,
            );
          },
          success: () {
            context.pop();
            context.showSnackBar('Booking Updated Successfully');
            context.read<BookingDetailsBloc>().add(
                  BookingDetailsEvent.fetchBookingDetails(
                    booking.id,
                  ),
                );
            context
                .read<BookingSelectionCubit>()
                .markModified(shouldRefresh: true);
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          orElse: () => false,
          submitting: () => true,
        );

        return CustomElevatedButton(
          isLoading: isLoading,
          width: double.infinity,
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              if (selectedProductsNotifier.value.isEmpty) {
                CustomSnackBar(message: 'Please select at least one product');
                return;
              }

              final oldItems = booking.bookedItems
                  .map(
                    (e) => ProductSelectedModel(
                      variant: e,
                      amount: e.amount,
                      quantity: e.quantity,
                    ),
                  )
                  .toList();

              final newItems = selectedProductsNotifier.value;

              final changedProduct = getChangedProductIds(
                oldIds: oldItems,
                newIds: newItems,
              );

              final newTotalAmount = newItems.fold(
                0,
                (previousValue, element) => previousValue + element.amount,
              );

              if (newTotalAmount <= 0) {
                context.showSnackBar(
                  'Total amount cannot be 0 or less',
                  isError: true,
                );
                return;
              }

              if (newTotalAmount < booking.paidAmount) {
                context.showSnackBar(
                  'Total amount cannot be less than paid amount ${booking.paidAmount}',
                  isError: true,
                );
                return;
              }

              print(
                  'pickup date: ${pickUpdDateController.text} : ${booking.pickupDate?.formatToUiDate()}, return date: ${returnDateController.text} : ${booking.returnDate.formatToUiDate()}');

              final isLocationChanged = isFieldChanged(
                    booking.otherDetails['location_to'] ?? '',
                    locationToController.text,
                  ) ||
                  isFieldChanged(
                    booking.otherDetails['location_from'] ?? '',
                    locationFromController.text,
                  ) ||
                  isFieldChanged(
                    booking.otherDetails['location_start'] ?? '',
                    locationStartController.text,
                  );

              final oldPickupTime =
                  booking.pickupDate?.parseToDateTime().toTimeOfDay;
              final oldReturnTime =
                  booking.returnDate.parseToDateTime().toTimeOfDay;

              final pickupTime =
                  pickupTimeController.text.to24HourTimeOfDayFrom12Format();
              final returnTime =
                  returnTimeController.text.to24HourTimeOfDayFrom12Format();

              final isPickupTimeChanged = oldPickupTime != pickupTime;
              final isReturnTimeChanged = oldReturnTime != returnTime;

              log('pickupTimeController: ${pickupTimeController.text}, returnTimeController: ${returnTimeController.text}');

              log('oldPickupTime: $oldPickupTime, newPickupTime: $pickupTime, oldReturnTime: $oldReturnTime, newReturnTime: $returnTime');

              // final clientData = buildClientData(booking);
              if (clientPhone1Controller.text.trim().toIntOrNull() == null) {
                context.showSnackBar(
                  'Please enter valid phone numbers',
                  isError: true,
                );
                return;
              }
              final newClient = ClientRequestModel(
                id: booking.client.id,
                name: isFieldChanged(
                        booking.client.name, clientNameController.text)
                    ? clientNameController.text.trim()
                    : null,
                phone1: booking.client.phone1
                        .toString()
                        .hasNumberChangedComparedTo(clientPhone1Controller.text)
                    ? clientPhone1Controller.text.trim().toInt()
                    : null,
                phone2: booking.client.phone2
                        .toString()
                        .hasNumberChangedComparedTo(clientPhone2Controller.text)
                    ? clientPhone2Controller.text.trim().toIntOrNull()
                    : null,
              );

              final isClientChanged = newClient.toJson().isNotEmpty;

              print(
                  'isDateChanged: ${booking.bookedDate}, ${booking.pickupDate} : ${pickUpdDateController.text}, return date: ${booking.returnDate} : ${returnDateController.text}');
              final isPickupDateChanged = isFieldChanged(
                booking.pickupDate?.formatToUiDate() ?? '',
                pickUpdDateController.text,
              );
              final isReturnDateChanged = isFieldChanged(
                booking.returnDate.formatToUiDate(),
                returnDateController.text,
              );

              final updatedData = {
                // if (!isClientEquals && clientData.isNotEmpty)
                //   "client": clientData,
                if (isPickupDateChanged || isPickupTimeChanged)
                  "pickup_date":
                      '${pickUpdDateController.text}T${pickupTime.formatToTime(addSeconds: true)}',
                if (isReturnDateChanged || isReturnTimeChanged)
                  "return_date":
                      '${returnDateController.text}T${returnTime.formatToTime(addSeconds: true)}',
                if (booking.purchaseMode != selectedPurchaseMode.value)
                  "purchase_mode": selectedPurchaseMode.value.toValue(),
                if (isFieldChanged(booking.staffName, staffNameController.text))
                  "staff_name": staffNameController.text.trim(),
                if (isFieldChanged(
                    booking.description ?? '', descriptionController.text))
                  "description": descriptionController.text.trim(),
                if (isFieldChanged(
                    booking.address ?? '', clientAddressController.text))
                  'client_address': clientAddressController.text.trim(),
                if (isLocationChanged)
                  "details": {
                    "location_start": locationStartController.text.trim(),
                    "location_from": locationFromController.text.trim(),
                    "location_to": locationToController.text.trim(),
                  },
                if (changedProduct.isNotEmpty)
                  "variants": selectedProductsNotifier.value
                      .map(
                        (product) => product.toCustomJson(),
                      )
                      .toList(),
              };

              log('updated data: $updatedData');
              if (updatedData.isEmpty && !isClientChanged) {
                context.pop();
                context.showSnackBar(
                  'Nothing to update',
                );
                return;
              }
              //!TODO: uncomment this
              context.read<UpdateBookingCubit>().updateBooking(
                    bookingId: booking.id,
                    updatedData: updatedData,
                    client: isClientChanged ? newClient : null,
                  );
            }
          },
          text: 'Save Changes',
        );
      },
    );
  }

  Map<String, dynamic> buildClientData(BookingDetailsModel booking) {
    final Map<String, dynamic> clientData = {};

    if (isFieldChanged(booking.client.name, clientNameController.text)) {
      clientData['client_name'] = clientNameController.text.trim();
    }

    if (booking.client.phone1
        .toString()
        .hasNumberChangedComparedTo(clientPhone1Controller.text)) {
      clientData['client_phone_1'] = clientPhone1Controller.text.trim().toInt();
    }

    if (booking.client.phone2
        .toString()
        .hasNumberChangedComparedTo(clientPhone2Controller.text)) {
      clientData['client_phone_2'] = clientPhone2Controller.text.trim().toInt();
    }

    return clientData;
  }

  List<int> getChangedProductIds({
    required List<ProductSelectedModel> oldIds,
    required List<ProductSelectedModel> newIds,
  }) {
    // Convert to set of "id-amount" strings to compare by specific fields
    final oldSet = oldIds
        .map((e) =>
            '${e.variant.id}-${e.amount}-${e.quantity}-${e.measurements.map((m) => m.key).join('-')}-${e.measurements.map(
              (m) => m.value,
            )}')
        .toSet();
    final newSet = newIds
        .map((e) =>
            '${e.variant.id}-${e.amount}-${e.quantity}-${e.measurements.map((m) => m.key).join('-')}-${e.measurements.map(
              (m) => m.value,
            )}')
        .toSet();

    final changed = [
      ...oldSet.difference(newSet),
      ...newSet.difference(oldSet),
    ];

    // Extract IDs from changed items
    final changedIds = changed.map((e) => int.parse(e.split('-')[0])).toSet();

    return changedIds.toList();
  }

  bool isFieldChanged(String oldValue, String newValue) {
    return oldValue.trim() != newValue.trim();
  }
}
