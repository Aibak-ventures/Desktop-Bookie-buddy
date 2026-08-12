// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrinterDeviceModel _$PrinterDeviceModelFromJson(Map<String, dynamic> json) =>
    _PrinterDeviceModel(
      name: json['name'] as String,
      onlineStatus:
          $enumDecodeNullable(
            _$PrinterOnlineStatusEnumMap,
            json['onlineStatus'],
          ) ??
          PrinterOnlineStatus.unknown,
    );

Map<String, dynamic> _$PrinterDeviceModelToJson(_PrinterDeviceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'onlineStatus': _$PrinterOnlineStatusEnumMap[instance.onlineStatus]!,
    };

const _$PrinterOnlineStatusEnumMap = {
  PrinterOnlineStatus.unknown: 'unknown',
  PrinterOnlineStatus.online: 'online',
  PrinterOnlineStatus.offline: 'offline',
};
