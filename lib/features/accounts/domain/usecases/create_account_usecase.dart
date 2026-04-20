import 'package:bookie_buddy_web/features/accounts/domain/entities/account_request_entity/account_request_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/repositories/i_account_repository.dart';

class CreateAccountUseCase {
  final IAccountRepository _repository;

  const CreateAccountUseCase(this._repository);

  Future<void> call({required AccountRequestEntity account}) =>
      _repository.createAccount(account: account);
}
