// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthLoginModelImpl _$$AuthLoginModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthLoginModelImpl(
      phone: json['phone'] as String,
      password: json['password'] as String,
      deviceToken: json['deviceToken'] as String? ?? 'fcm_device_token_123456',
      platform: json['platform'] as String? ?? 'android',
    );

Map<String, dynamic> _$$AuthLoginModelImplToJson(
        _$AuthLoginModelImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
      'deviceToken': instance.deviceToken,
      'platform': instance.platform,
    };
