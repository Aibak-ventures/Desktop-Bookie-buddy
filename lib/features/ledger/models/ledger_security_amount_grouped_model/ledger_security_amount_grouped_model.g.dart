// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_security_amount_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerSecurityAmountGroupedModelImpl
    _$$LedgerSecurityAmountGroupedModelImplFromJson(
            Map<String, dynamic> json) =>
        _$LedgerSecurityAmountGroupedModelImpl(
          dailySecurityAmounts: (json['dailySecurityAmounts'] as List<dynamic>)
              .map((e) => LedgerSecurityAmountDailyModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$LedgerSecurityAmountGroupedModelImplToJson(
        _$LedgerSecurityAmountGroupedModelImpl instance) =>
    <String, dynamic>{
      'dailySecurityAmounts': instance.dailySecurityAmounts,
    };

_$LedgerSecurityAmountDailyModelImpl
    _$$LedgerSecurityAmountDailyModelImplFromJson(Map<String, dynamic> json) =>
        _$LedgerSecurityAmountDailyModelImpl(
          date: json['date'] as String,
          items: (json['items'] as List<dynamic>)
              .map((e) =>
                  LedgerSecurityAmountModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$LedgerSecurityAmountDailyModelImplToJson(
        _$LedgerSecurityAmountDailyModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'items': instance.items,
    };
