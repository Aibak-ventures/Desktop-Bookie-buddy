part of '../pages/edit_new_booking_screen.dart';

extension EditBookingChangeDetector on EditNewBookingScreenState {
  // ---------------------------------------------------------------------------
  // Unsaved-changes guard
  // ---------------------------------------------------------------------------

  bool hasUnsavedChanges() {
    if (selectedProductsNotifier.value.isNotEmpty) return true;
    if (clientNameController.text.trim().isNotEmpty) return true;
    if (clientPhone1Controller.text.trim().isNotEmpty) return true;
    if (clientPhone2Controller.text.trim().isNotEmpty) return true;
    if (clientAddressController.text.trim().isNotEmpty) return true;
    if (advanceAmountController.text.trim().isNotEmpty) return true;
    if (securityAmountController.text.trim().isNotEmpty) return true;
    if (discountAmountController.text.trim().isNotEmpty) return true;
    if (additionalChargesNotifier.value.isNotEmpty) return true;
    if (documentsNotifier.value.isNotEmpty) return true;
    if (descriptionController.text.trim().isNotEmpty) return true;
    if (_hasRunningKmChanged()) return true;
    if (_hasDeliveryStatusChanged()) return true;
    return false;
  }

  // ---------------------------------------------------------------------------
  // Field-level change predicates (used by _buildPartialUpdateRequest)
  // ---------------------------------------------------------------------------

  bool _haveDatesChanged() {
    if (_originalBooking == null) return true;

    final currentPickupDate = pickupDate.format().appendTimeToDate(
      time: pickupTime,
    );
    final currentReturnDate = returnDate.format().appendTimeToDate(
      time: returnTime,
    );
    final _originalPickupDateStr = _originalPickupDate
        ?.format()
        .appendTimeToDate(time: _originalPickupTime);
    final _originalReturnDateStr = _originalReturnDate
        ?.format()
        .appendTimeToDate(time: _originalReturnTime);

    return currentPickupDate != _originalPickupDateStr ||
        currentReturnDate != _originalReturnDateStr;
  }

  bool _hasClientChanged() {
    if (_originalBooking == null) return true;

    final currentClientName = clientNameController.text.trim();
    final currentClientPhone1 = clientPhone1Controller.text.trim();
    final currentClientPhone2 = clientPhone2Controller.text.trim();
    final currentClientAddress = clientAddressController.text.trim();

    final currentPhone1E164 = currentClientPhone1.isNotEmpty
        ? toPhone1E164(currentClientPhone1)
        : null;
    final currentPhone2E164 = currentClientPhone2.isNotEmpty
        ? toPhone1E164(currentClientPhone2)
        : null;

    return currentClientName != (_originalClientName ?? '') ||
        currentClientPhone1 != (_originalClientPhone1 ?? '') ||
        (currentClientPhone2.isNotEmpty &&
            currentClientPhone2 != (_originalClientPhone2 ?? '')) ||
        currentPhone1E164 != __originalClientPhone1E164 ||
        currentPhone2E164 != __originalClientPhone2E164 ||
        currentClientAddress != (_originalClientAddress ?? '');
  }

  /// Reads directly from StaffSearchCubit to avoid listener-timing issues.
  bool _hasStaffChanged() {
    if (_originalBooking == null) return true;
    final currentStaffId = context
        .read<StaffSearchCubit>()
        .state
        .selectedStaff
        ?.id;
    return currentStaffId != _originalStaffId;
  }

  bool _haveAmountsChanged() {
    if (_originalBooking == null) return true;

    final currentSecurity =
        securityAmountController.text.trim().toIntOrNull() ?? 0;
    final discountInput =
        discountAmountController.text.trim().toIntOrNull() ?? 0;
    final productBase = _getDiscountProductBase();
    final currentDiscount = isDiscountPercentage && productBase > 0
        ? (productBase * discountInput / 100).round()
        : discountInput;

    return currentSecurity != (_originalSecurityAmount ?? 0) ||
        currentDiscount != (_originalDiscountAmount ?? 0);
  }

  bool _hasRunningKmChanged() {
    final currentKm = runningKilometersController.text.trim();
    return currentKm != (_originalRunningKm ?? '');
  }

  bool _hasDeliveryStatusChanged() {
    return deliveryStatus != _originalDeliveryStatus;
  }

  bool _haveAdditionalChargesChanged() {
    if (_originalBooking == null) return true;
    if (_originalAdditionalCharges == null) return true;

    final currentCharges = additionalChargesNotifier.value;
    if (currentCharges.length != _originalAdditionalCharges!.length) {
      return true;
    }

    for (int i = 0; i < currentCharges.length; i++) {
      final current = currentCharges[i];
      final original = _originalAdditionalCharges![i];
      if (current.name != original.name || current.amount != original.amount) {
        return true;
      }
    }

    return false;
  }
}
