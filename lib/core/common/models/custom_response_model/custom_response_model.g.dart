// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomResponseModel _$CustomResponseModelFromJson(Map<String, dynamic> json) =>
    _CustomResponseModel(
      status: CustomResponseStatus.fromString(json['status'] as String),
      message: json['message'] as String? ?? '',
      devMessage: json['dev_message'] ?? '',
      meta: json['meta'],
      data: json['data'],
    );

Map<String, dynamic> _$CustomResponseModelToJson(
  _CustomResponseModel instance,
) => <String, dynamic>{
  'status': CustomResponseStatus.toJson(instance.status),
  'message': instance.message,
  'dev_message': instance.devMessage,
  'meta': ?instance.meta,
  'data': instance.data,
};
