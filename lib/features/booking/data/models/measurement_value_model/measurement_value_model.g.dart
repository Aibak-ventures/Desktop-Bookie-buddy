// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeasurementValueModel _$MeasurementValueModelFromJson(
  Map<String, dynamic> json,
) => _MeasurementValueModel(
  name: json['name'] as String,
  key: json['key'] as String,
  value: json['value'] as String,
  gender: $enumDecodeNullable(_$GenderTypeEnumMap, json['gender']),
);

Map<String, dynamic> _$MeasurementValueModelToJson(
  _MeasurementValueModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'key': instance.key,
  'value': instance.value,
  'gender': _$GenderTypeEnumMap[instance.gender],
};

const _$GenderTypeEnumMap = {
  GenderType.male: 'male',
  GenderType.female: 'female',
  GenderType.unisex: 'unisex',
};
