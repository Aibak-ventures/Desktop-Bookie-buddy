import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_request_entity/account_request_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/accounts_summary_entity/accounts_summary_entity.dart';

abstract interface class IAccountRepository {
  //
  Future<PaginationModel<AccountEntity>> getAccounts({
    int page = 1,
    bool isActiveOnly = true,
  });

  //
  Future<AccountsSummaryEntity> getAccountsSummary();

  //
  Future<void> createAccount({required AccountRequestEntity account});

  //
  Future<void> updateAccount({
    required int accountId,
    required AccountRequestEntity account,
  });

  //
  Future<void> deleteAccount({required int accountId});
}
