import 'package:bookie_buddy_web/features/accounts/domain/entities/account_snapshot_entity/account_snapshot_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_snapshot_model.freezed.dart';
part 'account_snapshot_model.g.dart';

@freezed
abstract class AccountSnapshotModel with _$AccountSnapshotModel {
  const factory AccountSnapshotModel({
    @JsonKey(name: 'name', defaultValue: '') required String name,
    @JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString)
    required double amount,
  }) = _AccountSnapshotModel;

  factory AccountSnapshotModel.fromJson(Map<String, dynamic> json) =>
      _$AccountSnapshotModelFromJson(json);
}

extension AccountSnapshotModelMapper on AccountSnapshotModel {
  AccountSnapshotEntity toEntity() =>
      AccountSnapshotEntity(name: name, amount: amount);
}
