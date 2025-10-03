// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_bookings_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerBookingsGroupedModelImpl _$$LedgerBookingsGroupedModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerBookingsGroupedModelImpl(
  dailyBookings: (json['dailyBookings'] as List<dynamic>)
      .map((e) => LedgerBookingDailyModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$LedgerBookingsGroupedModelImplToJson(
  _$LedgerBookingsGroupedModelImpl instance,
) => <String, dynamic>{'dailyBookings': instance.dailyBookings};

_$LedgerBookingDailyModelImpl _$$LedgerBookingDailyModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerBookingDailyModelImpl(
  date: json['date'] as String,
  total: (json['total'] as num?)?.toInt() ?? 0,
  bookings: (json['bookings'] as List<dynamic>)
      .map((e) => LedgerBookingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$LedgerBookingDailyModelImplToJson(
  _$LedgerBookingDailyModelImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'total': instance.total,
  'bookings': instance.bookings,
};
