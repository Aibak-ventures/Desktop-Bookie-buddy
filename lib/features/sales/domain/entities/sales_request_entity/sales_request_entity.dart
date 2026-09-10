import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_shared/core/features/sales/domain/entities/sales_payment_request_entity/sales_payment_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_request_entity.freezed.dart';

@freezed
abstract class SalesRequestEntity with _$SalesRequestEntity {
  const factory SalesRequestEntity({
    int? id,
    int? staffId,
    String? clientPhone,
    String? address,
    String? saleDate,
    List<ProductSelectedEntity>? products,
    bool? stockCountDecrease,
    String? description,
    int? discountAmount,
    int? paidAmount,
    // Replaces the old single `accountId` — the backend now takes a
    // `payments` array (1 or 2 entries) so a sale's total can be split
    // across a cash and a bank/UPI account. See
    // AddOrEditSalesFormStateController.buildRequest / SalesSplitPayment
    // for how this is assembled.
    List<SalesPaymentRequestEntity>? payments,
    @Default(false) bool sendPdfToWhatsApp,
  }) = _SalesRequestEntity;
}
