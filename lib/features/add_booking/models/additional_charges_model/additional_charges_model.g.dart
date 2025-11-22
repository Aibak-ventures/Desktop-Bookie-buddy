// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_charges_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdditionalChargesModelImpl _$$AdditionalChargesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AdditionalChargesModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      amount: _amountFromJson(json['amount']),
    );

Map<String, dynamic> _$$AdditionalChargesModelImplToJson(
        _$AdditionalChargesModelImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'name': instance.name,
      'amount': instance.amount,
    };
