// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StaffRequestModel _$StaffRequestModelFromJson(Map<String, dynamic> json) =>
    _StaffRequestModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phoneNumber: json['phone'] as String?,
    );

Map<String, dynamic> _$StaffRequestModelToJson(_StaffRequestModel instance) =>
    <String, dynamic>{'name': ?instance.name, 'phone': ?instance.phoneNumber};
