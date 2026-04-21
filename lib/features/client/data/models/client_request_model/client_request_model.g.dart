// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClientRequestModel _$ClientRequestModelFromJson(Map<String, dynamic> json) =>
    _ClientRequestModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone1E164: json['phone_1_e164'] as String?,
      phone2E164: json['phone_2_e164'] as String?,
    );

Map<String, dynamic> _$ClientRequestModelToJson(_ClientRequestModel instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'phone_1_e164': ?instance.phone1E164,
      'phone_2_e164': ?instance.phone2E164,
    };
