import 'package:dartz/dartz.dart';
import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/core/usecases/usecase.dart';
import 'package:bookie_buddy_web/src/domain/entities/auth/user_entity.dart';
import 'package:bookie_buddy_web/src/domain/repositories/auth_repository.dart';

/// Use case for getting the current logged-in user
/// 
/// Handles the business logic for retrieving the current user from cache/storage.
/// Returns Either<Failure, UserEntity>:
/// - Right(UserEntity) if user is found
/// - Left(CacheFailure) if no user is logged in
/// - Left(Failure) for other errors
class GetCurrentUserUseCase implements NoParamsUseCase<UserEntity> {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getCurrentUser();
  }
}
