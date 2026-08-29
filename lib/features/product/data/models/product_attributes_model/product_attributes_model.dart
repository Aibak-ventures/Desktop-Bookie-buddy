import 'package:bookie_buddy_core/features/product/domain/entities/product_entity/product_attributes_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_attributes_model.freezed.dart';
part 'product_attributes_model.g.dart';

@freezed
abstract class ProductAttributesModel with _$ProductAttributesModel {
  @JsonSerializable(includeIfNull: false)
  const factory ProductAttributesModel({
    @JsonKey(name: 'pollution_expiry') String? pollutionExpiryDate,
    @JsonKey(name: 'insurance_expiry') String? insuranceExpiryDate,
    @JsonKey(name: 'permit_expiry') String? fitnessExpiryDate,
    @JsonKey(name: 'transport_permit_expiry') String? permitDate,
    @JsonKey(name: 'registration_number') String? registrationNumber,
  }) = _ProductAttributesModel;

  factory ProductAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributesModelFromJson(json);

  factory ProductAttributesModel.fromEntity(ProductAttributesEntity entity) =>
      ProductAttributesModel(
        pollutionExpiryDate: entity.pollutionExpiryDate,
        insuranceExpiryDate: entity.insuranceExpiryDate,
        fitnessExpiryDate: entity.fitnessExpiryDate,
        permitDate: entity.permitDate,
        registrationNumber: entity.registrationNumber,
      );
}

extension ProductAttributesModelMapper on ProductAttributesModel {
  ProductAttributesEntity toEntity() => ProductAttributesEntity(
    pollutionExpiryDate: pollutionExpiryDate,
    insuranceExpiryDate: insuranceExpiryDate,
    fitnessExpiryDate: fitnessExpiryDate,
    permitDate: permitDate,
    registrationNumber: registrationNumber,
  );
}
