// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_charges_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdditionalChargesModel _$AdditionalChargesModelFromJson(
  Map<String, dynamic> json,
) => _AdditionalChargesModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  amount: _amountFromJson(json['amount']),
);

Map<String, dynamic> _$AdditionalChargesModelToJson(
  _AdditionalChargesModel instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'name': instance.name,
  'amount': instance.amount,
};
