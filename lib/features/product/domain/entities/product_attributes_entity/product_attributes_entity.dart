import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_attributes_entity.freezed.dart';

/// Vehicle-specific compliance document details — only populated for
/// [MainServiceType.vehicle] products; every other service type leaves
/// this at its all-null default.
@freezed
abstract class ProductAttributesEntity with _$ProductAttributesEntity {
  const factory ProductAttributesEntity({
    String? pollutionExpiryDate,
    String? insuranceExpiryDate,
    String? fitnessExpiryDate,
    String? permitDate,
    String? registrationNumber,
  }) = _ProductAttributesEntity;

  static const empty = ProductAttributesEntity();
}
