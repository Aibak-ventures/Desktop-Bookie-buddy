import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_counts_entity.freezed.dart';

@freezed
abstract class StatusCountsEntity with _$StatusCountsEntity {
  const factory StatusCountsEntity({
    @Default(0) int completed,
    @Default(0) int upcoming,
    @Default(0) int returns,
    @Default(0) int pending,
    @Default(0) int notReturned,
    @Default(0) int cancelled,
  }) = _StatusCountsEntity;
}
