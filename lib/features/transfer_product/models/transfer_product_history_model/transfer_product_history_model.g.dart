// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_product_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferProductHistoryModelImpl _$$TransferProductHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferProductHistoryModelImpl(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      quantityTransferred: (json['quantity_transferred'] as num).toInt(),
      isIncoming: _isIncomingFromJson(json['transfer_mode'] as String),
      transferType: json['transfer_type'] as String,
      productImage: _readProduct(json, 'image') as String?,
      productColor: _readProduct(json, 'color') as String?,
      productModel: _readProduct(json, 'model') as String?,
      productCategory: _readProduct(json, 'category') as String?,
      sourceShopAddress:
          _readSourceShopAddress(json, 'sourceShopAddress') as String,
      destinationShopAddress:
          _readDestinationShopAddress(json, 'destinationShopAddress') as String,
      transferDate: json['transfer_date'] as String,
      sourceShopName: json['source_shop_name'] as String,
      destinationShopName: json['destination_shop_name'] as String,
      sourceProductName: json['source_product_name'] as String,
      destinationProductName: json['destination_product_name'] as String,
      initiatedByName: json['initiated_by_name'] as String,
      sourceVariantAttribute: json['source_variant_attribute'] as String,
      destinationVariantAttribute:
          json['destination_variant_attribute'] as String,
    );

Map<String, dynamic> _$$TransferProductHistoryModelImplToJson(
        _$TransferProductHistoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'quantity_transferred': instance.quantityTransferred,
      'transfer_mode': instance.isIncoming,
      'transfer_type': instance.transferType,
      'image': instance.productImage,
      'color': instance.productColor,
      'model': instance.productModel,
      'category': instance.productCategory,
      'sourceShopAddress': instance.sourceShopAddress,
      'destinationShopAddress': instance.destinationShopAddress,
      'transfer_date': instance.transferDate,
      'source_shop_name': instance.sourceShopName,
      'destination_shop_name': instance.destinationShopName,
      'source_product_name': instance.sourceProductName,
      'destination_product_name': instance.destinationProductName,
      'initiated_by_name': instance.initiatedByName,
      'source_variant_attribute': instance.sourceVariantAttribute,
      'destination_variant_attribute': instance.destinationVariantAttribute,
    };
