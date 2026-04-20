import 'package:bookie_buddy_web/features/accounts/domain/entities/accounts_summary_entity/accounts_summary_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/repositories/i_account_repository.dart';

class GetAccountsSummaryUseCase {
  final IAccountRepository _repository;

  const GetAccountsSummaryUseCase(this._repository);

  Future<AccountsSummaryEntity> call() => _repository.getAccountsSummary();
}
