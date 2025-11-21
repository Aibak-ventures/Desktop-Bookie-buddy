import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_details_model.freezed.dart';
part 'sale_details_model.g.dart';

String _paymentMethodReadValue(Map json, String key) {
  final payments = json['payments'] as List?;

  if (payments == null || payments.firstOrNull == null)
    return PaymentMethod.cash.toString();

  final fistPayment = payments.first;
  return (fistPayment as Map)[key];
}

@freezed
class SaleDetailsModel with _$SaleDetailsModel {
  const factory SaleDetailsModel({
    required int id,
    @JsonKey(name: 'client') required ClientModel client,
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
    @JsonKey(
      name: 'method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson,
      readValue: _paymentMethodReadValue,
    )
    @Default(PaymentMethod.cash)
    PaymentMethod paymentMethod,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
  }) = _SaleDetailsModel;

  factory SaleDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailsModelFromJson(json);
}

@freezed
class ProductSaleInfoModel with _$ProductSaleInfoModel {
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
