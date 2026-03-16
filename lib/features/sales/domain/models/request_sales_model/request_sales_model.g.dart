// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_sales_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestSalesModelImpl _$$RequestSalesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestSalesModelImpl(
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
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']),
      discount: (json['discount'] as num?)?.toInt(),
      decreaseStock: json['decrease_stock'] as bool? ?? false,
    );

Map<String, dynamic> _$$RequestSalesModelImplToJson(
        _$RequestSalesModelImpl instance) =>
    <String, dynamic>{
      if (instance.staffId case final value?) 'staff_id': value,
      if (instance.clientPhone case final value?) 'client_phone': value,
      if (instance.clientAddress case final value?) 'client_address': value,
      if (instance.saleDate case final value?) 'sale_date': value,
      if (instance.description case final value?) 'description': value,
      'send_invoice': instance.sendInvoice,
      if (instance.variants case final value?) 'variants': value,
      if (instance.paidAmount case final value?) 'paid_amount': value,
      if (instance.paymentMethod case final value?) 'payment_method': value,
      if (instance.discount case final value?) 'discount': value,
      'decrease_stock': instance.decreaseStock,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.gPay: 'gPay',
  PaymentMethod.cash: 'cash',
};
