import 'dart:developer';

import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/booking_other_details_model/booking_other_details_model.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
// import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/dialogs/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBookingButton extends StatelessWidget {
  const EditBookingButton({
    super.key,
    required this.formController,
    required this.booking,
  });

  final EditBookingFormStateController formController;
  final BookingDetailsModel booking;

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocConsumer<UpdateBookingCubit, UpdateBookingState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (error) => context.showSnackBar(error, isError: true),
            failure: (error) {
              final stockBetween =
                  error['out_of_stock_between'] as Map<String, dynamic>?;

              if (stockBetween == null ||
                  stockBetween['from'] == null ||
                  stockBetween['to'] == null) {
                context.showSnackBar(
                  error['message'] ?? 'Failed to update booking',
                  isError: true,
                );
                return;
              }
              showUnavailableProductsDialog(
                context: context,
                unavailableDateFrom: stockBetween['from'],
                unavailableDateTo: stockBetween['to'],
                unavailableProducts: [error['variant_id']],
                selectedProductsNotifier:
                    formController.selectedProductsNotifier,
              );
            },
            success: () {
              context
                ..pop()
                ..showSnackBar('Booking Updated Successfully');
              context.read<BookingDetailsBloc>().add(
                    BookingDetailsEvent.fetchBookingDetails(booking.id),
                  );
              context.read<BookingSelectionCubit>().markModified(
                    shouldRefresh: true,
                  );
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
              if (formController.formKey.currentState?.validate() != true)
                return;

              final selectedStaff =
                  context.read<StaffSearchCubit>().state.selectedStaff;
              if (booking.staffId != null && selectedStaff == null) {
                context.showSnackBar(
                  'Please select a staff member',
                  isError: true,
                  title: 'Staff Required',
                );
                return;
              }

              final isExistingClient =
                  formController.isClientSearchEnabledNotifier.value;
              final selectedClient =
                  context.read<ClientCubit>().state.selectedClient;

              if (selectedClient == null && isExistingClient) {
                context.showSnackBar(
                  'Please select a client',
                  isError: true,
                  title: 'Client Required',
                );
                return;
              }

              // check product changes
              if (formController.selectedProductsNotifier.value.isEmpty) {
                context.showSnackBar(
                  'Select at least one product',
                  isError: true,
                  title: 'No Products',
                );
                return;
              }

              final oldItems = booking.bookedItems
                  .map(
                    (e) => ProductSelectedModel(
                      variant: e,
                      amount: e.amount,
                      quantity: e.quantity,
                      measurements: e.measurements,
                    ),
                  )
                  .toList();

              final newItems = formController.selectedProductsNotifier.value;

              final additionalChargesTotal = formController
                  .additionalChargesNotifier.value
                  .fold(0, (pv, e) => pv + (e.amount ?? 0));

              final newTotalAmount =
                  newItems.fold(0, (pv, e) => pv + e.amount) +
                      additionalChargesTotal;

              if (newTotalAmount <= 0) {
                context.showSnackBar(
                  'Total amount cannot be 0 or less',
                  isError: true,
                  title: 'Invalid Amount',
                );
                return;
              }

              if (newTotalAmount < booking.actualPaidAmount) {
                context.showSnackBar(
                  'Total amount cannot be less than paid amount ${booking.actualPaidAmount}',
                  isError: true,
                  title: 'Invalid Amount',
                );
                return;
              }

              final rawMaxValue = newTotalAmount - booking.actualPaidAmount;
              final maxValue = rawMaxValue >= 0 ? rawMaxValue : 0;
              if ((formController.discountAmountController.text.toIntOrNull() ??
                      0) >
                  maxValue) {
                context.showSnackBar(
                  'Discount amount cannot be greater than $maxValue',
                  isError: true,
                  title: 'Invalid Discount',
                );
                return;
              }
              debugPrint(
                'pickup date: ${formController.pickUpdDateController.text} : ${booking.pickupDate?.formatToUiDate()}, return date: ${formController.returnDateController.text} : ${booking.returnDate.formatToUiDate()}',
              );

              // check locations
              final isLocationChanged = isFieldChanged(
                    booking.otherDetails.locationTo ?? '',
                    formController.locationToController.text,
                  ) ||
                  isFieldChanged(
                    booking.otherDetails.locationFrom ?? '',
                    formController.locationFromController.text,
                  ) ||
                  isFieldChanged(
                    booking.otherDetails.locationStart ?? '',
                    formController.locationStartController.text,
                  );

              // check pickup and return time
              final oldPickupTime =
                  booking.pickupDate?.parseToDateTime().toTimeOfDay;
              final oldReturnTime =
                  booking.returnDate.parseToDateTime().toTimeOfDay;

              final pickupTime = formController.pickupTimeController.text
                  .to24HourTimeOfDayFrom12Format();
              final returnTime = formController.returnTimeController.text
                  .to24HourTimeOfDayFrom12Format();

              final isPickupTimeChanged = oldPickupTime != pickupTime;
              final isReturnTimeChanged = oldReturnTime != returnTime;

              // log(
              //   'pickupTimeController: ${formController.pickupTimeController.text}, returnTimeController: ${formController.returnTimeController.text}',
              // );

              // log(
              //   'oldPickupTime: $oldPickupTime, newPickupTime: $pickupTime, oldReturnTime: $oldReturnTime, newReturnTime: $returnTime',
              // );

              // check client phone
              if (formController.clientPhone1Controller.text
                      .trim()
                      .toIntOrNull() ==
                  null) {
                context.showSnackBar(
                  'Enter a valid phone number',
                  isError: true,
                  title: 'Invalid Phone Number',
                );
                return;
              }

              // check client changes
              bool isClientChanged = false;
              if (isExistingClient) {
                isClientChanged = selectedClient!.id != booking.client.id;
              } else {
                isClientChanged = formController.clientNameController.text
                            .trim() !=
                        booking.client.name ||
                    formController.clientPhone1Controller.text.trim() !=
                        booking.client.phone1.toString() ||
                    (formController.clientPhone2Controller.text
                                .trim()
                                .isNotEmpty
                            ? formController.clientPhone2Controller.text.trim()
                            : null) !=
                        booking.client.phone2?.toString();
              }
              final newClient = ClientRequestModel(
                id: isExistingClient ? selectedClient!.id : null,
                name: formController.clientNameController.text.trim(),
                phone1: formController.clientPhone1Controller.text
                    .trim()
                    .toIntOrNull(),
                phone2:
                    formController.clientPhone2Controller.text.trim().isNotEmpty
                        ? formController.clientPhone2Controller.text
                            .trim()
                            .toIntOrNull()
                        : null,
              );

              debugPrint(
                'isDateChanged: ${booking.bookedDate}, ${booking.pickupDate} : ${formController.pickUpdDateController.text}, return date: ${booking.returnDate} : ${formController.returnDateController.text}',
              );

              // check date changes
              final isPickupDateChanged = isFieldChanged(
                booking.pickupDate?.formatToUiDate() ?? '',
                formController.pickUpdDateController.text,
              );
              final isReturnDateChanged = isFieldChanged(
                booking.returnDate.formatToUiDate(),
                formController.returnDateController.text,
              );
              final isCoolingPeriodDateChanged = isFieldChanged(
                booking.coolingPeriodDate?.formatToUiDate() ?? '',
                formController.coolingPeriodDateController.text,
              );

              // check amount changes
              final securityAmount = isFieldChanged(
                booking.securityAmount?.toString() ?? '0',
                formController.securityAmountController.text.trim(),
              )
                  ? formController.securityAmountController.text
                      .trim()
                      .toIntOrNull()
                  : null;
              final discountAmount = isFieldChanged(
                booking.discountAmount?.toString() ?? '0',
                formController.discountAmountController.text.trim(),
              )
                  ? formController.discountAmountController.text
                      .trim()
                      .toIntOrNull()
                  : null;

              final isStaffChanged = booking.staffId != selectedStaff?.id;

              final changedProduct = formController.getChangedProductIds(
                oldIds: oldItems,
                newIds: newItems,
              );

              final requestModel = RequestBookingModel(
                clientId: isExistingClient && isClientChanged
                    ? selectedClient!.id
                    : null,
                staffId: isStaffChanged ? selectedStaff?.id : null,
                address: isFieldChanged(
                  booking.address ?? '',
                  formController.clientAddressController.text,
                )
                    ? formController.clientAddressController.text.trim()
                    : null,
                pickupDate: isPickupDateChanged || isPickupTimeChanged
                    ? '${formController.pickUpdDateController.text}T${pickupTime.formatToTime(addSeconds: true)}'
                    : null,
                returnDate: isReturnDateChanged || isReturnTimeChanged
                    ? '${formController.returnDateController.text}T${returnTime.formatToTime(addSeconds: true)}'
                    : null,
                coolingPeriodDate: isCoolingPeriodDateChanged
                    ? '${formController.coolingPeriodDateController.text}T23:59:59'
                    : null,
                securityAmount: securityAmount,
                discountAmount: discountAmount,
                description: isFieldChanged(
                  booking.description ?? '',
                  formController.descriptionController.text,
                )
                    ? formController.descriptionController.text.trim()
                    : null,
                otherDetails: isLocationChanged
                    ? BookingOtherDetailsModel(
                        locationStart:
                            formController.locationStartController.text.trim(),
                        locationFrom:
                            formController.locationFromController.text.trim(),
                        locationTo:
                            formController.locationToController.text.trim(),
                      )
                    : null,
                products: changedProduct.isNotEmpty
                    ? formController.selectedProductsNotifier.value
                    : null,
                additionalCharges: getAdditionalChargesIfChanged(
                  oldCharges: booking.additionalCharges,
                  newCharges: formController.additionalChargesNotifier.value,
                ),
              );
              log(
                'updated data: ${requestModel.toJson()}, client: $newClient, isClientChanged: $isClientChanged',
              );

              if (!isStaffChanged &&
                  !requestModel.hasChanges &&
                  !isClientChanged) {
                context
                  ..pop()
                  ..showSnackBar('Nothing to update');
                return;
              }
              context.read<UpdateBookingCubit>().updateBooking(
                    bookingId: booking.id,
                    updatedBooking: requestModel,
                    client: isClientChanged ? newClient : null,
                  );
            },
            text: 'Save Changes',
          );
        },
      );

  List<AdditionalChargesModel>? getAdditionalChargesIfChanged({
    required List<AdditionalChargesModel> oldCharges,
    required List<AdditionalChargesModel> newCharges,
  }) {
    // Convert to set of "id-amount" strings to compare by specific fields
    final oldSet = oldCharges
        .map(
          (e) => e.id != null
              ? '${e.id}-${e.name}-${e.amount}'
              : 'new-${e.name}-${e.amount}',
        )
        .toSet();
    final newSet = newCharges
        .map(
          (e) => e.id != null
              ? '${e.id}-${e.name}-${e.amount}'
              : 'new-${e.name}-${e.amount}',
        )
        .toSet();

    final changed = [
      ...oldSet.difference(newSet),
      ...newSet.difference(oldSet),
    ];

    log(
      'oldSet: $oldSet\nnewSet: $newSet\nchanged: $changed',
      name: 'AdditionalCharges',
    );

    return changed.isEmpty ? null : newCharges;
  }

  bool isFieldChanged(String oldValue, String newValue) =>
      oldValue.trim() != newValue.trim();
}
