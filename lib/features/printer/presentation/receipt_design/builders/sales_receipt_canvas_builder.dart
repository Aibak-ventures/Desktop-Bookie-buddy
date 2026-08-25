import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bookie_buddy_core/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_core/core/common/entities/user_shop_entity/user_shop_entity.dart';
import '../../../../../utils/extensions/list_extensions.dart';
import '../../../../../utils/extensions/number_extensions.dart';
import '../../../../../utils/extensions/string_extensions.dart';
import '../../../../sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import '../../../domain/entities/print_ticket_entity/print_ticket_entity.dart';
import '../shared/receipt_canvas.dart';
import '../shared/receipt_date_formatter.dart';
import '../shared/receipt_shared_sections.dart';
import '../shared/shop_receipt_sections.dart';

class SalesReceiptCanvasBuilder {
  const SalesReceiptCanvasBuilder();

  // Column widths for the items table — shared with every other
  // line-item receipt so they can't drift out of alignment with each
  // other. See [ReceiptSharedSections]. [_totalFlex] is sales-only (an
  // extra "Total" column booking receipts don't have).
  static const int _slNoFlex = ReceiptSharedSections.slNoFlex;
  static const int _itemNameFlex = ReceiptSharedSections.itemNameFlex;
  static const int _qtyFlex = ReceiptSharedSections.qtyFlex;
  static const int _amountFlex = ReceiptSharedSections.amountFlex;
  static const int _totalFlex = 30;

  Future<PrintTicketEntity> call({
    required BuildContext context,
    required SaleDetailsEntity sale,
    required UserShopEntity shop,
  }) async {
    final canvas = ReceiptCanvas(context: context);

    await ShopReceiptSections.buildHeader(
      canvas,
      shop,
      heading: '--- SALES BILL ---',
    );
    _buildMeta(canvas, sale);
    _buildCustomer(canvas, sale);
    _buildItems(canvas, sale);
    _buildPaymentDetails(canvas, sale);
    await ShopReceiptSections.buildTermsAndFooter(
      canvas,
      termsAndConditions: shop.termsAndConditions.isNotEmpty
          ? shop.termsAndConditions
          : shop.defaultSalesTermsAndConditions,
      closingMessage: 'Thank you for your purchase!',
    );

    await canvas.cut();
    return canvas.build();
  }

  void _buildMeta(ReceiptCanvas canvas, SaleDetailsEntity sale) {
    canvas
      ..divider()
      ..row([
        const ReceiptColumn('Invoice No:'),
        ReceiptColumn(sale.invoiceId, align: TextAlign.right),
      ])
      ..row([
        const ReceiptColumn('Staff:'),
        ReceiptColumn(sale.staffName ?? 'N/A', align: TextAlign.right),
      ])
      ..row([
        const ReceiptColumn('Date:'),
        ReceiptColumn(
          ReceiptDateFormatter.dateAndMaybeTime(
            sale.saleDate,
            sale.createdAt.isNotNullOrEmpty
                ? ReceiptDateFormatter.safeTime(sale.createdAt)
                : null,
          ),
          align: TextAlign.right,
        ),
      ]);
  }

  void _buildCustomer(ReceiptCanvas canvas, SaleDetailsEntity sale) {
    // `clientPhone` is `dynamic` on the entity, so we need to cast to String
    final clientPhone = sale.clientPhone as String?;
    final hasClientPh = clientPhone.isNotNullOrEmpty;
    final hasAddress = sale.address.isNotNullOrEmpty;

    if (hasClientPh || hasAddress) canvas.divider();

    if (hasClientPh) {
      canvas.row([
        const ReceiptColumn('Phone:'),
        ReceiptColumn(clientPhone!, align: TextAlign.right),
      ]);
    }

    if (hasAddress) {
      canvas.row([
        const ReceiptColumn('Address:'),
        ReceiptColumn(sale.address, align: TextAlign.right),
      ]);
    }
  }

  void _buildItems(ReceiptCanvas canvas, SaleDetailsEntity sale) {
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
          'Price',
          flex: _amountFlex,
          align: TextAlign.right,
          bold: true,
        ),
        const ReceiptColumn(
          'Total',
          flex: _totalFlex,
          align: TextAlign.right,
          bold: true,
        ),
      ])
      ..divider(heavy: true);

    for (var i = 0; i < sale.products.length; i++) {
      _buildItemRow(canvas, i + 1, sale.products[i]);
    }
  }

  void _buildItemRow(
    ReceiptCanvas canvas,
    int slNo,
    ProductSaleInfoEntity item,
  ) {
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
          item.price.toCurrency(symbol: false),
          flex: _amountFlex,
          align: TextAlign.right,
        ),
        ReceiptColumn(
          item.subtotal.toCurrency(symbol: false),
          flex: _totalFlex,
          align: TextAlign.right,
        ),
      ])
      ..spacer(ReceiptCanvas.defaultListRowSpacing);
  }

  void _buildPaymentDetails(ReceiptCanvas canvas, SaleDetailsEntity sale) {
    canvas.divider(topSpacing: ReceiptCanvas.defaultSpaceAfterList);
    _buildChargesBreakdown(canvas, sale);
    canvas.buildGrandTotal(
      'TOTAL: Rs. ${sale.totalAmount.toCurrency(decimalDigits: 2, symbol: false)}',
    );
    _buildPaymentMethod(canvas, sale);
  }

  /// Product total, plus whichever of discount / taxes actually apply to
  /// this sale. Summed from the line items themselves (same approach the
  /// booking receipt uses) rather than trusting a separate API total, so
  /// it can never drift from what's actually printed above it.
  void _buildChargesBreakdown(ReceiptCanvas canvas, SaleDetailsEntity sale) {
    final productTotal = sale.products.sum((p) => p.subtotal);
    canvas.row([
      const ReceiptColumn('Product total'),
      ReceiptColumn(productTotal.toCurrency(), align: TextAlign.right),
    ]);

    ReceiptSharedSections.buildDiscountRow(canvas, sale.discountAmount);

    ReceiptSharedSections.buildTaxRows(canvas, sale.appliedTaxes.appliedOnly);
  }

  void _buildPaymentMethod(ReceiptCanvas canvas, SaleDetailsEntity sale) {
    if (sale.paymentMethod == null) return;
    canvas.row([
      const ReceiptColumn('Payment Method:'),
      ReceiptColumn(sale.paymentMethod!.name, align: TextAlign.right),
    ]);
  }
}
