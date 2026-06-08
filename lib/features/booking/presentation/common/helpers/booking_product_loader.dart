import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_date_calculator.dart';
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
///
/// Usage:
/// ```dart
/// // In initState — after _selectProductBloc is created:
/// _productLoader = BookingProductLoader(selectProductBloc: _selectProductBloc);
///
/// // Where you previously called _loadProductsInternal / _loadAvailableProductsInternal:
/// _productLoader.load(bookingType: ..., ...);
/// ```
class BookingProductLoader {
  final SelectProductBloc _bloc;
  final Debouncer _debouncer;

  BookingProductLoader({required SelectProductBloc selectProductBloc})
      : _bloc = selectProductBloc,
        _debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  /// Schedules a debounced product-list load.
  ///
  /// [bookingId] — pass in edit mode so the availability API excludes the
  /// current booking from conflict checks.
  ///
  /// [selectedProducts] — pass the currently selected products so their
  /// variant IDs are included in the request, giving accurate stock counts.
  void load({
    required BookingType bookingType,
    required int? selectedServiceId,
    required DateTime pickupDate,
    required DateTime returnDate,
    required TimeOfDay? pickupTime,
    required TimeOfDay? returnTime,
    required int coolingPeriodDays,
    required CoolingPeriodMode coolingPeriodMode,
    List<ProductSelectedEntity> selectedProducts = const [],
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
        selectedProducts: selectedProducts,
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
    required List<ProductSelectedEntity> selectedProducts,
    int? bookingId,
  }) {
    final isSales = bookingType == BookingType.sales;
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
    final effectiveReturnDate = BookingDateCalculator.effectiveReturnDateStr(
      returnDate: returnDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );

    log(
      '📦 Loading products — pickup: ${pickupDate.format()}, effectivePickup: ${effectivePickupDate.format()}, return: $effectiveReturnDate, cooling: $coolingPeriodDays days (${coolingPeriodMode.value}), isSales: $isSales',
    );

    final currentVariantIds = selectedProducts
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();

    _bloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceIdToUse,
        pickupDate: effectivePickupDate.format(),
        returnDate: effectiveReturnDate,
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: !isSales,
        isSales: isSales,
        bookingId: bookingId,
        variantIds: currentVariantIds.isNotEmpty ? currentVariantIds : null,
      ),
    );
  }
}
