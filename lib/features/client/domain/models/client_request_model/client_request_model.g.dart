// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientRequestModelImpl _$$ClientRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientRequestModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone1: (json['phone_1'] as num?)?.toInt(),
      phone2: (json['phone_2'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ClientRequestModelImplToJson(
        _$ClientRequestModelImpl instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.phone1 case final value?) 'phone_1': value,
      if (instance.phone2 case final value?) 'phone_2': value,
    };
