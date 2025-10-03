// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_payment_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerPaymentGroupedModelImpl _$$LedgerPaymentGroupedModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerPaymentGroupedModelImpl(
  dailyPayments: (json['dailyPayments'] as List<dynamic>)
      .map((e) => LedgerPaymentsDailyModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$LedgerPaymentGroupedModelImplToJson(
  _$LedgerPaymentGroupedModelImpl instance,
) => <String, dynamic>{'dailyPayments': instance.dailyPayments};

_$LedgerPaymentsDailyModelImpl _$$LedgerPaymentsDailyModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerPaymentsDailyModelImpl(
  date: json['date'] as String,
  payments: (json['payments'] as List<dynamic>)
      .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  paymentsSummary: json['paymentsSummary'] == null
      ? null
      : LedgerPaymentsSummaryModel.fromJson(
          json['paymentsSummary'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$LedgerPaymentsDailyModelImplToJson(
  _$LedgerPaymentsDailyModelImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'payments': instance.payments,
  'paymentsSummary': instance.paymentsSummary,
};
