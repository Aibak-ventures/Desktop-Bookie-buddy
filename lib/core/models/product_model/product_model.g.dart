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
      mainServiceType:
          MainServiceType.fromString(json['main_service_name'] as String?),
      color: json['color'] as String?,
      model: json['model'] as String?,
      image: json['image'] as String?,
      thumbnailImage: json['thumbnail_image'] as String?,
      category: json['category'] as String?,
      purchaseAmount: (json['purchase_price'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      salePrice: ProductModel._salePriceFromJson(json['sale_price']),
      registrationNumber: json['registration_number'] as String?,
      pollutionExpiry: json['pollution_expiry'] as String?,
      insuranceExpiry: json['insurance_expiry'] as String?,
      fitnessExpiry: json['fitness_expiry'] as String?,
      barcode: json['barcode'] as String?,
      generalServiceName: json['general_service_name'] as String?,
      attributes: json['attributes'] as Map<String, dynamic>? ?? const {},
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
      'sale_price': instance.salePrice,
      'registration_number': instance.registrationNumber,
      'pollution_expiry': instance.pollutionExpiry,
      'insurance_expiry': instance.insuranceExpiry,
      'fitness_expiry': instance.fitnessExpiry,
      'barcode': instance.barcode,
      'general_service_name': instance.generalServiceName,
      'attributes': instance.attributes,
      'variants': instance.variants,
    };

const _$MainServiceTypeEnumMap = {
  MainServiceType.dress: 'dress',
  MainServiceType.vehicle: 'vehicle',
  MainServiceType.equipment: 'equipment',
  MainServiceType.gadgets: 'gadgets',
  MainServiceType.material: 'material',
  MainServiceType.room: 'room',
  MainServiceType.costume: 'costume',
  MainServiceType.jewellery: 'jewellery',
  MainServiceType.shoes: 'shoes',
  MainServiceType.bridal: 'bridal',
  MainServiceType.others: 'others',
};
