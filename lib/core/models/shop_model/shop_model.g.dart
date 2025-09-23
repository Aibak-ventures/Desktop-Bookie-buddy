// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopModelImpl _$$ShopModelImplFromJson(Map<String, dynamic> json) =>
    _$ShopModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      place: json['place'] as String?,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      address: json['address'] as String? ?? 'Address not available',
      pincode: json['pincode'] as String?,
      subscriptionStatus: json['subscription_status'] as String?,
      image: json['img'] as String?,
    );

Map<String, dynamic> _$$ShopModelImplToJson(_$ShopModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'place': instance.place,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'pincode': instance.pincode,
      'subscription_status': instance.subscriptionStatus,
      'img': instance.image,
    };
