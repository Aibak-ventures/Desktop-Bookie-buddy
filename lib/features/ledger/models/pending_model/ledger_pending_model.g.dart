// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_pending_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerPendingModelImpl _$$LedgerPendingModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerPendingModelImpl(
  bookingId: (json['booking_id'] as num).toInt(),
  clientName: json['client_name'] as String? ?? 'Unknown',
  remainingAmount: (json['remaining_amount'] as num).toInt(),
  returnDate: json['return_date'] as String,
);

Map<String, dynamic> _$$LedgerPendingModelImplToJson(
  _$LedgerPendingModelImpl instance,
) => <String, dynamic>{
  'booking_id': instance.bookingId,
  'client_name': instance.clientName,
  'remaining_amount': instance.remainingAmount,
  'return_date': instance.returnDate,
};
