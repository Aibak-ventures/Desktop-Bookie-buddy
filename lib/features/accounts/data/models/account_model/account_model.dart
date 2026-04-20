import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required int id,
    @JsonKey(name: 'name') required String accountName,
    @JsonKey(
      name: 'account_type',
      fromJson: AccountType.fromJson,
      toJson: AccountType.toJson,
    )
    required AccountType accountType,
    @JsonKey(name: 'account_number') String? accountNumber,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'is_default') required bool isDefault,
    @JsonKey(name: 'created_at') required String createdAt,
    // Present only in the accounts-with-amounts (summary) response
    @JsonKey(name: 'current_balance') double? currentBalance,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}

extension AccountModelMapper on AccountModel {
  AccountEntity toEntity() => AccountEntity(
    id: id,
    accountName: accountName,
    accountType: accountType,
    accountNumber: accountNumber,
    description: description,
    isActive: isActive,
    isDefault: isDefault,
    createdAt: createdAt,
  );
}
