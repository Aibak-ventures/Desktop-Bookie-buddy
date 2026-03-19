// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServicesModelImpl _$$ServicesModelImplFromJson(Map<String, dynamic> json) =>
    _$ServicesModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['service_name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String?,
      mainServiceName: json['main_service_name'] as String? ?? 'Other',
    );

Map<String, dynamic> _$$ServicesModelImplToJson(_$ServicesModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'main_service_name': instance.mainServiceName,
    };
