import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_snapshot_entity.freezed.dart';

@freezed
abstract class AccountSnapshotEntity with _$AccountSnapshotEntity {
  const factory AccountSnapshotEntity({
    required String name,
    required double amount,
  }) = _AccountSnapshotEntity;
}
