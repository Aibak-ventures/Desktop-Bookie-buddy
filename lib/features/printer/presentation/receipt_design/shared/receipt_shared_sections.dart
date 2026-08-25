import 'package:flutter/material.dart';

import 'package:bookie_buddy_core/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import '../../../../../core/constants/enums/service_type_enums.dart';
import '../../../../../utils/extensions/number_extensions.dart';
import '../../../../../utils/helpers/product_field_helper.dart';
import 'receipt_canvas.dart';

/// Small building blocks reused across every line-item-based receipt
/// (booking, sales, and whatever comes next): the items-table column
/// widths, the per-row product subtitle, and the tax breakdown rows. Add
/// new pieces here as more receipt types share more of these — e.g. a
/// future `buildDiscountRow`. Each receipt builder still owns its own
/// item-row layout and its own charges section end-to-end; only the bits
/// that are identical today live here, so they can't quietly drift apart
/// as one receipt type gets edited and not the other.
class ReceiptSharedSections {
  const ReceiptSharedSections._();

  // Column flex weights for the items table (SL / item name / qty /
  // amount). Shared between the header row and every item row so the two
  // stay aligned — change one column's width here and every receipt type
  // follows.
  static const int slNoFlex = 8;
  static const int itemNameFlex = 48;
  static const int qtyFlex = 14;
  static const int amountFlex = 30;

  /// The product subtitle shown under an item's name in the items table —
  /// same "what's relevant for this service type" rule
  /// `ProductSimpleDetailsTile` uses on the booking/sale details screens,
  /// via [ProductFieldHelper.getSubtitleLines], so a product never shows
  /// different fields on its receipt than it does on its details screen.
  ///
  /// Returns `null` (never an empty string) when there's nothing to show,
  /// so callers can pass the result straight to `ReceiptColumn.subtitle`.
  static String? itemSubtitle({
    required MainServiceType? serviceType,
    String? variantAttribute,
    String? color,
    String? category,
    String? model,
    String? registrationNumber,
    required int quantity,
    double fabricLength = 0,
  }) {
    final subtitle = ProductFieldHelper.getSubtitleLines(
      serviceType: serviceType,
      variantAttribute: variantAttribute,
      color: color,
      category: category,
      model: model,
      registrationNumber: registrationNumber,
      quantity: quantity,
      fabricLength: fabricLength,
      // The item row already has its own "Qty" column — showing it again
      // in the subtitle text would duplicate it.
      includeQuantity: false,
      includeLabels: false,
      needFallbacks: false,
    ).join(' · ');

    return subtitle.isEmpty ? null : subtitle;
  }

  /// Prints a "Discount" row for a negative amount — a no-op when
  /// [discountAmount] is `null` or not positive, so callers can call this
  /// unconditionally instead of guarding it themselves.
  static void buildDiscountRow(ReceiptCanvas canvas, num? discountAmount) {
    if (discountAmount == null || discountAmount <= 0) return;
    canvas.row([
      const ReceiptColumn('Discount'),
      ReceiptColumn('-${discountAmount.toCurrency()}', align: TextAlign.right),
    ]);
  }

  /// Prints one row per applied tax, preceded by a divider — a no-op when
  /// [appliedTaxes] is empty, so callers can call this unconditionally.
  static void buildTaxRows(
    ReceiptCanvas canvas,
    List<AppliedTaxEntity> appliedTaxes,
  ) {
    if (appliedTaxes.isEmpty) return;
    canvas.divider();
    for (final tax in appliedTaxes) {
      canvas.row([
        ReceiptColumn(tax.formattedTaxLabel),
        ReceiptColumn(tax.taxAmount.toCurrency(), align: TextAlign.right),
      ]);
    }
  }
}
