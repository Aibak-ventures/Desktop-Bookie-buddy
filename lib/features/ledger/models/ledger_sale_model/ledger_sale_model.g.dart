// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerSaleModelImpl _$$LedgerSaleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerSaleModelImpl(
      saleId: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String? ?? '',
      totalAmount: (json['total_amount'] as num?)?.toInt() ?? 0,
      clientName: json['clientName'] as String? ?? '',
      products: _itemsFromJson(json['items']),
      paymentMethods: _paymentMethodsFromJson(json['payment_methods']),
    );

Map<String, dynamic> _$$LedgerSaleModelImplToJson(
        _$LedgerSaleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.saleId,
      'created_at': instance.createdAt,
      'total_amount': instance.totalAmount,
      'clientName': instance.clientName,
      'items': instance.products,
      'payment_methods': instance.paymentMethods
          .map((e) => _$PaymentMethodEnumMap[e]!)
          .toList(),
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.gPay: 'gPay',
  PaymentMethod.cash: 'cash',
};
