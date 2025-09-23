// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_security_amount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerSecurityAmountModelImpl _$$LedgerSecurityAmountModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerSecurityAmountModelImpl(
      bookingId: (json['booking_id'] as num).toInt(),
      clientName: json['client_name'] as String? ?? 'Unknown',
      securityAmount: (json['security_amount'] as num).toInt(),
      bookingDate: json['booking_date'] as String,
    );

Map<String, dynamic> _$$LedgerSecurityAmountModelImplToJson(
        _$LedgerSecurityAmountModelImpl instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'client_name': instance.clientName,
      'security_amount': instance.securityAmount,
      'booking_date': instance.bookingDate,
    };
