part of '../pages/edit_new_booking_screen.dart';

extension EditBookingInitializer on EditNewBookingScreenState {
  // ---------------------------------------------------------------------------
  // Booking initialization
  // ---------------------------------------------------------------------------

  void _initializeFromBooking(BookingDetailsEntity booking) {
    selectedBookingType = BookingType.booking;

    // Set dates
    if (booking.pickupDate != null) {
      pickupDate = booking.pickupDate!.parseToDateTime();
    } else {
      // When pickupDate is null from the API, estimate from returnDate - 1 day
      // so _calculateRentalDays() and date pickers show reasonable values
      // instead of defaulting to DateTime.now().
      log(
        '⚠️ booking.pickupDate is null — estimating pickupDate from returnDate',
      );
      pickupDate = booking.returnDate.parseToDateTime().subtract(
        const Duration(days: 1),
      );
    }
    returnDate = booking.returnDate.parseToDateTime();

    // Only show time if explicitly provided in dedicated fields
    // Don't extract from date string - if pickup_time is null, show empty
    if (booking.pickupTime != null && booking.pickupTime!.isNotEmpty) {
      pickupTime = _extractExplicitTime(booking.pickupTime);
    } else {
      pickupTime = null;
    }

    if (booking.returnTime != null && booking.returnTime!.isNotEmpty) {
      returnTime = _extractExplicitTime(booking.returnTime);
    } else {
      returnTime = null;
    }

    if (booking.coolingPeriodDate != null) {
      coolingPeriodDate = booking.coolingPeriodDate!.parseToDateTime();
      final coolingDate = booking.coolingPeriodDate!.parseToDateTime();
      // Use booking's cooling period type if available, otherwise use shop settings
      final CoolingPeriodMode coolingPeriodMode;
      if (booking.coolingPeriodType != null) {
        coolingPeriodMode = booking.coolingPeriodType!;
      } else {
        // Fall back to shop settings
        coolingPeriodMode =
            context.read<UserCubit>().state?.shopSettings.coolingPeriodMode ??
            CoolingPeriodMode.after;
      }
      coolingPeriodDays = BookingDateCalculator.coolingPeriodDaysFromDate(
        pickupDate: pickupDate,
        returnDate: returnDate,
        coolingDate: coolingDate,
        mode: coolingPeriodMode,
      );
      log(
        '🔧 Cooling period: $coolingPeriodDays days (mode: ${coolingPeriodMode.value}, Return: $returnDate, Cooling: $coolingDate)',
      );
    } else {
      coolingPeriodDays = 0;
      coolingPeriodDate = null;
    }

    // Set client details
    clientNameController.text = booking.client.name;
    // phone1/phone2 are non-nullable ints in ClientEntity but the API may return null,
    // in which case the entity defaults to 0. Check > 0 before trusting the raw int,
    // and fall back to extracting from the E.164 string.
    BookingPhonePopulator.setPhoneFieldValue(
      _clientPhone1FieldController,
      clientPhone1Controller,
      phoneNumber: booking.client.phone1 > 0
          ? booking.client.phone1.toString()
          : null,
      e164: booking.client.phone1E164,
    );
    BookingPhonePopulator.setPhoneFieldValue(
      _clientPhone2FieldController,
      clientPhone2Controller,
      phoneNumber: (booking.client.phone2 ?? 0) > 0
          ? booking.client.phone2.toString()
          : null,
      e164: booking.client.phone2E164,
    );
    if (booking.address != null) {
      clientAddressController.text = booking.address!;
    }
    selectedClientId = booking.client.id;

    // Set staff details
    if (booking.staffName != null) {
      staffNameController.text = booking.staffName!;
    }
    if (booking.staffId != null) {
      selectedStaffId = booking.staffId;
    }

    // Set payment details
    advanceAmountController.text = booking.paidAmount.toString();
    if (booking.securityAmount != null && booking.securityAmount! > 0) {
      securityAmountController.text = booking.securityAmount.toString();
    }
    isSecurityPaid = booking.isSecurityPaid;
    // selectedSecurityAccount is auto-selected via initialAccountId in AccountSelectionField
    if (booking.discountAmount != null && booking.discountAmount! > 0) {
      discountAmountController.text = booking.discountAmount.toString();
    }
    deliveryStatus = booking.deliveryStatus;
    bookingStatus = booking.bookingStatus;
    bookingCompletedDate = booking.bookingCompletedDate;

    // Set description
    if (booking.description != null) {
      descriptionController.text = booking.description!;
    }

    // Set other details (locations & running kilometers)
    if (booking.otherDetails.locationStart != null) {
      startLocationController.text = booking.otherDetails.locationStart!;
    }
    if (booking.otherDetails.locationFrom != null) {
      pickupLocationController.text = booking.otherDetails.locationFrom!;
    }
    if (booking.otherDetails.locationTo != null) {
      destinationLocationController.text = booking.otherDetails.locationTo!;
    }
    // running_kilometers: read from vehicle product measurements (new format)
    // or fall back to otherDetails.end (old format).
    String? runningKmValue;
    outer:
    for (final item in booking.bookedItems) {
      if (item.mainServiceType?.isVehicle ?? false) {
        for (final m in item.measurements) {
          if (m.key == 'running_kilometers') {
            runningKmValue = m.value;
            break outer;
          }
        }
      }
    }
    runningKmValue ??= booking.otherDetails.end;
    if (runningKmValue != null && runningKmValue.isNotEmpty) {
      runningKilometersController.text = runningKmValue;
    }

    // Store original delivery status
    deliveryStatus = booking.deliveryStatus;

    // Set products
    log('🔧 Loading ${booking.bookedItems.length} products from booking');
    // Use the booking entity's dates directly for product mapping so the
    // per-item price reconstruction is correct even when screen-state dates
    // are not yet initialized (e.g. booking.pickupDate is null from API).
    final entityRentalDays = _computeRentalDaysFromBookingEntity(booking);
    final products = ProductMapper.fromBookedItems(
      booking.bookedItems,
      rentalDays: entityRentalDays,
    );
    log(
      '✅ Loaded ${products.length} products. Products with measurements: ${products.where((p) => p.measurements.isNotEmpty).length}',
    );
    selectedProductsNotifier.value = products;

    // Set additional charges
    additionalChargesNotifier.value = booking.additionalCharges;

    // Load existing documents for preview
    log(
      '📄 Loading documents from booking. Total documents: ${booking.documents.length}',
    );
    if (booking.documents.isNotEmpty) {
      final docs = booking.documents
          .map((doc) {
            if (doc is Map<String, dynamic>) {
              final url = doc['url'] ?? doc['file'] ?? '';
              final name = doc['name'] ?? _extractFilenameFromUrl(url);
              return DocumentFileEntity(name: name, path: url);
            } else if (doc is String) {
              final filename = _extractFilenameFromUrl(doc);
              return DocumentFileEntity(name: filename, path: doc);
            }
            return null;
          })
          .whereType<DocumentFileEntity>()
          .toList();
      log('✅ Loaded ${docs.length} documents for preview');
      documentsNotifier.value = docs;
    } else {
      log('ℹ️ No documents found in booking');
    }

    // Store original values for change tracking (incremental updates).
    // CRITICAL: must run after all notifiers and controllers are populated above.
    _storeOriginalValues(booking);
  }

  // ---------------------------------------------------------------------------
  // Sale initialization
  // ---------------------------------------------------------------------------

  void _initializeFromSale(SaleDetailsEntity sale) {
    selectedBookingType = BookingType.sales;

    // Set sale date
    pickupDate = sale.saleDate.parseToDateTime();

    // Set client details
    final saleClient = sale.client;
    if (saleClient != null) {
      BookingPhonePopulator.setPhoneFieldValue(
        _clientPhone1FieldController,
        clientPhone1Controller,
        phoneNumber: saleClient.phone1 > 0
            ? saleClient.phone1.toString()
            : null,
        e164: saleClient.phone1E164,
      );
    } else if (sale.clientPhone != null) {
      final phoneStr = sale.clientPhone.toString();
      if (phoneStr.isNotEmpty) {
        BookingPhonePopulator.setPhoneFieldValue(
          _clientPhone1FieldController,
          clientPhone1Controller,
          phoneNumber: phoneStr,
        );
      }
    }
    if (sale.address.isNotEmpty) {
      clientAddressController.text = sale.address;
    }

    // Set staff details
    if (sale.staffName != null) {
      staffNameController.text = sale.staffName!;
    }

    // Set payment details
    advanceAmountController.text = sale.paidAmount.toString();
    discountAmountController.text = sale.discountAmount.toString();

    // Set description
    if (sale.description.isNotEmpty) {
      descriptionController.text = sale.description;
    }

    // Set products
    final products = sale.products.map((item) {
      return ProductSelectedEntity(
        variant: ProductInfoEntity(
          id: item.id,
          variantId: item.variantId,
          productId: item.productId,
          name: item.name,
          image: item.image,
          amount: item.price,
          category: item.category,
          color: item.color,
          model: item.model,
          mainServiceType: item.mainServiceType,
          variantAttribute: item.variantAttribute ?? '',
          measurements: [],
          quantity: item.quantity,
          stock: null,
          remainingStock: null,
        ),
        quantity: item.quantity,
        amount: item.price,
      );
    }).toList();
    selectedProductsNotifier.value = products;
  }

  // ---------------------------------------------------------------------------
  // Original value snapshot (for incremental update tracking)
  // CRITICAL: must be called after _initializeFromBooking populates all state.
  // ---------------------------------------------------------------------------

  void _storeOriginalValues(BookingDetailsEntity booking) {
    _originalBooking = booking;
    _originalPickupDate = booking.pickupDate?.parseToDateTime();
    _originalReturnDate = booking.returnDate.parseToDateTime();

    // Only use dedicated time fields — don't extract from date string
    if (booking.pickupTime != null && booking.pickupTime!.isNotEmpty) {
      _originalPickupTime = _extractExplicitTime(booking.pickupTime);
    } else {
      _originalPickupTime = null;
    }

    if (booking.returnTime != null && booking.returnTime!.isNotEmpty) {
      _originalReturnTime = _extractExplicitTime(booking.returnTime);
    } else {
      _originalReturnTime = null;
    }

    _originalClientName = booking.client.name;
    // Mirror the same zero-guard used in _initializeFromBooking so that
    // original vs current comparisons are accurate.
    _originalClientPhone1 = (booking.client.phone1) > 0
        ? booking.client.phone1.toString()
        : (booking.client.phone1E164 != null &&
                  booking.client.phone1E164!.isNotEmpty
              ? _extractPhoneFromE164(booking.client.phone1E164!)
              : '');
    _originalClientPhone2 = (booking.client.phone2 ?? 0) > 0
        ? booking.client.phone2.toString()
        : (booking.client.phone2E164 != null &&
                  booking.client.phone2E164!.isNotEmpty
              ? _extractPhoneFromE164(booking.client.phone2E164!)
              : null);
    __originalClientPhone1E164 = booking.client.phone1E164;
    __originalClientPhone2E164 = booking.client.phone2E164;
    _originalClientAddress = booking.address;

    _originalStaffId = booking.staffId;

    _originalSecurityAmount = booking.securityAmount;
    _originalIsSecurityPaid = booking.isSecurityPaid;
    _originalDiscountAmount = booking.discountAmount;

    // Store deep copy of additional charges
    _originalAdditionalCharges = additionalChargesNotifier.value
        .map(
          (c) =>
              AdditionalChargesEntity(id: c.id, name: c.name, amount: c.amount),
        )
        .toList();

    // Store deep copy of documents
    _originalDocuments = documentsNotifier.value
        .map(
          (d) => DocumentFileEntity(
            name: d.name,
            path: d.path,
            bytes: d.bytes != null ? List<int>.from(d.bytes!) : null,
          ),
        )
        .toList();

    // Store original running kilometers (new: from vehicle measurements; old: from otherDetails.end)
    String? originalKm;
    outer:
    for (final item in booking.bookedItems) {
      if (item.mainServiceType?.isVehicle ?? false) {
        for (final m in item.measurements) {
          if (m.key == 'running_kilometers') {
            originalKm = m.value;
            break outer;
          }
        }
      }
    }
    _originalRunningKm = originalKm ?? booking.otherDetails.end;
    _originalDeliveryStatus = booking.deliveryStatus;
    _originalCoolingPeriodDays = coolingPeriodDays;
    _originalCoolingPeriodMode = coolingPeriodMode;
    _originalRentalDays = _computeRentalDaysFromBookingEntity(booking);
  }

  // ---------------------------------------------------------------------------
  // Time/string extraction helpers (used during initialization)
  // ---------------------------------------------------------------------------

  /// Parses a "HH:mm[:ss]" time string from the API into a [TimeOfDay].
  /// Returns null for null/empty/malformed strings.
  TimeOfDay? _extractExplicitTime(String? timeString) {
    if (timeString == null || timeString.trim().isEmpty) return null;

    final trimmed = timeString.trim();
    final parts = trimmed.split(':');
    if (parts.length < 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;

    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Extracts the filename from a URL path segment.
  String _extractFilenameFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      if (segments.isNotEmpty) {
        return segments.last;
      }
    } catch (e) {
      log('⚠️ Error parsing URL: $e');
    }
    return 'Document';
  }

  String _extractPhoneFromE164(String e164) => extractPhoneFromE164(e164);

  /// Computes rental days directly from the [BookingDetailsEntity]'s raw date
  /// strings, without relying on screen state variables ([pickupDate] etc.)
  /// that may not have been correctly populated.
  ///
  /// This prevents a cascade bug where:
  ///   1. [booking.pickupDate] is null → [pickupDate] stays as `DateTime.now()`
  ///   2. If `DateTime.now()` is after [returnDate], the safety check in
  ///      [PaymentCalculator.calculateRentalDays] returns 1
  ///   3. [BookingProductHelpers.fromBookedItem] divides by 1 → total line
  ///      amount is shown as the per-item price
  ///
  /// NOTE: Uses actual pickup→return days, NOT cooling period days, because
  /// the server stores amounts based on actual rental days, not cooling days.
  int _computeRentalDaysFromBookingEntity(BookingDetailsEntity booking) {
    if (booking.pickupDate == null) {
      // When pickupDate is null from the API, estimate based on returnDate
      // minus 1 day. This ensures the calculation doesn't return 1 due to a
      // future DateTime.now() being after a past returnDate.
      log('⚠️ booking.pickupDate is null — estimating from returnDate');
      try {
        final returnD = booking.returnDate.parseToDateTime();
        final estPickup = returnD.subtract(const Duration(days: 1));
        return PaymentCalculator.calculateRentalDays(
          pickupDate: estPickup,
          returnDate: returnD,
        );
      } catch (e) {
        log('⚠️ Error estimating rental days from returnDate only: $e');
        return 1;
      }
    }

    try {
      final pickup = booking.pickupDate!.parseToDateTime();
      final returnD = booking.returnDate.parseToDateTime();
      final days = PaymentCalculator.calculateRentalDays(
        pickupDate: pickup,
        returnDate: returnD,
      );
      log('📅 Rental days from entity dates: $days');
      return days;
    } catch (e) {
      log('⚠️ Error computing rental days from booking entity: $e');
      return 1;
    }
  }
}
