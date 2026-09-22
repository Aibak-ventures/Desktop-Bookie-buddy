import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_date_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

/// Centralizes the product-list loading sequence shared by both the
/// new-booking and edit-booking flows.
///
/// Encapsulates:
/// - Effective pickup/return date calculation (cooling period aware)
/// - Currently-selected variant ID extraction (for stock accuracy)
/// - [SelectProductBloc] dispatch
/// - 300 ms debounce (previously duplicated in both screens)
/// - Reconciling already-selected products' stock against the load result,
///   and surfacing [showUnavailableProductsDialog] for any that are now out
///   of stock — this reuses the same `available-products` response instead
///   of firing a second, near-identical availability request (the two used
///   to hit the same endpoint with the same params on every date change).
///
/// Usage:
/// ```dart
/// // In initState — after _selectProductBloc is created:
/// _productLoader = BookingProductLoader(selectProductBloc: _selectProductBloc);
///
/// // Where you previously called _loadProductsInternal / _checkSelectedProductsAvailability:
/// _productLoader.load(bookingType: ..., context: context, selectedProductsNotifier: ..., ...);
/// ```
class BookingProductLoader {
  final SelectProductBloc _bloc;
  final Debouncer _debouncer;

  BookingProductLoader({required SelectProductBloc selectProductBloc})
    : _bloc = selectProductBloc,
      _debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  /// Schedules a debounced product-list load, then reconciles the
  /// currently-selected products' stock against the result (see class doc).
  ///
  /// [bookingId] — pass in edit mode so the availability API excludes the
  /// current booking from conflict checks.
  ///
  /// [selectedProductsNotifier] — its current value's variant IDs are
  /// included in the request (for stock accuracy), and its items are the
  /// ones refreshed/flagged once the response comes back.
  void load({
    required BookingType bookingType,
    required int? selectedServiceId,
    required DateTime pickupDate,
    required DateTime returnDate,
    required TimeOfDay? pickupTime,
    required TimeOfDay? returnTime,
    required int coolingPeriodDays,
    required CoolingPeriodMode coolingPeriodMode,
    required BuildContext context,
    required ValueNotifier<List<ProductSelectedEntity>>
    selectedProductsNotifier,
    int? bookingId,
  }) {
    _debouncer.run(
      () => _dispatch(
        bookingType: bookingType,
        selectedServiceId: selectedServiceId,
        pickupDate: pickupDate,
        returnDate: returnDate,
        pickupTime: pickupTime,
        returnTime: returnTime,
        coolingPeriodDays: coolingPeriodDays,
        coolingPeriodMode: coolingPeriodMode,
        context: context,
        selectedProductsNotifier: selectedProductsNotifier,
        bookingId: bookingId,
      ),
    );
  }

  void _dispatch({
    required BookingType bookingType,
    required int? selectedServiceId,
    required DateTime pickupDate,
    required DateTime returnDate,
    required TimeOfDay? pickupTime,
    required TimeOfDay? returnTime,
    required int coolingPeriodDays,
    required CoolingPeriodMode coolingPeriodMode,
    required BuildContext context,
    required ValueNotifier<List<ProductSelectedEntity>>
    selectedProductsNotifier,
    int? bookingId,
  }) {
    final isSales = bookingType == BookingType.sales;
    final isOldBooking = bookingType == BookingType.oldBooking;
    final isBooking = bookingType == BookingType.booking;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

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

    log(
      '📦 Loading products — pickup: ${pickupDate.format()}, effectivePickup: ${effectivePickupDate.format()}, return: $effectiveReturnDate, cooling: $coolingPeriodDays days (${coolingPeriodMode.value}), isSales: $isSales',
    );

    final currentVariantIds = selectedProductsNotifier.value
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();

    _bloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceIdToUse,
        pickupDate: effectivePickupDate.format(),
        returnDate: effectiveReturnDate,
        pickupTime: effectivePickupTime,
        returnTime: effectiveReturnTime,
        useAvailableProductsApi: !isSales,
        isSales: isSales,
        bookingId: bookingId,
        variantIds: currentVariantIds.isNotEmpty ? currentVariantIds : null,
      ),
    );

    // Sales/old-booking selections aren't date-availability constrained, and
    // there's nothing to reconcile if nothing is selected.
    if (isSales || isOldBooking || currentVariantIds.isEmpty) return;

    _syncSelectedProductsAvailability(
      context: context,
      selectedProductsNotifier: selectedProductsNotifier,
      variantIds: currentVariantIds,
      expectedPickupDate: effectivePickupDate.format(),
      expectedReturnDate: effectiveReturnDate,
      expectedServiceId: serviceIdToUse,
      displayPickupDate: pickupDate.format(),
      displayReturnDate: returnDate.format(),
    );
  }

  /// Waits for the just-dispatched load to resolve, then refreshes every
  /// selected item's `remainingStock`/`stock` from the (already-fetched)
  /// response and shows [showUnavailableProductsDialog] for any that came
  /// back with zero stock.
  Future<void> _syncSelectedProductsAvailability({
    required BuildContext context,
    required ValueNotifier<List<ProductSelectedEntity>>
    selectedProductsNotifier,
    required List<int> variantIds,
    required String expectedPickupDate,
    required String expectedReturnDate,
    required int? expectedServiceId,
    required String displayPickupDate,
    required String displayReturnDate,
  }) async {
    bool isTargetState(SelectProductState s) =>
        s.mapOrNull(
          loaded: (loaded) =>
              loaded.pickupDate == expectedPickupDate &&
              loaded.returnDate == expectedReturnDate &&
              loaded.serviceId == expectedServiceId,
          error: (_) => true,
        ) ??
        false;

    final SelectProductState state;
    try {
      state = await _bloc.stream
          .firstWhere(isTargetState)
          .timeout(const Duration(seconds: 15));
    } catch (e) {
      log('Error waiting for product availability sync: $e');
      return;
    }

    final loadedProducts = state.mapOrNull(loaded: (s) => s.products);
    if (loadedProducts == null) return;

    final remainingStockByVariantId = <int, int>{};
    for (final product in loadedProducts) {
      for (final variant in product.variants) {
        remainingStockByVariantId[variant.id] =
            variant.remainingStock ?? variant.stock;
      }
    }
    if (remainingStockByVariantId.isEmpty) return;

    selectedProductsNotifier.value = selectedProductsNotifier.value.map((
      product,
    ) {
      final variantId = product.variant.variantId;
      final freshStock = variantId != null
          ? remainingStockByVariantId[variantId]
          : null;
      if (freshStock == null) return product;
      return product.copyWith(
        variant: product.variant.copyWith(
          remainingStock: freshStock,
          stock: freshStock,
        ),
      );
    }).toList();

    final unavailableIds = variantIds
        .where((id) => (remainingStockByVariantId[id] ?? 0) <= 0)
        .toList();

    if (unavailableIds.isNotEmpty && context.mounted) {
      await showUnavailableProductsDialog(
        context: context,
        unavailableDateFrom: displayPickupDate,
        unavailableDateTo: displayReturnDate,
        unavailableProducts: unavailableIds,
        selectedProductsNotifier: selectedProductsNotifier,
      );
    }
  }
}
