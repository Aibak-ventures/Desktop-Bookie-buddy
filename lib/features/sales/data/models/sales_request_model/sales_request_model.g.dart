// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SalesRequestModel _$SalesRequestModelFromJson(Map<String, dynamic> json) =>
    _SalesRequestModel(
      id: (json['id'] as num?)?.toInt(),
      staffId: (json['staff_id'] as num?)?.toInt(),
      clientPhone: json['client_phone'] as String?,
      address: json['client_address'] as String?,
      saleDate: json['sale_date'] as String?,
      products: (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductSelectedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      stockCountDecrease: json['decrease_stock'] as bool?,
      description: json['description'] as String?,
      discountAmount: (json['discount'] as num?)?.toInt(),
      paidAmount: (json['paid_amount'] as num?)?.toInt(),
      accountId: (json['account_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SalesRequestModelToJson(_SalesRequestModel instance) =>
    <String, dynamic>{
      'staff_id': ?instance.staffId,
      'client_phone': ?instance.clientPhone,
      'client_address': ?instance.address,
      'sale_date': ?instance.saleDate,
      'variants': ?_variantsToJson(instance.products),
      'decrease_stock': ?instance.stockCountDecrease,
      'description': ?instance.description,
      'discount': ?instance.discountAmount,
      'paid_amount': ?instance.paidAmount,
      'account_id': ?instance.accountId,
      'send_invoice': instance.sendPdfToWhatsApp,
    };
