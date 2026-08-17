import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import '../../../../../core/common/entities/user_shop_entity/user_shop_entity.dart';
import '../../../../../core/constants/enums/booking_status_enums.dart';
import '../../../../../core/constants/enums/service_type_enums.dart';
import '../../../../../utils/extensions/list_extensions.dart';
import '../../../../../utils/extensions/number_extensions.dart';
import '../../../../booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import '../../../../booking/presentation/common/utils/booking_time_resolver.dart';
import '../../../../product/domain/entities/product_info_entity/product_info_entity.dart';
import '../../../domain/entities/print_ticket_entity/print_ticket_entity.dart';
import '../shared/receipt_canvas.dart';
import '../shared/receipt_date_formatter.dart';
import '../shared/receipt_shared_sections.dart';
import '../shared/shop_receipt_sections.dart';

/// Builds a printable receipt ticket for a booking, using [ReceiptCanvas] —
/// the only booking-aware piece of the `thermal_printer` feature. Everything
/// in `domain/` and the rest of `presentation/` is generic; custom-work/sales
/// receipts get their own sibling builder here later, reusing the same
/// canvas commands.
///
/// Needs a [BuildContext] (unlike the old text-based builder) since building
/// the ticket now means actually rendering Flutter widgets off-screen.
class BookingReceiptCanvasBuilder {
  const BookingReceiptCanvasBuilder();

  // Column widths for the items table — shared with every other
  // line-item receipt so they can't drift out of alignment with each
  // other. See [ReceiptSharedSections].
  static const int _slNoFlex = ReceiptSharedSections.slNoFlex;
  static const int _itemNameFlex = ReceiptSharedSections.itemNameFlex;
  static const int _qtyFlex = ReceiptSharedSections.qtyFlex;
  static const int _amountFlex = ReceiptSharedSections.amountFlex;

  Future<PrintTicketEntity> call({
    required BuildContext context,
    required BookingDetailsEntity booking,
    required UserShopEntity shop,
  }) async {
    final canvas = ReceiptCanvas(context: context);

    final MainServiceType? bookingMainServiceType =
        booking.bookedItems.firstOrNull?.mainServiceType;

    await ShopReceiptSections.buildHeader(
      canvas,
      shop,
      heading: '--- RENT BILL ---',
    );
    _buildMeta(canvas, booking, bookingMainServiceType);
    _buildCustomer(canvas, booking, bookingMainServiceType);
    await _buildItems(canvas, booking);
    _buildPaymentDetails(canvas, booking);

    await ShopReceiptSections.buildTermsAndFooter(
      canvas,
      termsAndConditions: shop.termsAndConditions.isNotEmpty
          ? shop.termsAndConditions
          : shop.defaultBookingsTermsAndConditions,
      closingMessage: 'Thank you for your booking!',
    );

    await canvas.cut();
    return canvas.build();
  }

  void _buildMeta(
    ReceiptCanvas canvas,
    BookingDetailsEntity booking,
    MainServiceType? bookingMainServiceType,
  ) {
    canvas
      ..divider()
      ..row([
        const ReceiptColumn('Invoice No:'),
        ReceiptColumn(booking.invoiceId, align: TextAlign.right),
      ])
      ..row([
        const ReceiptColumn('Staff:'),
        ReceiptColumn(booking.staffName ?? 'N/A', align: TextAlign.right),
      ])
      ..row([
        const ReceiptColumn('Booked:'),
        ReceiptColumn(
          ReceiptDateFormatter.dateAndMaybeTime(
            booking.bookedDate,
            ReceiptDateFormatter.safeTime(booking.bookedDate),
          ),
          align: TextAlign.right,
        ),
      ]);

    if (booking.pickupDate != null) {
      canvas.row([
        ReceiptColumn('${bookingMainServiceType.pickupLabel}:'),
        ReceiptColumn(
          ReceiptDateFormatter.dateAndMaybeTime(
            booking.pickupDate!,
            booking.resolvedPickupTime,
          ),
          align: TextAlign.right,
        ),
      ]);
    }
    canvas.row([
      ReceiptColumn('${bookingMainServiceType.returnLabel}:'),
      ReceiptColumn(
        ReceiptDateFormatter.dateAndMaybeTime(
          booking.returnDate,
          booking.resolvedReturnTime,
        ),
        align: TextAlign.right,
      ),
    ]);
  }

  void _buildCustomer(
    ReceiptCanvas canvas,
    BookingDetailsEntity booking,
    MainServiceType? bookingMainServiceType,
  ) {
    canvas
      ..divider()
      ..row([
        ReceiptColumn('${bookingMainServiceType.clientNameType}:'),
        ReceiptColumn(booking.client.name, align: TextAlign.right),
      ])
      ..row([
        const ReceiptColumn('Phone:'),
        ReceiptColumn(booking.client.phone1E164 ?? '', align: TextAlign.right),
      ]);
  }

  Future<void> _buildItems(
    ReceiptCanvas canvas,
    BookingDetailsEntity booking,
  ) async {
    canvas
      ..divider()
      ..row([
        const ReceiptColumn('Sl', flex: _slNoFlex, bold: true),
        const ReceiptColumn('Item', flex: _itemNameFlex, bold: true),
        const ReceiptColumn(
          'Qty',
          flex: _qtyFlex,
          align: TextAlign.right,
          bold: true,
        ),
        const ReceiptColumn(
          'Amount',
          flex: _amountFlex,
          align: TextAlign.right,
          bold: true,
        ),
      ])
      ..divider(heavy: true);

    await canvas.buildLongList(
      booking.bookedItems,
      (item, index) => _buildItemRow(canvas, index + 1, item),
    );

    // Populated for [MainServiceType.hasTotalProductCount] bookings specifically (a per-piece count
    // distinct from the item-row count above); printed whenever present,
    // not gated to that service type since nothing else sets it.
    final totalProductCount = booking.otherDetails.totalProductCount;
    if (totalProductCount != null && totalProductCount > 0) {
      canvas
        ..divider()
        ..row([
          const ReceiptColumn('Total Product Count:'),
          ReceiptColumn(
            booking.otherDetails.totalProductCount.toString(),
            align: TextAlign.right,
          ),
        ]);
    }
  }

  void _buildItemRow(ReceiptCanvas canvas, int slNo, ProductInfoEntity item) {
    final subtitle = ReceiptSharedSections.itemSubtitle(
      serviceType: item.mainServiceType,
      variantAttribute: item.variantAttribute,
      color: item.color,
      category: item.category,
      model: item.model,
      registrationNumber: item.attributes.registrationNumber,
      quantity: item.quantity,
      fabricLength: item.fabricLength,
    );

    canvas
      ..row([
        ReceiptColumn(slNo.toString(), flex: _slNoFlex),
        ReceiptColumn(item.name, flex: _itemNameFlex, subtitle: subtitle),
        ReceiptColumn(
          item.quantity.toString(),
          flex: _qtyFlex,
          align: TextAlign.right,
        ),
        ReceiptColumn(
          item.amount.toCurrency(symbol: false),
          flex: _amountFlex,
          align: TextAlign.right,
        ),
      ])
      ..spacer(ReceiptCanvas.defaultListRowSpacing);
  }

  void _buildPaymentDetails(
    ReceiptCanvas canvas,
    BookingDetailsEntity booking,
  ) {
    canvas.divider(topSpacing: ReceiptCanvas.defaultSpaceAfterList);
    _buildSecurityDepositRow(canvas, booking);
    _buildChargesBreakdown(canvas, booking);
    canvas.buildGrandTotal(
      'TOTAL: Rs. ${booking.totalPayable.toCurrency(decimalDigits: 2, symbol: false)}',
    );
    _buildPaidRows(canvas, booking);
    _buildBalanceRow(canvas, booking);
  }

  void _buildSecurityDepositRow(
    ReceiptCanvas canvas,
    BookingDetailsEntity booking,
  ) {
    final securityDeposit = booking.securitySummary.securityAmount;
    if (booking.securityPayment == null || securityDeposit <= 0) return;
    canvas.row([
      ReceiptColumn(
        booking.isSecurityPaid
            ? 'Security Deposit'
            : 'Security Deposit (Unpaid)',
      ),
      ReceiptColumn(securityDeposit.toCurrency(), align: TextAlign.right),
    ]);
  }

  /// Product total, plus whichever of additional charges / discount /
  /// taxes actually apply to this booking.
  void _buildChargesBreakdown(
    ReceiptCanvas canvas,
    BookingDetailsEntity booking,
  ) {
    final productTotal = booking.bookedItems.sum((p) => p.amount);
    canvas.row([
      const ReceiptColumn('Product total'),
      ReceiptColumn(productTotal.toCurrency(), align: TextAlign.right),
    ]);

    if (booking.additionalCharges.isNotEmpty) {
      final total = booking.additionalCharges.sum((a) => a.amount ?? 0);
      canvas.row([
        ReceiptColumn(
          'Additional charges (${booking.additionalCharges.length})',
        ),
        ReceiptColumn(total.toCurrency(), align: TextAlign.right),
      ]);
    }

    ReceiptSharedSections.buildDiscountRow(canvas, booking.discountAmount);

    ReceiptSharedSections.buildTaxRows(
      canvas,
      booking.appliedTaxes.appliedOnly,
    );
  }

  void _buildPaidRows(ReceiptCanvas canvas, BookingDetailsEntity booking) {
    canvas.row([
      const ReceiptColumn('Paid'),
      ReceiptColumn(
        (booking.paidAmountWithSecurity ?? 0).toCurrency(),
        align: TextAlign.right,
      ),
    ]);
  }

  void _buildBalanceRow(ReceiptCanvas canvas, BookingDetailsEntity booking) {
    if (booking.deliveryStatus == DeliveryStatus.cancelled) return;
    if (booking.balanceAmount <= 0) return;
    canvas.row([
      const ReceiptColumn('Balance', bold: true),
      ReceiptColumn(
        booking.balanceAmount.toCurrency(),
        align: TextAlign.right,
        bold: true,
      ),
    ]);
  }
}
