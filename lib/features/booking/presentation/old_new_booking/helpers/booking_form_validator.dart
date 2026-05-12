import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';

export 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_validation_helper.dart'
    show BookingValidationResult;

/// Pure, UI-free validation logic for the booking/sales form.
///
/// All methods are static and return [BookingValidationResult].
/// No [BuildContext], no snackbars, no dialogs — callers own all display logic.
class BookingFormValidator {
  // ---------------------------------------------------------------------------
  // Product
  // ---------------------------------------------------------------------------

  /// Products must be non-empty and at least one must have a unit price > 0.
  static BookingValidationResult validateProductSelection(
    List<ProductSelectedEntity> products,
  ) {
    if (products.isEmpty) {
      return BookingValidationResult.invalid(
        errors: ['Please select at least one product to continue'],
      );
    }
    if (!products.any((p) => p.amount > 0)) {
      return BookingValidationResult.invalid(
        errors: ['At least one product must have a price greater than 0'],
      );
    }
    return BookingValidationResult.valid();
  }

  // ---------------------------------------------------------------------------
  // Client details (Step 0 → 1 gate)
  // ---------------------------------------------------------------------------

  /// Validates the client panel before advancing to the payment step.
  /// Delegates to [BookingValidationHelper.validateClientDetailsPanel] so the
  /// existing edit-booking screen continues to work without changes.
  static BookingValidationResult validateClientDetails({
    required String clientName,
    required String phone1,
    required String phone2,
    required String address,
    required int documentsCount,
    required int? selectedStaffId,
    required String staffName,
    required bool isSalesMode,
  }) =>
      BookingValidationHelper.validateClientDetailsPanel(
        clientName: clientName,
        phone1: phone1,
        phone2: phone2,
        address: address,
        documentsCount: documentsCount,
        selectedStaffId: selectedStaffId,
        staffName: staffName,
        isSalesMode: isSalesMode,
      );

  // ---------------------------------------------------------------------------
  // Payment (Step 1 → confirm gate)
  // ---------------------------------------------------------------------------

  /// Validates payment fields before the final submit.
  ///
  /// Rules differ by booking type:
  /// - **Sales**: payment account is always required.
  /// - **Booking**: advance must not exceed total payable; advance account
  ///   required when advance > 0; security account required when security > 0.
  static BookingValidationResult validatePayment({
    required BookingType bookingType,
    required int advanceAmount,
    required int securityAmount,
    required int totalPayable,
    required AccountEntity? advanceAccount,
    required AccountEntity? securityAccount,
  }) {
    if (bookingType == BookingType.sales) {
      if (advanceAccount == null) {
        return BookingValidationResult.invalid(
          errors: ['Please select a payment option'],
          firstErrorField: 'advanceAccount',
        );
      }
      return BookingValidationResult.valid();
    }

    // Booking / old-booking mode
    if (advanceAmount > totalPayable) {
      return BookingValidationResult.invalid(
        errors: ['Advance amount cannot be greater than total amount'],
        firstErrorField: 'advanceAmount',
      );
    }
    if (advanceAmount > 0 && advanceAccount == null) {
      return BookingValidationResult.invalid(
        errors: ['Please select a payment option for advance amount'],
        firstErrorField: 'advanceAccount',
      );
    }
    if (securityAmount > 0 && securityAccount == null) {
      return BookingValidationResult.invalid(
        errors: ['Please select a payment option for security amount'],
        firstErrorField: 'securityAccount',
      );
    }
    return BookingValidationResult.valid();
  }

  // ---------------------------------------------------------------------------
  // Time helpers
  // ---------------------------------------------------------------------------

  /// Returns true when [time] falls before the current wall-clock minute.
  /// Only meaningful when the booking date is today.
  static bool isTimeInPast(TimeOfDay time) {
    final now = TimeOfDay.now();
    return (time.hour * 60 + time.minute) < (now.hour * 60 + now.minute);
  }

  /// Returns true when [returnTime] is strictly later than [pickupTime].
  /// Used for same-day bookings where both times are on the same date.
  static bool isReturnAfterPickup(
    TimeOfDay pickupTime,
    TimeOfDay returnTime,
  ) =>
      (returnTime.hour * 60 + returnTime.minute) >
      (pickupTime.hour * 60 + pickupTime.minute);

  // ---------------------------------------------------------------------------
  // Additional charges
  // ---------------------------------------------------------------------------

  /// Validates a single additional charge before adding it to the list.
  static BookingValidationResult validateAdditionalCharge({
    required String name,
    required int? amount,
  }) {
    if (name.trim().isEmpty) {
      return BookingValidationResult.invalid(
        errors: ['Please enter charge name'],
        firstErrorField: 'chargeName',
      );
    }
    if (amount == null || amount <= 0) {
      return BookingValidationResult.invalid(
        errors: ['Please enter a valid amount greater than 0'],
        firstErrorField: 'chargeAmount',
      );
    }
    return BookingValidationResult.valid();
  }
}
