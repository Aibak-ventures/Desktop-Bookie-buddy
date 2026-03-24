import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_variant_entity.freezed.dart';

@freezed
abstract class ProductVariantEntity with _$ProductVariantEntity {
  const factory ProductVariantEntity({
    required int id,
    required String attribute,
    required int stock,
    int? remainingStock,
    int? price,
    int? salePrice,
    String? externalQrCode,
  }) = _ProductVariantEntity;
}
