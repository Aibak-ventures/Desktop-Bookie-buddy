// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) =>
    _ServicesModel(
      id: (json['id'] as num).toInt(),
      name: json['service_name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String?,
      mainServiceName: json['main_service_name'] as String? ?? 'Other',
    );

Map<String, dynamic> _$ServicesModelToJson(_ServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'main_service_name': instance.mainServiceName,
    };
