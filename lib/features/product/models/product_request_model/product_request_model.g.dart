// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductRequestModelImpl _$$ProductRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductRequestModelImpl(
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
      registrationNumber: json['registration_number'] as String?,
      pollutionExpiry: json['pollution_expiry'] as String?,
      insuranceExpiry: json['insurance_expiry'] as String?,
      fitnessExpiry: json['fitness_expiry'] as String?,
      barcode: json['barcode'] as String?,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductRequestModelImplToJson(
        _$ProductRequestModelImpl instance) =>
    <String, dynamic>{
      if (instance.productId case final value?) 'productId': value,
      if (instance.serviceId case final value?) 'shop_service_id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.color case final value?) 'color': value,
      if (instance.purchasePrice case final value?) 'purchase_price': value,
      if (instance.price case final value?) 'price': value,
      if (instance.salePrice case final value?) 'sale_price': value,
      if (instance.category case final value?) 'category': value,
      if (instance.model case final value?) 'model': value,
      if (instance.registrationNumber case final value?)
        'registration_number': value,
      if (instance.pollutionExpiry case final value?) 'pollution_expiry': value,
      if (instance.insuranceExpiry case final value?) 'insurance_expiry': value,
      if (instance.fitnessExpiry case final value?) 'fitness_expiry': value,
      if (instance.barcode case final value?) 'barcode': value,
      if (_variantsToJson(instance.variants) case final value?)
        'variants': value,
    };
