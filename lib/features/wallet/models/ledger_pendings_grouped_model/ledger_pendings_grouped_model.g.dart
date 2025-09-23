// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_pendings_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerPendingsGroupedModelImpl _$$LedgerPendingsGroupedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerPendingsGroupedModelImpl(
      date: json['date'] as String,
      pendings: (json['pendings'] as List<dynamic>)
          .map((e) => LedgerPendingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LedgerPendingsGroupedModelImplToJson(
        _$LedgerPendingsGroupedModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'pendings': instance.pendings,
    };
