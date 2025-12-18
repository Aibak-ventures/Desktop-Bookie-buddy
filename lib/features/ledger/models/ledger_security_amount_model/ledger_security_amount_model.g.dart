// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_security_amount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerSecurityAmountModelImpl _$$LedgerSecurityAmountModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerSecurityAmountModelImpl(
      id: (json['id'] as num).toInt(),
      clientName: json['client_name'] as String? ?? 'Unknown',
      securityAmount: (json['security_amount'] as num).toInt(),
      date: json['date'] as String,
      type: LedgerListType.fromJson(json['type'] as String?),
    );

Map<String, dynamic> _$$LedgerSecurityAmountModelImplToJson(
        _$LedgerSecurityAmountModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_name': instance.clientName,
      'security_amount': instance.securityAmount,
      'date': instance.date,
      'type': LedgerListType.toJson(instance.type),
    };
