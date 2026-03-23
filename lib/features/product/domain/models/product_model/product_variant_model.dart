import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_variant_model.freezed.dart';
part 'product_variant_model.g.dart';

@freezed
abstract class ProductVariantModel with _$ProductVariantModel {
  const factory ProductVariantModel({
    required int id,

    /// E.g. "S, L, XL, XXL"
    required String attribute,
    required int stock,
    @JsonKey(name: 'remaining_stock') int? remainingStock,
    @JsonKey(
      name: 'price',
    )
    int? price,
    @JsonKey(name: 'sale_price') int? salePrice,
    @JsonKey(name: 'external_qr_code') String? externalQrCode,
  }) = _ProductVariantModel;

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);
}

extension ProductVariantModelExtension on ProductVariantModel {
  /// Converts only attribute, stock, and external_qr_code fields of this ProductVariantModel to a JSON map.
  Map<String, dynamic> toJsonOnly() => {
        'attribute': attribute,
        'stock': stock,
        if (externalQrCode != null && externalQrCode!.isNotEmpty)
          'external_qr_code': externalQrCode,
      };
}
