import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_date_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

/// Centralizes the "are my already-selected products still available for
/// this date range" check shared by both the new-booking and edit-booking
/// flows.
///
/// Encapsulates:
/// - Effective pickup/return date calculation (cooling period aware)
/// - The [IProductRepository.checkVariantAvailability] call
/// - Showing [showUnavailableProductsDialog] when some are not available
///
/// Usage:
/// ```dart
/// SelectedProductsAvailabilityChecker(productRepository: getIt())
///   .check(
///     context: context,
///     bookingType: selectedBookingType,
///     pickupDate: pickupDate,
///     returnDate: returnDate,
///     pickupTime: pickupTime,
///     returnTime: returnTime,
///     coolingPeriodDays: coolingPeriodDays,
///     coolingPeriodMode: coolingPeriodMode,
///     selectedProductsNotifier: selectedProductsNotifier,
///     bookingId: widget.bookingId, // edit mode only
///   );
/// ```
class SelectedProductsAvailabilityChecker {
  final IProductRepository _productRepository;

  SelectedProductsAvailabilityChecker({
    required IProductRepository productRepository,
  }) : _productRepository = productRepository;

  /// Checks availability of the currently selected products for the given
  /// date range and shows [showUnavailableProductsDialog] if any are not
  /// available. No-ops for sales/old-booking types or when nothing is
  /// selected.
  ///
  /// [bookingId] — pass in edit mode so the availability API excludes the
  /// current booking from conflict checks.
  Future<void> check({
    required BuildContext context,
    required BookingType bookingType,
    required DateTime pickupDate,
    required DateTime returnDate,
    required TimeOfDay? pickupTime,
    required TimeOfDay? returnTime,
    required int coolingPeriodDays,
    required CoolingPeriodMode coolingPeriodMode,
    required ValueNotifier<List<ProductSelectedEntity>>
    selectedProductsNotifier,
    int? bookingId,
  }) async {
    final isSales = bookingType == BookingType.sales;
    final isOldBooking = bookingType == BookingType.oldBooking;
    final isBooking = bookingType == BookingType.booking;
    if (isSales || isOldBooking) return;

    final selected = selectedProductsNotifier.value;
    if (selected.isEmpty) return;

    final variantIds = selected
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();
    if (variantIds.isEmpty) return;

    final effectivePickupDate = BookingDateCalculator.effectivePickupDate(
      pickupDate: pickupDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectivePickupTime = BookingDateCalculator.effectivePickupTime(
      pickupDate: pickupDate,
      pickupTime: pickupTime,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectiveReturnDate = BookingDateCalculator.effectiveReturnDateStr(
      returnDate: returnDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectiveReturnTime = BookingDateCalculator.effectiveReturnTime(
      returnDate: returnDate,
      returnTime: returnTime,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );

    try {
      final notFoundIds = await _productRepository.checkVariantAvailability(
        pickupDate: effectivePickupDate.format(),
        returnDate: effectiveReturnDate,
        variantIds: variantIds,
        bookingId: bookingId,
        pickupTime: effectivePickupTime,
        returnTime: effectiveReturnTime,
      );

      if (notFoundIds.isNotEmpty && context.mounted) {
        await showUnavailableProductsDialog(
          context: context,
          unavailableDateFrom: pickupDate.format(),
          unavailableDateTo: returnDate.format(),
          unavailableProducts: notFoundIds,
          selectedProductsNotifier: selectedProductsNotifier,
        );
      }
    } catch (e) {
      log('Error checking selected product availability: $e');
    }
  }
}
