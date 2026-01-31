// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AvailableShopModelImpl _$$AvailableShopModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AvailableShopModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      place: json['place'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String,
      gstNumber: json['gst_number'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
      subscriptionStatus: json['subscription_status'] as String?,
      subscribedDate: json['subscribed_date'] as String?,
      renewalDueDate: json['renewal_due_date'] as String?,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$$AvailableShopModelImplToJson(
        _$AvailableShopModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'place': instance.place,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'gst_number': instance.gstNumber,
      'city': instance.city,
      'state': instance.state,
      'pincode': instance.pincode,
      'subscription_status': instance.subscriptionStatus,
      'subscribed_date': instance.subscribedDate,
      'renewal_due_date': instance.renewalDueDate,
      'img': instance.img,
    };
