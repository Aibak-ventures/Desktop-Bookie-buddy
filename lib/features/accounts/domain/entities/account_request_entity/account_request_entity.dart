import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_request_entity.freezed.dart';

@freezed
abstract class AccountRequestEntity with _$AccountRequestEntity {
  const factory AccountRequestEntity({
    String? accountName,
    String? accountNumber,
    @Default(AccountType.bank) AccountType accountType,
    String? description,
    bool? isActive,
    bool? isDefault,
  }) = _AccountRequestEntity;
}
