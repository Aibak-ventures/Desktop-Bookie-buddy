// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_payment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SalesPaymentRequestModel _$SalesPaymentRequestModelFromJson(
  Map<String, dynamic> json,
) => _SalesPaymentRequestModel(
  id: (json['id'] as num?)?.toInt(),
  accountId: (json['account_id'] as num).toInt(),
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$SalesPaymentRequestModelToJson(
  _SalesPaymentRequestModel instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'account_id': instance.accountId,
  'amount': instance.amount,
};
