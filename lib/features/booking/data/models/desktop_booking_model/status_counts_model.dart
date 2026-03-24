// ignore_for_file: invalid_annotation_target

import 'package:bookie_buddy_web/features/booking/domain/entities/status_counts_entity/status_counts_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_counts_model.freezed.dart';
part 'status_counts_model.g.dart';

@freezed
abstract class StatusCountsModel with _$StatusCountsModel {
  const factory StatusCountsModel({
    @Default(0) int completed,
    @Default(0) int upcoming,
    @Default(0) int returns,
    @Default(0) int pending,
    @JsonKey(name: 'not_returned') @Default(0) int notReturned,
    @Default(0) int cancelled,
  }) = _StatusCountsModel;

  factory StatusCountsModel.fromJson(Map<String, dynamic> json) =>
      _$StatusCountsModelFromJson(json);
}

extension StatusCountsModelMapper on StatusCountsModel {
  StatusCountsEntity toEntity() => StatusCountsEntity(
    completed: completed,
    upcoming: upcoming,
    returns: returns,
    pending: pending,
    notReturned: notReturned,
    cancelled: cancelled,
  );
}
