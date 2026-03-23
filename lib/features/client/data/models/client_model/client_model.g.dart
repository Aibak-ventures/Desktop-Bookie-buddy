// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientModelImpl _$$ClientModelImplFromJson(Map<String, dynamic> json) =>
    _$ClientModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: _readName(json, 'name') as String,
      phone1: (_readPhone1(json, 'phone_1') as num).toInt(),
      phone2: (_readPhone2(json, 'phone_2') as num?)?.toInt(),
      phone1E164: _readPhone1E164(json, 'phone_1_e164') as String?,
      phone2E164: _readPhone2E164(json, 'phone_2_e164') as String?,
    );

Map<String, dynamic> _$$ClientModelImplToJson(_$ClientModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone_1': instance.phone1,
      'phone_2': instance.phone2,
      'phone_1_e164': instance.phone1E164,
      'phone_2_e164': instance.phone2E164,
    };
