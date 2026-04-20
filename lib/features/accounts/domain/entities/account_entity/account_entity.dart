import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_entity.freezed.dart';

@freezed
abstract class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    required int id,
    required String accountName,
    required AccountType accountType,
    String? accountNumber,
    String? description,
    required bool isActive,
    required bool isDefault,
    required String createdAt,
  }) = _AccountEntity;
}
