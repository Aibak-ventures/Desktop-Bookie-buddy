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
      thumbnailImage: _readProductThumbnail(json, 'thumbnailImage') as String?,
      mainServiceType: MainServiceType.fromString(
        json['main_service_name'] as String?,
      ),
      variantAttribute: json['variant_attribute'] as String?,
      color: json['color'] as String?,
      category: json['category'] as String?,
      model: json['model'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      fabricLength: (json['fabric_length'] as num?)?.toDouble() ?? 0.0,
      attributes: json['attributes'] == null
          ? const ProductAttributesModel()
          : ProductAttributesModel.fromJson(
              json['attributes'] as Map<String, dynamic>,
            ),
      measurements: json['measurements'] == null
          ? const []
          : _parseMeasurements(json['measurements']),
      stock: (json['stock'] as num?)?.toInt(),
      remainingStock: (json['remaining_stock'] as num?)?.toInt(),
      deliveryStatus: json['return_status'] == null
          ? ProductDeliveryStatus.notReturned
          : ProductDeliveryStatus.fromJson(json['return_status'] as String?),
      returnedAt: json['returned_at'] as String?,
    );

Map<String, dynamic> _$ProductInfoModelToJson(_ProductInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'variant_id': instance.variantId,
      'product_name': instance.name,
      'image': instance.image,
      'thumbnailImage': instance.thumbnailImage,
      'main_service_name': MainServiceType.toJson(instance.mainServiceType),
      'variant_attribute': instance.variantAttribute,
      'color': instance.color,
      'category': instance.category,
      'model': instance.model,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'fabric_length': instance.fabricLength,
      'attributes': instance.attributes,
      'measurements': instance.measurements,
      'stock': instance.stock,
      'remaining_stock': instance.remainingStock,
      'return_status': ProductDeliveryStatus.toJson(instance.deliveryStatus),
      'returned_at': instance.returnedAt,
    };
