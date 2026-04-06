import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'product_request_entity.freezed.dart';

@freezed
abstract class ProductRequestEntity with _$ProductRequestEntity {
  const factory ProductRequestEntity({
    int? productId,
    int? serviceId,
    String? name,
    String? description,
    String? color,
    int? purchasePrice,
    int? price,
    int? salePrice,
    String? category,
    String? model,
    String? registrationNumber,
    String? pollutionExpiry,
    String? insuranceExpiry,
    String? fitnessExpiry,
    String? barcode,
    List<ProductVariantEntity>? variants,
    XFile? image,
  }) = _ProductRequestEntity;
}
