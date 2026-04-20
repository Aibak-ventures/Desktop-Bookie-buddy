import 'package:bookie_buddy_web/features/accounts/domain/repositories/i_account_repository.dart';

class DeleteAccountUseCase {
  final IAccountRepository _repository;

  const DeleteAccountUseCase(this._repository);

  Future<void> call({required int accountId}) =>
      _repository.deleteAccount(accountId: accountId);
}
