// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthLoginResponseImpl _$$AuthLoginResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthLoginResponseImpl(
      status: json['status'] as String,
      message: json['message'] as String,
      data: AuthLoginData.fromJson(json['data'] as Map<String, dynamic>),
      devMessage: json['devMessage'] as String? ?? '',
    );

Map<String, dynamic> _$$AuthLoginResponseImplToJson(
        _$AuthLoginResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'devMessage': instance.devMessage,
    };

_$AuthLoginDataImpl _$$AuthLoginDataImplFromJson(Map<String, dynamic> json) =>
    _$AuthLoginDataImpl(
      refresh: json['refresh'] as String,
      access: json['access'] as String,
    );

Map<String, dynamic> _$$AuthLoginDataImplToJson(_$AuthLoginDataImpl instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
    };
