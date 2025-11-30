import 'package:dartz/dartz.dart';
import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/core/usecases/usecase.dart';
import 'package:bookie_buddy_web/src/domain/repositories/auth_repository.dart';

/// Use case for user logout
/// 
/// Handles the business logic for logging out a user.
/// Returns Either<Failure, void>:
/// - Right(void) on successful logout
/// - Left(Failure) if logout fails
class LogoutUseCase implements NoParamsUseCase<void> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
