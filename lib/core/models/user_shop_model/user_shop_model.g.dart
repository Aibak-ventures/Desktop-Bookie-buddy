// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserShopModelImpl _$$UserShopModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserShopModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  phone: json['phone'] as String,
  phone2: json['phone2'] as String?,
  address: json['address'] as String,
  gstNumber: json['gst_number'] as String?,
  image: json['image'] as String?,
  place: json['place'] as String?,
  email: json['email'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  pincode: json['pincode'] as String?,
  termsAndConditions:
      (json['terms_and_conditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [
        'No refund will be given after Booking cancellation.',
        'Any damages must be paid by the customer',
        'Confirm your Pickup and return dates properly.',
        'Make sure all your needs are clear before booking.',
        'Security deposit (if applicable) will be refunded after return.',
        'Products should be returned on the exact return date, without any damages.',
      ],
);

Map<String, dynamic> _$$UserShopModelImplToJson(_$UserShopModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'phone2': instance.phone2,
      'address': instance.address,
      'gst_number': instance.gstNumber,
      'image': instance.image,
      'place': instance.place,
      'email': instance.email,
      'city': instance.city,
      'state': instance.state,
      'pincode': instance.pincode,
      'terms_and_conditions': instance.termsAndConditions,
    };
