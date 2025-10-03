// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffRequestModelImpl _$$StaffRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$StaffRequestModelImpl(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phoneNumber: json['phone'] as String?,
);

Map<String, dynamic> _$$StaffRequestModelImplToJson(
  _$StaffRequestModelImpl instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.phoneNumber case final value?) 'phone': value,
};
