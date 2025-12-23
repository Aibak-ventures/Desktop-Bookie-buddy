// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerSaleModelImpl _$$LedgerSaleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerSaleModelImpl(
      id: (json['id'] as num).toInt(),
      invoiceId: json['invoice_id'] as String? ?? '',
      totalAmount: (json['total_amount'] as num).toInt(),
      products: json['items'] as String? ?? '',
      paymentMethods: json['payment_methods'] == null
          ? PaymentMethod.cash
          : PaymentMethod.fromJson(json['payment_methods'] as String?),
      date: json['created_at'] as String,
      type: LedgerListType.fromJson(json['type'] as String?),
    );

Map<String, dynamic> _$$LedgerSaleModelImplToJson(
        _$LedgerSaleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoiceId,
      'total_amount': instance.totalAmount,
      'items': instance.products,
      'payment_methods': instance.paymentMethods,
      'created_at': instance.date,
      'type': LedgerListType.toJson(instance.type),
    };
