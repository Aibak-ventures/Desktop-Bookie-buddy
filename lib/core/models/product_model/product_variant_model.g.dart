// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductVariantModelImpl _$$ProductVariantModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductVariantModelImpl(
      id: (json['id'] as num).toInt(),
      attribute: json['attribute'] as String,
      stock: (json['stock'] as num).toInt(),
      remainingStock: (json['remaining_stock'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      salePrice: (json['sale_price'] as num?)?.toInt(),
      externalQrCode: json['external_qr_code'] as String?,
    );

Map<String, dynamic> _$$ProductVariantModelImplToJson(
        _$ProductVariantModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attribute': instance.attribute,
      'stock': instance.stock,
      'remaining_stock': instance.remainingStock,
      'price': instance.price,
      'sale_price': instance.salePrice,
      'external_qr_code': instance.externalQrCode,
    };
