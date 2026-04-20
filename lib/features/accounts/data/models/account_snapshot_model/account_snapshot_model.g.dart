// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_snapshot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountSnapshotModel _$AccountSnapshotModelFromJson(
  Map<String, dynamic> json,
) => _AccountSnapshotModel(
  name: json['name'] as String? ?? '',
  amount: StringX.toDoubleFromString(json['amount']),
);

Map<String, dynamic> _$AccountSnapshotModelToJson(
  _AccountSnapshotModel instance,
) => <String, dynamic>{'name': instance.name, 'amount': instance.amount};
