import 'package:bookie_buddy_web/features/accounts/domain/entities/account_balance_entity/account_balance_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_summary_entity.freezed.dart';

@freezed
abstract class AccountsSummaryEntity with _$AccountsSummaryEntity {
  const factory AccountsSummaryEntity({
    required double totalBalance,
    required List<AccountBalanceEntity> accounts,
  }) = _AccountsSummaryEntity;
}
