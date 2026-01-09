// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_counts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StatusCountsModelImpl _$$StatusCountsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusCountsModelImpl(
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      upcoming: (json['upcoming'] as num?)?.toInt() ?? 0,
      returns: (json['returns'] as num?)?.toInt() ?? 0,
      pending: (json['pending'] as num?)?.toInt() ?? 0,
      notReturned: (json['not_returned'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StatusCountsModelImplToJson(
        _$StatusCountsModelImpl instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'upcoming': instance.upcoming,
      'returns': instance.returns,
      'pending': instance.pending,
      'not_returned': instance.notReturned,
    };
