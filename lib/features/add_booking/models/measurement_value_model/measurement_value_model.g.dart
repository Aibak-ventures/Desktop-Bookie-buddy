// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeasurementValueModelImpl _$$MeasurementValueModelImplFromJson(
  Map<String, dynamic> json,
) => _$MeasurementValueModelImpl(
  name: json['name'] as String,
  key: json['key'] as String,
  value: json['value'] as String,
  gender: $enumDecodeNullable(_$GenderTypeEnumMap, json['gender']),
);

Map<String, dynamic> _$$MeasurementValueModelImplToJson(
  _$MeasurementValueModelImpl instance,
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
