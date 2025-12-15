// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_pendings_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerPendingsDailyModelImpl _$$LedgerPendingsDailyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerPendingsDailyModelImpl(
      date: json['date'] as String,
      total: (json['total'] as num?)?.toInt() ?? 0,
      pendings: (json['pendings'] as List<dynamic>?)
              ?.map(
                  (e) => LedgerPendingModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LedgerPendingModel>[],
    );

Map<String, dynamic> _$$LedgerPendingsDailyModelImplToJson(
        _$LedgerPendingsDailyModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'total': instance.total,
      'pendings': instance.pendings,
    };
