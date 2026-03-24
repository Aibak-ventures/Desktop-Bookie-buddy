// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_other_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingOtherDetailsModel _$BookingOtherDetailsModelFromJson(
  Map<String, dynamic> json,
) => _BookingOtherDetailsModel(
  locationStart: json['location_start'] as String?,
  locationFrom: json['location_from'] as String?,
  locationTo: json['location_to'] as String?,
  end: json['end'] as String?,
);

Map<String, dynamic> _$BookingOtherDetailsModelToJson(
  _BookingOtherDetailsModel instance,
) => <String, dynamic>{
  'location_start': ?instance.locationStart,
  'location_from': ?instance.locationFrom,
  'location_to': ?instance.locationTo,
  'end': ?instance.end,
};
