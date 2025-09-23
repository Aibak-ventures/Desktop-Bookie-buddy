// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      userName: json['full_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      shopId: (json['shop_id'] as num?)?.toInt(),
      shopName: json['shop_name'] as String? ?? 'Shop',
      shopPhone: json['shop_phone'] as String? ?? '9999999999',
      shopAddress: json['shop_address'] as String? ?? 'Address',
      gstNo: json['gst_number'] as String?,
      shopeImage: json['shop_image'] as String?,
      termsAndConditions: (json['terms_and_conditions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      block: json['block'] as bool? ?? false,
      haveMultipleShops: json['multiple_shops'] as bool? ?? false,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.userName,
      'phone': instance.phone,
      'email': instance.email,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_phone': instance.shopPhone,
      'shop_address': instance.shopAddress,
      'gst_number': instance.gstNo,
      'shop_image': instance.shopeImage,
      'terms_and_conditions': instance.termsAndConditions,
      'block': instance.block,
      'multiple_shops': instance.haveMultipleShops,
      'role': instance.role,
    };
