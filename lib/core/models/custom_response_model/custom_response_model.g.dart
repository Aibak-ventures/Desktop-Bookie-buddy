// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomResponseModelImpl _$$CustomResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomResponseModelImpl(
      status: CustomResponseStatus.fromString(json['status'] as String),
      message: json['message'] as String,
      devMessage: json['dev_message'] ?? '',
      meta: json['meta'],
      data: json['data'],
    );

Map<String, dynamic> _$$CustomResponseModelImplToJson(
        _$CustomResponseModelImpl instance) =>
    <String, dynamic>{
      'status': CustomResponseStatus.toJson(instance.status),
      'message': instance.message,
      'dev_message': instance.devMessage,
      if (instance.meta case final value?) 'meta': value,
      'data': instance.data,
    };
