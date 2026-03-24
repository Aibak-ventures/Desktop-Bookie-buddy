import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const ProductEntity._();

  const factory ProductEntity({
    required int id,
    required String name,
    required String? description,
    MainServiceType? mainServiceType,
    String? color,
    String? model,
    String? image,
    String? thumbnailImage,
    String? category,
    int? purchaseAmount,
    int? price,
    String? salePrice,
    String? registrationNumber,
    String? pollutionExpiry,
    String? insuranceExpiry,
    String? fitnessExpiry,
    String? barcode,
    String? generalServiceName,
    @Default({}) Map<String, dynamic> attributes,
    required List<ProductVariantEntity> variants,
  }) = _ProductEntity;

  String? get effectiveRegistrationNumber =>
      registrationNumber ?? attributes['registration_number'] as String?;

  String? get effectivePollutionExpiry =>
      pollutionExpiry ?? attributes['pollution_expiry'] as String?;

  String? get effectiveInsuranceExpiry =>
      insuranceExpiry ?? attributes['insurance_expiry'] as String?;

  String? get effectiveFitnessExpiry =>
      fitnessExpiry ??
      attributes['permit_expiry'] as String? ??
      attributes['fitness_expiry'] as String?;

  String? get effectiveBarcode => barcode ?? attributes['barcode'] as String?;
}
