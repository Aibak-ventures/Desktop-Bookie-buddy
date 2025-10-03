// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_other_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingOtherDetailsModelImpl _$$BookingOtherDetailsModelImplFromJson(
  Map<String, dynamic> json,
) => _$BookingOtherDetailsModelImpl(
  locationStart: json['location_start'] as String?,
  locationFrom: json['location_from'] as String?,
  locationTo: json['location_to'] as String?,
);

Map<String, dynamic> _$$BookingOtherDetailsModelImplToJson(
  _$BookingOtherDetailsModelImpl instance,
) => <String, dynamic>{
  if (instance.locationStart case final value?) 'location_start': value,
  if (instance.locationFrom case final value?) 'location_from': value,
  if (instance.locationTo case final value?) 'location_to': value,
};
