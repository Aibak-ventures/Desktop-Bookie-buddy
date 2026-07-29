part of '../pages/edit_new_booking_screen.dart';

extension EditBookingSubmissionHandler on EditNewBookingScreenState {
  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  Future<void> _handleBackNavigation() async {
    if (hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true) {
        if (!mounted) return;
        if (widget.onClose != null) {
          widget.onClose!();
        } else {
          Navigator.of(context).pop();
        }
      }
    } else {
      if (widget.onClose != null) {
        widget.onClose!();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Save handler
  // ---------------------------------------------------------------------------

  void _handleSaveBooking() {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    final products = selectedProductsNotifier.value;
    if (products.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    // Validate paid amount doesn't exceed total payable
    {
      final paidAmount = advanceAmountController.text.trim().toIntOrNull() ?? 0;
      final totalPayable = PaymentCalculator.calculateBookingTotalPayable(
        selectedProducts: products,
        additionalCharges: additionalChargesNotifier.value,
        discountAmount: discountAmountController.text.trim().toIntOrNull() ?? 0,
        isDiscountPercentage: isDiscountPercentage,
        bookingType: selectedBookingType,
        effectiveRentalDays: _calculateRentalDays(),
      );
      if (paidAmount > totalPayable) {
        context.showSnackBar(
          'Paid amount ($paidAmount) cannot be greater than total payable amount ($totalPayable)',
          isError: true,
        );
        return;
      }
    }

    final isSaleType = selectedBookingType == BookingType.sales;
    final secAmt = securityAmountController.text.trim().toIntOrNull() ?? 0;
    if (!isSaleType && secAmt > 0 && selectedSecurityAccount == null) {
      context.showSnackBar(
        'Please select a payment option for security amount',
        isError: true,
      );
      return;
    }

    if (widget.bookingDetails != null) {
      final partialUpdate = _buildPartialUpdateRequest();

      final currentDocs = documentsNotifier.value;
      final originalDocPaths =
          _originalDocuments?.map((d) => d.path).toSet() ?? {};
      final currentDocPaths = currentDocs.map((d) => d.path).toSet();

      final removedUrls = originalDocPaths.difference(currentDocPaths).toList();
      final newDocs = currentDocs.where((d) => d.bytes != null).toList();

      log(
        '📄 Document changes - New: ${newDocs.length}, Removed: ${removedUrls.length}',
      );

      _editBookingCubit.updateBooking(
        widget.bookingDetails!.id,
        partialUpdate,
        newDocuments: newDocs.isNotEmpty ? newDocs : null,
        removedDocumentUrls: removedUrls.isNotEmpty ? removedUrls : null,
      );
    } else if (widget.saleDetails != null) {
      _editBookingCubit.updateSale(_buildSalesRequest());
    }
  }

  // ---------------------------------------------------------------------------
  // Request builders
  // ---------------------------------------------------------------------------

  /// Builds an incremental PATCH payload containing only fields that changed
  /// since the booking was loaded (compared against [_originalBooking] snapshot).
  Map<String, dynamic> _buildPartialUpdateRequest() {
    final updates = <String, dynamic>{};
    final hasCoolingSettingsChanged =
        coolingPeriodDays != _originalCoolingPeriodDays ||
        coolingPeriodMode != _originalCoolingPeriodMode;

    // Dates — sent only when changed or when cooling settings changed
    if (_haveDatesChanged()) {
      updates['pickup_date'] = pickupDate.format().appendPickupTime(pickupTime);
      updates['return_date'] = returnDate.format().appendReturnTime(returnTime);
      if (pickupTime != null)
        updates['pickup_time'] = pickupTime!.formatToTime();
      if (returnTime != null)
        updates['return_time'] = returnTime!.formatToTime();
      _appendCoolingPeriodFields(updates);
    } else if (hasCoolingSettingsChanged) {
      // Cooling period changed but dates didn't — still send return_date + cooling fields
      updates['return_date'] = returnDate.format().appendReturnTime(returnTime);
      if (pickupTime != null)
        updates['pickup_time'] = pickupTime!.formatToTime();
      if (returnTime != null)
        updates['return_time'] = returnTime!.formatToTime();
      _appendCoolingPeriodFields(updates);
    }

    // Client — sent only when any client field changed
    if (_hasClientChanged()) {
      final phone1Str = clientPhone1Controller.text.trim();
      final phone2Str = clientPhone2Controller.text.trim();
      final phone1E164 = phone1Str.isEmpty ? null : toPhone1E164(phone1Str);
      final phone2E164 = phone2Str.isEmpty ? null : toPhone1E164(phone2Str);
      final clientName = clientNameController.text.trim().nullIfEmpty;

      final clientData = <String, dynamic>{
        'client_name': clientName,
        if (phone1E164 != null) 'phone_1_e164': phone1E164,
        if (phone2E164 != null) 'phone_2_e164': phone2E164,
      };
      if (selectedClientId != null) {
        clientData['id'] = selectedClientId;
      }
      updates['client'] = clientData;
      updates['client_address'] = clientAddressController.text.trim();
    }

    // Staff — read directly from cubit to avoid listener-timing issues
    if (_hasStaffChanged()) {
      updates['staff_id'] = context
          .read<StaffSearchCubit>()
          .state
          .selectedStaff
          ?.id;
    }

    // Amounts
    if (_haveAmountsChanged()) {
      updates['security_amount'] = securityAmountController.text
          .trim()
          .toIntOrNull();
      final discountInput =
          discountAmountController.text.trim().toIntOrNull() ?? 0;
      final productBase = _getDiscountProductBase();
      updates['discount_amount'] = isDiscountPercentage && productBase > 0
          ? (productBase * discountInput / 100).round()
          : discountInput;
    }
    final secAmt = securityAmountController.text.trim().toIntOrNull();
    if (secAmt != null && secAmt > 0 && selectedSecurityAccount?.id != null) {
      updates['security_account_id'] = selectedSecurityAccount!.id;
    }

    // Products — always included so the server stays in sync.
    // Prefer variantId (actual product variant) over id (booked-item row id).
    {
      final products = selectedProductsNotifier.value;
      final runningKm = runningKilometersController.text.trim();
      updates['variants'] = products.map((p) {
        final variantId = p.variant.variantId ?? p.variant.id;
        final effectiveRentalDays =
            PaymentCalculator.getDaysMultiplierForProduct(
              product: p,
              bookingType: selectedBookingType,
              effectiveRentalDays: _calculateRentalDays(),
            );

        final lineAmount = (p.amount * p.quantity) * effectiveRentalDays;
        final variantData = <String, dynamic>{
          'id': variantId,
          'quantity': p.quantity,
          'amount': lineAmount,
        };
        final measurementMap = <String, dynamic>{};
        for (final m in p.measurements) {
          if (m.key != 'running_kilometers') {
            measurementMap[m.key] = m.value;
          }
        }
        if (runningKm.isNotEmpty) {
          measurementMap['running_kilometers'] = runningKm;
        }
        if (measurementMap.isNotEmpty) {
          variantData['measurements'] = measurementMap;
        }
        return variantData;
      }).toList();
    }

    // Additional charges
    if (_haveAdditionalChargesChanged()) {
      final charges = additionalChargesNotifier.value;
      updates['additional_charges'] = charges.map((c) {
        final chargeData = <String, dynamic>{
          'name': c.name,
          'amount': c.amount,
        };
        if (c.id != null) chargeData['id'] = c.id;
        return chargeData;
      }).toList();
    }

    updates['purchase_mode'] = 'normal';

    if (_hasDeliveryStatusChanged()) {
      updates['delivery_status'] = deliveryStatus.toValue();
    }

    final description = descriptionController.text.trim();
    if (description.isNotEmpty) {
      updates['description'] = description;
    }

    return updates;
  }

  /// Appends cooling-period fields into [updates] based on current mode/days.
  /// Extracted to avoid duplicating this logic between the date-changed and
  /// cooling-only-changed branches of [_buildPartialUpdateRequest].
  void _appendCoolingPeriodFields(Map<String, dynamic> updates) {
    if (coolingPeriodDays >= 0) {
      final boundaryDate = coolingPeriodMode.isAfter
          ? returnDate.add(Duration(days: coolingPeriodDays))
          : pickupDate.subtract(Duration(days: coolingPeriodDays));
      updates['cooling_period_end'] = boundaryDate.format().appendTimeToDate(
        time24HourAsString: coolingPeriodMode.coolingBoundaryTime,
      );
      updates['cooling_period_type'] = coolingPeriodMode.value;
    }
  }

  SalesRequestEntity _buildSalesRequest() {
    final products = selectedProductsNotifier.value;
    final clientPhone = clientPhone1Controller.text.trim();

    return SalesRequestEntity(
      id: widget.saleDetails?.id,
      staffId: selectedStaffId,
      clientPhone: clientPhone.isEmpty ? null : clientPhone,
      address: clientAddressController.text.trim().isEmpty
          ? null
          : clientAddressController.text.trim(),
      saleDate: pickupDate.format(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      sendPdfToWhatsApp: sendPdfToWhatsApp,
      products: products,
      paidAmount: advanceAmountController.text.trim().toIntOrNull() ?? 0,
      discountAmount: discountAmountController.text.trim().toIntOrNull() ?? 0,
      stockCountDecrease: false,
    );
  }

  // ---------------------------------------------------------------------------
  // Error formatting
  // ---------------------------------------------------------------------------

  String _formatBookingError(String rawError) {
    final insufficientStockRegex = RegExp(
      r'Insufficient stock for "(.+?)"\s*\((.+?)\)"\. Not available from (.+?) to (.+?)\.',
      caseSensitive: false,
    );
    final match = insufficientStockRegex.firstMatch(rawError);
    if (match != null) {
      final productName = match.group(1)?.trim() ?? 'product';
      final attribute = match.group(2)?.trim() ?? '';
      final fromDate = match.group(3)?.trim() ?? '';
      final toDate = match.group(4)?.trim() ?? '';
      final fullProductName = attribute.isNotEmpty
          ? '"$productName ($attribute)"'
          : '"$productName"';
      return 'Not enough stock for $fullProductName. Not available from $fromDate to $toDate.';
    }

    final simpleInsufficientRegex = RegExp(
      r'Insufficient stock for "(.+?)"',
      caseSensitive: false,
    );
    final simpleMatch = simpleInsufficientRegex.firstMatch(rawError);
    if (simpleMatch != null) {
      final productName = simpleMatch.group(1)?.trim() ?? 'product';
      return 'Not enough stock for "$productName". Please remove it from the booking or reduce the quantity.';
    }

    return rawError.replaceFirst(
      RegExp(r'^Exception:\s*', caseSensitive: false),
      '',
    );
  }
}
