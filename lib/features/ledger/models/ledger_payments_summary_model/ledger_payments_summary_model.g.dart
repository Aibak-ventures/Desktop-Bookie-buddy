// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_payments_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerPaymentsSummaryModelImpl _$$LedgerPaymentsSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerPaymentsSummaryModelImpl(
  gpay: (json['gpay'] as num).toInt(),
  cash: (json['cash'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$$LedgerPaymentsSummaryModelImplToJson(
  _$LedgerPaymentsSummaryModelImpl instance,
) => <String, dynamic>{
  'gpay': instance.gpay,
  'cash': instance.cash,
  'total': instance.total,
};
