import 'package:bookie_buddy_web/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_web/core/common/entities/user_shop_entity/user_shop_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/presentation/receipt_design/receipt_canvas.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

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

  // Font sizes — kept as named constants so the whole receipt can be scaled
  // up/down from one place instead of hunting through every `.text()` call.
  static const double _titleSize = 20;
  static const double _shopDetailsSize = 17;
  static const double _sectionHeadingSize = 18;
  static const double _itemSubtitleSize = 15;
  static const double _totalSize = 30;
  static const double _footerSize = 18;
  static const double _termsAndConditionSize = 15;
  static const double _rowSize = 19;
  static const double _logoHeight = 150;

  Future<PrintTicketEntity> call({
    required BuildContext context,
    required BookingDetailsEntity booking,
    required UserShopEntity shop,
  }) async {
    final canvas = ReceiptCanvas(context: context);

    // Only the header (async logo fetch) and the final call (which flushes
    // everything accumulated since) actually await anything — the sections
    // in between just queue widgets onto the same pending buffer. Rendering
    // them as one combined image instead of five separate ones cuts the
    // per-section cost (offscreen render + isolate spawn for monochrome
    // conversion) from six down to two, which is most of what makes a print
    // feel slow, especially over Bluetooth.
    await _buildHeader(canvas, shop);
    _buildMeta(canvas, booking);
    _buildCustomer(canvas, booking);
    _buildItems(canvas, booking);
    _buildPaymentDetails(canvas, booking);
    await _buildTermsAndFooter(canvas, shop);

    await canvas.cut(linesBefore: 5);
    return canvas.build();
  }

  Future<void> _buildHeader(ReceiptCanvas canvas, UserShopEntity shop) async {
    canvas
      ..text('--- BOOKING RECEIPT ---', center: true, size: _titleSize)
      ..divider();

    if (shop.image != null && shop.image!.trim().isNotEmpty) {
      try {
        await precacheImage(NetworkImage(shop.image!), canvas.context);
        canvas.widget(
          Center(
            child: Image.network(
              shop.image!,
              height: _logoHeight,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        );
      } catch (_) {
        // Logo is a nice-to-have — a failed fetch shouldn't block the
        // whole receipt from printing.
      }
    }

    canvas
      ..text(shop.name, bold: true, center: true, size: _titleSize)
      ..text(shop.fullAddress, center: true, size: _shopDetailsSize);

    if (shop.phone.isNotEmpty)
      canvas.text(
        'PH: ${shop.phone}${shop.phone2.isNotNullOrEmpty ? ', ${shop.phone2}' : ''}',
        center: true,
        size: _shopDetailsSize,
      );
    if (shop.gstNumber != null && shop.gstNumber!.trim().isNotEmpty) {
      canvas.text(
        'GSTIN: ${shop.gstNumber}',
        center: true,
        size: _shopDetailsSize,
      );
    }
    await canvas.flushSection();
  }

  void _buildMeta(ReceiptCanvas canvas, BookingDetailsEntity booking) {
    canvas
      ..divider()
      ..row([
        const ReceiptColumn('Invoice No:'),
        ReceiptColumn(booking.invoiceId, align: TextAlign.right),
      ], size: _rowSize)
      ..row([
        const ReceiptColumn('Staff:'),
        ReceiptColumn(booking.staffName ?? 'N/A', align: TextAlign.right),
      ], size: _rowSize)
      ..row([
        const ReceiptColumn('Purchase Mode:'),
        ReceiptColumn(booking.purchaseMode.label, align: TextAlign.right),
      ], size: _rowSize)
      ..row([
        const ReceiptColumn('Delivery Status:'),
        ReceiptColumn(booking.deliveryStatus.name, align: TextAlign.right),
      ], size: _rowSize)
      ..row([
        const ReceiptColumn('Booked:'),
        ReceiptColumn(
          booking.bookedDate.formatToUiDate(),
          align: TextAlign.right,
        ),
      ], size: _rowSize);
    if (booking.pickupDate != null) {
      canvas.row([
        const ReceiptColumn('Pickup:'),
        ReceiptColumn(
          _dateAndMaybeTime(booking.pickupDate!, booking.pickupTime),
          align: TextAlign.right,
        ),
      ], size: _rowSize);
    }
    canvas.row([
      const ReceiptColumn('Return:'),
      ReceiptColumn(
        _dateAndMaybeTime(booking.returnDate, booking.returnTime),
        align: TextAlign.right,
      ),
    ], size: _rowSize);
  }

  /// Date, plus a time only when one is actually available — no "N/A"
  /// filler when there isn't.
  String _dateAndMaybeTime(String date, String? time) {
    final formattedDate = date.formatToUiDate();
    if (time == null || time.trim().isEmpty) return formattedDate;
    return '$formattedDate, $time';
  }

  void _buildCustomer(ReceiptCanvas canvas, BookingDetailsEntity booking) {
    canvas
      ..divider()
      ..row([
        const ReceiptColumn('Customer:'),
        ReceiptColumn(booking.client.name, align: TextAlign.right),
      ], size: _rowSize)
      ..row([
        const ReceiptColumn('Phone:'),
        ReceiptColumn(booking.client.phone1E164.orNA(), align: TextAlign.right),
        if (booking.client.phone2E164 != null &&
            booking.client.phone2E164!.trim().isNotEmpty)
          ReceiptColumn(
            booking.client.phone2E164.orNA(),
            align: TextAlign.right,
          ),
      ], size: _rowSize);
  }

  void _buildItems(ReceiptCanvas canvas, BookingDetailsEntity booking) {
    canvas
      ..divider()
      ..row([
        const ReceiptColumn('Item', flex: 56, bold: true),
        const ReceiptColumn(
          'Qty',
          flex: 14,
          align: TextAlign.right,
          bold: true,
        ),
        const ReceiptColumn(
          'Amount',
          flex: 30,
          align: TextAlign.right,
          bold: true,
        ),
      ], size: _rowSize)
      ..divider(heavy: true);

    for (final item in booking.bookedItems) {
      canvas.row([
        ReceiptColumn(item.name, flex: 56),
        ReceiptColumn(
          item.quantity.toString(),
          flex: 14,
          align: TextAlign.right,
        ),
        ReceiptColumn(
          item.amount.toCurrency(symbol: false),
          flex: 30,
          align: TextAlign.right,
        ),
      ], size: _rowSize);
      final subtitle = [
        item.category,
        item.color,
        item.variantAttribute,
        item.model,
      ].where((s) => s != null && s.trim().isNotEmpty).join(' · ');
      if (subtitle.isNotEmpty) {
        canvas.text(subtitle, size: _itemSubtitleSize);
      }
    }
  }

  void _buildPaymentDetails(
    ReceiptCanvas canvas,
    BookingDetailsEntity booking,
  ) {
    canvas.divider(heavy: true);

    final productTotal = booking.bookedItems.fold<int>(
      0,
      (sum, item) => sum + item.amount,
    );
    canvas.row([
      const ReceiptColumn('Product total'),
      ReceiptColumn(productTotal.toCurrency(), align: TextAlign.right),
    ], size: _rowSize);

    if (booking.additionalCharges.isNotEmpty) {
      final total = booking.additionalCharges.fold<int>(
        0,
        (sum, charge) => sum + (charge.amount ?? 0),
      );
      canvas.row([
        ReceiptColumn(
          'Additional charges (${booking.additionalCharges.length})',
        ),
        ReceiptColumn(total.toCurrency(), align: TextAlign.right),
      ], size: _rowSize);
    }

    if (booking.discountAmount != null && booking.discountAmount! > 0) {
      canvas.row([
        const ReceiptColumn('Discount'),
        ReceiptColumn(
          '-${booking.discountAmount?.toCurrency()}',
          align: TextAlign.right,
        ),
      ], size: _rowSize);
    }

    final appliedTaxes = booking.appliedTaxes.appliedOnly;
    if (appliedTaxes.isNotEmpty) {
      canvas.divider();
      for (final tax in appliedTaxes) {
        canvas.row([
          ReceiptColumn(tax.formattedTaxLabel),
          ReceiptColumn(tax.taxAmount.toCurrency(), align: TextAlign.right),
        ], size: _rowSize);
      }
    }

    canvas
      ..divider()
      ..row([
        const ReceiptColumn('Total payable', bold: true),
        ReceiptColumn(
          booking.totalPayable.toCurrency(),
          align: TextAlign.right,
          bold: true,
        ),
      ], size: _rowSize)
      ..row([
        const ReceiptColumn('Paid'),
        ReceiptColumn(
          (booking.paidAmountWithSecurity ?? 0).toCurrency(),
          align: TextAlign.right,
        ),
      ], size: _rowSize);

    if (booking.deliveryStatus != DeliveryStatus.cancelled &&
        booking.balanceAmount > 0) {
      canvas.row([
        const ReceiptColumn('Balance'),
        ReceiptColumn(
          booking.balanceAmount.toCurrency(),
          align: TextAlign.right,
        ),
      ], size: _rowSize);
    }

    canvas
      ..divider(heavy: true)
      ..text(
        'TOTAL: Rs.${booking.totalPayable.toStringAsFixed(2)}',
        bold: true,
        center: true,
        size: _totalSize,
      );
  }

  Future<void> _buildTermsAndFooter(
    ReceiptCanvas canvas,
    UserShopEntity shop,
  ) async {
    canvas.divider();
    if (shop.termsAndConditions.isNotEmpty) {
      canvas
        ..text('Terms & Conditions', bold: true, size: _sectionHeadingSize)
        ..numberedList(shop.termsAndConditions, size: _termsAndConditionSize);
    }

    canvas
      ..spacer(6)
      ..text('Thank you for your booking!', center: true, size: _footerSize);
    await canvas.flushSection();
  }
}
