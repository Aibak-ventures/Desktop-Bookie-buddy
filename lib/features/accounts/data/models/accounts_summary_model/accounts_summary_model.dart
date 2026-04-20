import 'package:bookie_buddy_web/features/accounts/data/models/account_model/account_model.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_balance_entity/account_balance_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/accounts_summary_entity/accounts_summary_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_summary_model.freezed.dart';
part 'accounts_summary_model.g.dart';

@freezed
abstract class AccountsSummaryModel with _$AccountsSummaryModel {
  const factory AccountsSummaryModel({
    @JsonKey(name: 'total_balance') required double totalBalance,
    @JsonKey(name: 'accounts') required List<AccountModel> accounts,
  }) = _AccountsSummaryModel;

  factory AccountsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$AccountsSummaryModelFromJson(json);
}

extension AccountsSummaryModelMapper on AccountsSummaryModel {
  AccountsSummaryEntity toEntity() => AccountsSummaryEntity(
    totalBalance: totalBalance,
    accounts: accounts
        .map(
          (e) => AccountBalanceEntity(
            account: e.toEntity(),
            balance: e.currentBalance ?? 0,
          ),
        )
        .toList(),
  );
}
