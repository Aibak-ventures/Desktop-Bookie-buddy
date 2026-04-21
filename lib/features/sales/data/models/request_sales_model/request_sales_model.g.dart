// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_sales_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestSalesModel _$RequestSalesModelFromJson(Map<String, dynamic> json) =>
    _RequestSalesModel(
      staffId: (json['staff_id'] as num?)?.toInt(),
      clientPhone: json['client_phone'] as String?,
      clientAddress: json['client_address'] as String?,
      saleDate: json['sale_date'] as String?,
      description: json['description'] as String?,
      sendInvoice: json['send_invoice'] as bool? ?? false,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      paidAmount: (json['paid_amount'] as num?)?.toInt(),
      paymentMethod: $enumDecodeNullable(
        _$PaymentMethodEnumMap,
        json['payment_method'],
      ),
      discount: (json['discount'] as num?)?.toInt(),
      decreaseStock: json['decrease_stock'] as bool? ?? false,
    );

Map<String, dynamic> _$RequestSalesModelToJson(_RequestSalesModel instance) =>
    <String, dynamic>{
      'staff_id': ?instance.staffId,
      'client_phone': ?instance.clientPhone,
      'client_address': ?instance.clientAddress,
      'sale_date': ?instance.saleDate,
      'description': ?instance.description,
      'send_invoice': instance.sendInvoice,
      'variants': ?instance.variants,
      'paid_amount': ?instance.paidAmount,
      'payment_method': ?instance.paymentMethod,
      'discount': ?instance.discount,
      'decrease_stock': instance.decreaseStock,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.upi: 'upi',
  PaymentMethod.cash: 'cash',
};
