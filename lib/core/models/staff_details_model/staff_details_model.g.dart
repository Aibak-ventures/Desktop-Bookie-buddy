// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffDetailsModelImpl _$$StaffDetailsModelImplFromJson(
  Map<String, dynamic> json,
) => _$StaffDetailsModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  phoneNumber: json['phone'] as String,
  createdAt: json['created_at'] as String? ?? '',
);

Map<String, dynamic> _$$StaffDetailsModelImplToJson(
  _$StaffDetailsModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phoneNumber,
  'created_at': instance.createdAt,
};
