// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerSaleModelImpl _$$LedgerSaleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerSaleModelImpl(
      saleId: (json['id'] as num).toInt(),
      date: json['sale_date'] as String,
      createdAt: json['created_at'] as String? ?? '',
      totalAmount: (json['total_amount'] as num).toInt(),
      clientName: json['client_name'] as String,
      products:
          (json['items'] as List<dynamic>).map((e) => e as String).toList(),
      paymentMethods: PaymentMethod.fromList(json['payment_methods'] as List),
    );

Map<String, dynamic> _$$LedgerSaleModelImplToJson(
        _$LedgerSaleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.saleId,
      'sale_date': instance.date,
      'created_at': instance.createdAt,
      'total_amount': instance.totalAmount,
      'client_name': instance.clientName,
      'items': instance.products,
      'payment_methods': PaymentMethod.toList(instance.paymentMethods),
    };
