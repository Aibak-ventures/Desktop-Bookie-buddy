import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_request_entity/account_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_request_model.freezed.dart';
part 'account_request_model.g.dart';

@freezed
abstract class AccountRequestModel with _$AccountRequestModel {
  const factory AccountRequestModel({
    @JsonKey(name: 'name', includeIfNull: false) String? accountName,
    @JsonKey(name: 'account_number', includeIfNull: false)
    String? accountNumber, // optional
    @JsonKey(
      name: 'account_type',
      fromJson: AccountType.fromJson,
      toJson: AccountType.toJson,
    )
    @Default(AccountType.bank)
    AccountType accountType, // default to cash if not provided
    @JsonKey(name: 'description', includeIfNull: false)
    String? description, // optional
    @JsonKey(name: 'is_active', includeIfNull: false)
    bool? isActive, // only use in patch if needed
    @JsonKey(name: 'is_default', includeIfNull: false)
    bool? isDefault, // only use in patch if needed
  }) = _AccountRequestModel;

  factory AccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestModelFromJson(json);

  factory AccountRequestModel.fromEntity(AccountRequestEntity entity) =>
      AccountRequestModel(
        accountName: entity.accountName,
        accountNumber: entity.accountNumber,
        description: entity.description,
        isActive: entity.isActive,
        isDefault: entity.isDefault,
        accountType: entity.accountType,
      );
}
