import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/accounts/data/datasources/account_remote_datasource.dart';
import 'package:bookie_buddy_web/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:bookie_buddy_web/features/accounts/domain/repositories/i_account_repository.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/create_account_usecase.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/delete_account_usecase.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/get_accounts_summary_usecase.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/get_accounts_usecase.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/update_account_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class AccountDependencies {
  static void register() {
    getIt
      ..registerLazySingleton(() => AccountRemoteDatasource(DioClient.dio))
      ..registerLazySingleton<IAccountRepository>(
        () => AccountRepositoryImpl(getIt()),
      )
      ..registerLazySingleton(() => GetAccountsUseCase(getIt()))
      ..registerLazySingleton(() => GetAccountsSummaryUseCase(getIt()))
      ..registerLazySingleton(() => CreateAccountUseCase(getIt()))
      ..registerLazySingleton(() => UpdateAccountUseCase(getIt()))
      ..registerLazySingleton(() => DeleteAccountUseCase(getIt()));
  }
}
