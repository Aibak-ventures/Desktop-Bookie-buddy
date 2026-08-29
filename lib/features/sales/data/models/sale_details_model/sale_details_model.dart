import 'package:bookie_buddy_core/core/constants/enums/payment_method_enums.dart';
import 'package:collection/collection.dart';

import 'package:bookie_buddy_web/core/common/models/applied_tax_model/applied_tax_model.dart';
import 'package:bookie_buddy_core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_web/features/client/data/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_attributes_model/product_attributes_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_details_model.freezed.dart';
part 'sale_details_model.g.dart';

@freezed
abstract class SaleDetailsModel with _$SaleDetailsModel {
  const factory SaleDetailsModel({
    required int id,
    @JsonKey(name: 'client') ClientModel? client,
    @JsonKey(name: 'client_phone') dynamic clientPhone,
    @JsonKey(name: 'address', defaultValue: '') required String address,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'sale_date') required String saleDate,
    @JsonKey(name: 'created_at', defaultValue: '') required String createdAt,
    // The sale-details endpoint sends both `total_amount` (pre-discount)
    // and `total_amount_after_discount` — this entity's `totalAmount` is
    // meant to be what's actually payable, so it has to read the latter
    // (mirrors mobile; the sales *list* endpoint's `SaleModel` has no such
    // split and correctly keeps reading plain `total_amount`).
    @JsonKey(name: 'total_amount_after_discount') required int totalAmount,
    @JsonKey(name: 'discount') required int discountAmount,
    @JsonKey(name: 'paid_amount') required int paidAmount,
    @JsonKey(name: 'shop_sale_id', defaultValue: '') required String invoiceId,
    @JsonKey(name: 'balance_due') required int balanceDueAmount,
    @JsonKey(name: 'items') required List<ProductSaleInfoModel> products,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'payments')
    @Default([])
    List<SaleDetailsPaymentHistoryModel> paymentHistory,
    // Same `tax` shape as booking/custom work; modeled as a list so a future
    // multi-tax API response needs no changes beyond
    // AppliedTaxModel.listFromJson.
    @JsonKey(name: 'tax', fromJson: AppliedTaxModel.listFromJson)
    @Default([])
    List<AppliedTaxModel> appliedTaxes,
  }) = _SaleDetailsModel;

  factory SaleDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailsModelFromJson(json);
}

@freezed
abstract class SaleDetailsPaymentHistoryModel
    with _$SaleDetailsPaymentHistoryModel {
  const factory SaleDetailsPaymentHistoryModel({
    @JsonKey(name: 'account_id') int? accountId,
    @JsonKey(name: 'account_name') String? accountName,
    @JsonKey(name: 'method', toJson: PaymentMethod.toJson)
    PaymentMethod? paymentMethod,
  }) = _SaleDetailsPaymentHistoryModel;

  factory SaleDetailsPaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailsPaymentHistoryModelFromJson(json);
}

@freezed
abstract class ProductSaleInfoModel with _$ProductSaleInfoModel {
  const factory ProductSaleInfoModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'variant_id') required int variantId,
    @JsonKey(name: 'product_name') required String name,
    @JsonKey(name: 'variant') String? variantAttribute,
    @JsonKey(name: 'quantity') required int quantity,
    @JsonKey(name: 'price') required int price,
    @JsonKey(name: 'subtotal') required int subtotal,
    @JsonKey(name: 'thumbnail') String? image,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'model') String? model,
    @JsonKey(
      name: 'main_category_name',
      fromJson: MainServiceType.fromString,
      toJson: MainServiceType.toJson,
    )
    MainServiceType? mainServiceType,
    @JsonKey(name: 'fabric_length', defaultValue: 0.0)
    @Default(0.0)
    double fabricLength,
    @JsonKey(name: 'attributes')
    @Default(ProductAttributesModel())
    ProductAttributesModel attributes,
  }) = _ProductSaleInfoModel;

  factory ProductSaleInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSaleInfoModelFromJson(json);
}

extension SaleDetailsModelMapper on SaleDetailsModel {
  SaleDetailsEntity toEntity() {
    // The API returns a full payment history, but a sale's account/payment
    // method are only ever shown as a single value on the receipt/details
    // screen — the first (most recent) payment is the one that reflects
    // that, same as mobile.
    final firstPayment = paymentHistory.firstOrNull;
    return SaleDetailsEntity(
      id: id,
      client: client?.toEntity(),
      clientPhone: clientPhone,
      address: address,
      description: description,
      saleDate: saleDate,
      createdAt: createdAt,
      totalAmount: totalAmount,
      discountAmount: discountAmount,
      paidAmount: paidAmount,
      invoiceId: invoiceId,
      balanceDueAmount: balanceDueAmount,
      products: products.map((e) => e.toEntity()).toList(),
      accountId: firstPayment?.accountId,
      accountName: firstPayment?.accountName,
      staffId: staffId,
      staffName: staffName,
      paymentMethod: firstPayment?.paymentMethod,
      appliedTaxes: appliedTaxes.map((e) => e.toEntity()).toList(),
    );
  }
}

extension ProductSaleInfoModelMapper on ProductSaleInfoModel {
  ProductSaleInfoEntity toEntity() => ProductSaleInfoEntity(
    id: id,
    productId: productId,
    variantId: variantId,
    name: name,
    variantAttribute: variantAttribute,
    quantity: quantity,
    price: price,
    subtotal: subtotal,
    image: image,
    color: color,
    category: category,
    model: model,
    mainServiceType: mainServiceType,
    fabricLength: fabricLength,
    attributes: attributes.toEntity(),
  );
}
