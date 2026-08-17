// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_attributes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductAttributesModel _$ProductAttributesModelFromJson(
  Map<String, dynamic> json,
) => _ProductAttributesModel(
  pollutionExpiryDate: json['pollution_expiry'] as String?,
  insuranceExpiryDate: json['insurance_expiry'] as String?,
  fitnessExpiryDate: json['permit_expiry'] as String?,
  permitDate: json['transport_permit_expiry'] as String?,
  registrationNumber: json['registration_number'] as String?,
);

Map<String, dynamic> _$ProductAttributesModelToJson(
  _ProductAttributesModel instance,
) => <String, dynamic>{
  'pollution_expiry': ?instance.pollutionExpiryDate,
  'insurance_expiry': ?instance.insuranceExpiryDate,
  'permit_expiry': ?instance.fitnessExpiryDate,
  'transport_permit_expiry': ?instance.permitDate,
  'registration_number': ?instance.registrationNumber,
};
