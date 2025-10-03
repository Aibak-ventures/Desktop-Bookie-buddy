// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      mainServiceType: MainServiceType.fromString(
        json['main_service_name'] as String?,
      ),
      color: json['color'] as String?,
      model: json['model'] as String?,
      image: json['image'] as String?,
      thumbnailImage: json['thumbnail_image'] as String?,
      category: json['category'] as String?,
      purchaseAmount: (json['purchase_price'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      variants: (json['variants'] as List<dynamic>)
          .map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'main_service_name': _$MainServiceTypeEnumMap[instance.mainServiceType],
      'color': instance.color,
      'model': instance.model,
      'image': instance.image,
      'thumbnail_image': instance.thumbnailImage,
      'category': instance.category,
      'purchase_price': instance.purchaseAmount,
      'price': instance.price,
      'variants': instance.variants,
    };

const _$MainServiceTypeEnumMap = {
  MainServiceType.dress: 'dress',
  MainServiceType.vehicle: 'vehicle',
  MainServiceType.equipment: 'equipment',
  MainServiceType.gadgets: 'gadgets',
  MainServiceType.others: 'others',
};
