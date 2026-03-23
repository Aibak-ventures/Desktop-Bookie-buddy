// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClientRequestModel _$ClientRequestModelFromJson(Map<String, dynamic> json) =>
    _ClientRequestModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone1: (json['phone_1'] as num?)?.toInt(),
      phone2: (json['phone_2'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClientRequestModelToJson(_ClientRequestModel instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'phone_1': ?instance.phone1,
      'phone_2': ?instance.phone2,
    };
