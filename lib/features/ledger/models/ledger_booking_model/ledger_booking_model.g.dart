// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerBookingModelImpl _$$LedgerBookingModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerBookingModelImpl(
  bookingId: (json['booking_id'] as num).toInt(),
  clientName: json['client_name'] as String? ?? 'Unknown',
  totalAmount: (json['total_amount'] as num?)?.toInt() ?? 0,
  advanceAmount: (json['advance_amount'] as num?)?.toInt() ?? 0,
  bookedDate: json['booked_date'] as String,
  bookedItems:
      (json['booked_items'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$LedgerBookingModelImplToJson(
  _$LedgerBookingModelImpl instance,
) => <String, dynamic>{
  'booking_id': instance.bookingId,
  'client_name': instance.clientName,
  'total_amount': instance.totalAmount,
  'advance_amount': instance.advanceAmount,
  'booked_date': instance.bookedDate,
  'booked_items': instance.bookedItems,
};
