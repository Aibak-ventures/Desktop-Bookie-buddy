import 'package:bookie_buddy_web/features/accounts/domain/entities/account_request_entity/account_request_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/repositories/i_account_repository.dart';

class UpdateAccountUseCase {
  final IAccountRepository _repository;

  const UpdateAccountUseCase(this._repository);

  Future<void> call({
    required int accountId,
    required AccountRequestEntity account,
  }) => _repository.updateAccount(accountId: accountId, account: account);
}
