// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountsSummaryModel _$AccountsSummaryModelFromJson(
  Map<String, dynamic> json,
) => _AccountsSummaryModel(
  totalBalance: (json['total_balance'] as num).toDouble(),
  accounts: (json['accounts'] as List<dynamic>)
      .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AccountsSummaryModelToJson(
  _AccountsSummaryModel instance,
) => <String, dynamic>{
  'total_balance': instance.totalBalance,
  'accounts': instance.accounts,
};
