// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductInfoModel _$ProductInfoModelFromJson(Map<String, dynamic> json) =>
    _ProductInfoModel(
      id: (_idCustomRead(json, 'id') as num).toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      variantId: (json['variant_id'] as num?)?.toInt(),
      name: json['product_name'] as String,
      image: _readProductImage(json, 'image') as String?,
      mainServiceType: MainServiceType.fromString(
        json['main_service_name'] as String?,
      ),
      variantAttribute: json['variant_attribute'] as String?,
      color: json['color'] as String?,
      category: json['category'] as String?,
      model: json['model'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      measurements: json['measurements'] == null
          ? const []
          : _parseMeasurements(json['measurements']),
      stock: (json['stock'] as num?)?.toInt(),
      remainingStock: (json['remaining_stock'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductInfoModelToJson(_ProductInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'variant_id': instance.variantId,
      'product_name': instance.name,
      'product_thumbnail': instance.image,
      'main_service_name': _$MainServiceTypeEnumMap[instance.mainServiceType],
      'variant_attribute': instance.variantAttribute,
      'color': instance.color,
      'category': instance.category,
      'model': instance.model,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'measurements': instance.measurements,
      'stock': instance.stock,
      'remaining_stock': instance.remainingStock,
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
