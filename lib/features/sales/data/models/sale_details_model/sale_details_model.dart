import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/client/data/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_details_model.freezed.dart';
part 'sale_details_model.g.dart';

/// Prefers full-size [product_image]; falls back to [thumbnail].
dynamic _readSaleProductImage(Map json, String key) =>
    (json['product_image'] as String?)?.isNotEmpty == true
        ? json['product_image']
        : json['thumbnail'];

int? _readAccountId(Map json, String key) {
  final payments = json['payments'] as List?;
  if (payments == null || payments.isEmpty) return null;
  return (payments.first as Map)['account_id'] as int?;
}

String? _readAccountName(Map json, String key) {
  final payments = json['payments'] as List?;
  if (payments == null || payments.isEmpty) return null;
  return (payments.first as Map)['account_name'] as String?;
}

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
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'discount') required int discountAmount,
    @JsonKey(name: 'paid_amount') required int paidAmount,
    @JsonKey(name: 'shop_sale_id', defaultValue: '') required String invoiceId,
    @JsonKey(name: 'balance_due') required int balanceDueAmount,
    @JsonKey(name: 'items') required List<ProductSaleInfoModel> products,
    @JsonKey(name: 'account_id', readValue: _readAccountId) int? accountId,
    @JsonKey(name: 'account_name', readValue: _readAccountName)
    String? accountName,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
  }) = _SaleDetailsModel;

  factory SaleDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailsModelFromJson(json);
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
    @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
    MainServiceType? mainServiceType,
  }) = _ProductSaleInfoModel;

  factory ProductSaleInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSaleInfoModelFromJson(json);
}

extension SaleDetailsModelMapper on SaleDetailsModel {
  SaleDetailsEntity toEntity() => SaleDetailsEntity(
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
    accountId: accountId,
    accountName: accountName,
    staffId: staffId,
    staffName: staffName,
  );
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
  );
}
