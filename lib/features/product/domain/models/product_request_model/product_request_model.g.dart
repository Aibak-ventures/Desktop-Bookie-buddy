// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductRequestModel _$ProductRequestModelFromJson(Map<String, dynamic> json) =>
    _ProductRequestModel(
      productId: (json['productId'] as num?)?.toInt(),
      serviceId: (json['shop_service_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      color: json['color'] as String?,
      purchasePrice: (json['purchase_price'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      salePrice: (json['sale_price'] as num?)?.toInt(),
      category: json['category'] as String?,
      model: json['model'] as String?,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductRequestModelToJson(
  _ProductRequestModel instance,
) => <String, dynamic>{
  'productId': ?instance.productId,
  'shop_service_id': ?instance.serviceId,
  'name': ?instance.name,
  'description': ?instance.description,
  'color': ?instance.color,
  'purchase_price': ?instance.purchasePrice,
  'price': ?instance.price,
  'sale_price': ?instance.salePrice,
  'category': ?instance.category,
  'model': ?instance.model,
  'variants': ?_variantsToJson(instance.variants),
};
