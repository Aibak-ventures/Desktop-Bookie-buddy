import 'package:bookie_buddy_shared/core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_shared/core/core/common/entities/additional_charges_entity/additional_charges_entity.dart';
// import 'package:bookie_buddy_web/features/booking/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

/// Pure calculation logic for booking and payment operations.
/// All methods are static and side-effect free for easy testing.
class PaymentCalculator {
  /// Calculate number of days between pickup and return dates.
  ///
  /// Business logic:
  /// - Below 24 hours = 1 day
  /// - Every started 24-hour block = +1 day
  /// - Considers time component for accurate calculation
  /// - Return date must be after pickup date (enforced)
  ///
  /// Defaults:
  /// - Pickup time: 23:59 (if not specified)
  /// - Return time: 00:00 (if not specified)
  static int calculateRentalDays({
    required DateTime pickupDate,
    required DateTime returnDate,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
  }) {
    // Default pickup time: 23:59 if not selected
    final pickupDateTime = DateTime(
      pickupDate.year,
      pickupDate.month,
      pickupDate.day,
      pickupTime?.hour ?? 23,
      pickupTime?.minute ?? 59,
    );

    // Default return time: 00:00 if not selected
    final returnDateTime = DateTime(
      returnDate.year,
      returnDate.month,
      returnDate.day,
      returnTime?.hour ?? 0,
      returnTime?.minute ?? 0,
    );

    // Safety: return date must be after pickup
    if (!returnDateTime.isAfter(pickupDateTime)) {
      return 1;
    }

    final difference = returnDateTime.difference(pickupDateTime);

    // Convert to hours (include minutes precision)
    final hours = difference.inMinutes / 60;

    // Business rule:
    // Below 24 hours = 1 day
    // Every started 24h block = +1 day
    return hours <= 24 ? 1 : (hours / 24).ceil();
  }

  /// Get effective rental days including manually added extra days.
  ///
  /// Always returns at least 1 day.
  /// Example: 3 base days + 2 manual = 5 total
  static int getEffectiveRentalDays({
    required int baseDays,
    required int manualExtraRentalDays,
  }) {
    final totalDays = baseDays + manualExtraRentalDays;
    return totalDays > 0 ? totalDays : 1;
  }

  /// Check if a service type requires date-range-based pricing.
  /// Delegates to [MainServiceType.requiresDateRange] — true for Vehicle, Gadgets, Equipment, Costume, Room.
  /// Returns false for null (safe default).
  static bool shouldMultiplyByDays(MainServiceType? serviceType) {
    return serviceType?.requiresDateRange ?? false;
  }

  /// Get the days multiplier for a specific product.
  ///
  /// - Sales mode: always returns 1 (no date multiplication)
  /// - Non-rental items: always returns 1
  /// - Rental items in booking mode: returns effective rental days
  static int getDaysMultiplierForProduct({
    required ProductSelectedEntity product,
    required BookingType bookingType,
    required int effectiveRentalDays,
  }) {
    if (bookingType == BookingType.sales) return 1;
    if (!shouldMultiplyByDays(product.variant.mainServiceType)) return 1;
    return effectiveRentalDays;
  }

  /// Sum of selected products' line amounts, applying the day multiplier
  /// per product (via [getDaysMultiplierForProduct]).
  ///
  /// The single source of truth for "product total" — used by
  /// [getDiscountProductBase], [calculateBookingTotalPayable], and every
  /// screen/widget that needs to show or validate against it, so they never
  /// drift apart.
  static int calculateProductTotal({
    required List<ProductSelectedEntity> selectedProducts,
    required BookingType bookingType,
    required int effectiveRentalDays,
  }) {
    // Defensive: the callers we know of always clamp this upstream, but the
    // three call sites this replaced each guarded against a stray 0/negative
    // value themselves — keep that guarantee here so nothing regresses if a
    // future caller forgets to.
    final safeRentalDays = effectiveRentalDays > 0 ? effectiveRentalDays : 1;
    return selectedProducts.fold<int>(0, (sum, product) {
      final daysMultiplier = getDaysMultiplierForProduct(
        product: product,
        bookingType: bookingType,
        effectiveRentalDays: safeRentalDays,
      );
      return sum + (product.amount * product.quantity * daysMultiplier);
    });
  }

  /// Sum of additional charges' amounts.
  static int calculateAdditionalChargesTotal(
    List<AdditionalChargesEntity> additionalCharges,
  ) {
    return additionalCharges.fold<int>(
      0,
      (sum, charge) => sum + (charge.amount ?? 0),
    );
  }

  /// Calculate the product base amount for discount calculation.
  ///
  /// This is: (products with day multiplier) + (additional charges)
  ///
  /// Used to determine the amount before discount is applied.
  static int getDiscountProductBase({
    required List<ProductSelectedEntity> selectedProducts,
    required List<AdditionalChargesEntity> additionalCharges,
    required BookingType bookingType,
    required int effectiveRentalDays,
  }) {
    final productTotal = calculateProductTotal(
      selectedProducts: selectedProducts,
      bookingType: bookingType,
      effectiveRentalDays: effectiveRentalDays,
    );
    return productTotal + calculateAdditionalChargesTotal(additionalCharges);
  }

  /// Resolve a raw discount input (a percentage or a fixed amount,
  /// depending on [isDiscountPercentage]) into an actual currency amount.
  ///
  /// Percentage discounts are taken against [productTotal] + [additionalTotal]
  /// — pass these separately rather than pre-summed so callers don't have to
  /// know that's the base; they just hand over whatever product/additional
  /// totals they already computed. Most callers pass the day-multiplied
  /// product total (see [calculateProductTotal]), but at least one
  /// deliberately passes unit amounts only (see `BookingRequestBuilder`'s
  /// discount comment).
  static int resolveDiscountAmount({
    required bool isDiscountPercentage,
    required int discountInput,
    required int productTotal,
    required int additionalTotal,
  }) {
    return isDiscountPercentage
        ? ((productTotal + additionalTotal) * discountInput / 100).round()
        : discountInput;
  }

  /// Combine already-computed components into a final payable total:
  /// products + additional charges + security − discount + exclusive tax.
  ///
  /// The single place that knows what gets added and what gets subtracted —
  /// every screen/widget that assembles a payable total from these same
  /// pieces should call this instead of re-deriving the +/- signs itself.
  ///
  /// [additionalTaxAmount] is the exclusive-tax portion from a
  /// `TaxSummaryEntity` (its `additionalTaxAmount`) — pass it whenever the
  /// shop/booking has tax rules so this total matches what's shown in the
  /// summary card; omit it (defaults to 0) where tax doesn't apply.
  /// [securityAmount] only applies where a security deposit is part of the
  /// payable total (e.g. a booking's "pending" total); omit it elsewhere.
  ///
  /// Edge cases:
  /// - Negative totals clamped to 0 (handled at UI level)
  /// - Percentage discount rounded to nearest integer (see
  ///   [resolveDiscountAmount]) before it reaches [discountAmount] here
  static int combineTotalPayable({
    required int productTotal,
    int additionalTotal = 0,
    required int discountAmount,
    double additionalTaxAmount = 0,
    int securityAmount = 0,
  }) {
    return productTotal +
        additionalTotal +
        securityAmount -
        discountAmount +
        additionalTaxAmount.round();
  }

  /// Calculate the total amount payable after discount (and tax, if any).
  ///
  /// Flow:
  /// 1. Calculate product total (with day multiplier)
  /// 2. Add additional charges
  /// 3. Apply discount (fixed or percentage)
  /// 4. Add exclusive-type tax on top
  /// 5. Return final amount
  ///
  /// [additionalTaxAmount] is the exclusive-tax portion from a
  /// `TaxSummaryEntity` (its `additionalTaxAmount`) — pass it whenever the
  /// shop/booking has tax rules so this total matches what's shown in the
  /// summary card; omit it (defaults to 0) where tax doesn't apply.
  ///
  /// Edge cases:
  /// - Negative totals clamped to 0 (handled at UI level)
  /// - Percentage discount rounded to nearest integer
  /// - Discount cannot exceed total (validated at UI level)
  static int calculateBookingTotalPayable({
    required List<ProductSelectedEntity> selectedProducts,
    required List<AdditionalChargesEntity> additionalCharges,
    required int discountAmount,
    required bool isDiscountPercentage,
    required BookingType bookingType,
    required int effectiveRentalDays,
    double additionalTaxAmount = 0,
  }) {
    final productTotal = calculateProductTotal(
      selectedProducts: selectedProducts,
      bookingType: bookingType,
      effectiveRentalDays: effectiveRentalDays,
    );
    final additionalTotal = calculateAdditionalChargesTotal(additionalCharges);

    final actualDiscount = resolveDiscountAmount(
      isDiscountPercentage: isDiscountPercentage,
      discountInput: discountAmount,
      productTotal: productTotal,
      additionalTotal: additionalTotal,
    );

    return combineTotalPayable(
      productTotal: productTotal,
      additionalTotal: additionalTotal,
      discountAmount: actualDiscount,
      additionalTaxAmount: additionalTaxAmount,
    );
  }

  /// Round a number to a meaningful price point.
  ///
  /// Scaling:
  /// - < 100: round to nearest 10
  /// - < 1000: round to nearest 100
  /// - < 10000: round to nearest 1000
  /// - >= 10000: round to nearest 5000
  ///
  /// Used for generating price range quick filters.
  static double roundToMeaningfulNumber(double value) {
    if (value < 100) {
      return (value / 10).round() * 10.0;
    } else if (value < 1000) {
      return (value / 100).round() * 100.0;
    } else if (value < 10000) {
      return (value / 1000).round() * 1000.0;
    } else {
      return (value / 5000).round() * 5000.0;
    }
  }

  /// Generate dynamic quick filter chips for price range selection.
  ///
  /// Creates 4-5 meaningful price ranges based on max price:
  /// - Under 10% of max
  /// - 10-25% range
  /// - 25-50% range
  /// - 50-75% range
  /// - Above 75% of max
  ///
  /// Falls back to 4 equal divisions if dynamic ranges are too similar.
  ///
  /// Returns list of maps with 'label' and 'range' (RangeValues) keys.
  static List<Map<String, dynamic>> generateQuickFilters({
    required double minPrice,
    required double maxPrice,
  }) {
    final List<Map<String, dynamic>> filters = [];

    // Calculate dynamic ranges based on maxPrice
    double range1 = maxPrice * 0.1; // 10% of max
    double range2 = maxPrice * 0.25; // 25% of max
    double range3 = maxPrice * 0.5; // 50% of max
    double range4 = maxPrice * 0.75; // 75% of max

    // Round to nearest meaningful number
    range1 = roundToMeaningfulNumber(range1);
    range2 = roundToMeaningfulNumber(range2);
    range3 = roundToMeaningfulNumber(range3);
    range4 = roundToMeaningfulNumber(range4);

    // Ensure ranges are distinct and meaningful
    if (range1 > minPrice && range1 < maxPrice) {
      filters.add({
        'label': 'Under ${range1.toCurrency()}',
        'range': RangeValues(minPrice, range1),
      });
    }

    if (range2 > range1 && range2 < maxPrice) {
      filters.add({
        'label': '${range1.toCurrency()} - ${range2.toCurrency()}',
        'range': RangeValues(range1, range2),
      });
    }

    if (range3 > range2 && range3 < maxPrice) {
      filters.add({
        'label': '${range2.toCurrency()} - ${range3.toCurrency()}',
        'range': RangeValues(range2, range3),
      });
    }

    if (range4 > range3 && range4 < maxPrice) {
      filters.add({
        'label': '${range3.toCurrency()} - ${range4.toCurrency()}',
        'range': RangeValues(range3, range4),
      });
    }

    // Always add "Above X" filter
    if (range4 < maxPrice) {
      filters.add({
        'label': 'Above ${range4.toCurrency()}',
        'range': RangeValues(range4, maxPrice),
      });
    }

    // Fallback: if no meaningful ranges, create simple divisions
    if (filters.isEmpty) {
      final quarter = (maxPrice - minPrice) / 4;
      filters.addAll([
        {
          'label': 'Under ${(minPrice + quarter).toCurrency()}',
          'range': RangeValues(minPrice, minPrice + quarter),
        },
        {
          'label':
              '${(minPrice + quarter).toCurrency()} - ${(minPrice + 2 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + quarter, minPrice + 2 * quarter),
        },
        {
          'label':
              '${(minPrice + 2 * quarter).toCurrency()} - ${(minPrice + 3 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + 2 * quarter, minPrice + 3 * quarter),
        },
        {
          'label': 'Above ${(minPrice + 3 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + 3 * quarter, maxPrice),
        },
      ]);
    }

    return filters;
  }
}
