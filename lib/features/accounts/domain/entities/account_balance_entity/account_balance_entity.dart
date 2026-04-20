import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_balance_entity.freezed.dart';

@freezed
abstract class AccountBalanceEntity with _$AccountBalanceEntity {
  const factory AccountBalanceEntity({
    required AccountEntity account,
    required double balance,
  }) = _AccountBalanceEntity;
}
