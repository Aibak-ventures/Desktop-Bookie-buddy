// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_pendings_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerPendingsGroupedModelImpl _$$LedgerPendingsGroupedModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerPendingsGroupedModelImpl(
  dailyPendings: (json['dailyPendings'] as List<dynamic>)
      .map((e) => LedgerPendingsDailyModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$LedgerPendingsGroupedModelImplToJson(
  _$LedgerPendingsGroupedModelImpl instance,
) => <String, dynamic>{'dailyPendings': instance.dailyPendings};

_$LedgerPendingsDailyModelImpl _$$LedgerPendingsDailyModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerPendingsDailyModelImpl(
  date: json['date'] as String,
  total: (json['total_pending'] as num?)?.toInt() ?? 0,
  pendings: (json['pendings'] as List<dynamic>)
      .map((e) => LedgerPendingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$LedgerPendingsDailyModelImplToJson(
  _$LedgerPendingsDailyModelImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'total_pending': instance.total,
  'pendings': instance.pendings,
};
