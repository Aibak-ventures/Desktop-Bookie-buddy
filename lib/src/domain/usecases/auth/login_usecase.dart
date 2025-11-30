import 'package:dartz/dartz.dart';
import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/core/usecases/usecase.dart';
import 'package:bookie_buddy_web/src/domain/entities/auth/user_entity.dart';
import 'package:bookie_buddy_web/src/domain/repositories/auth_repository.dart';

/// Use case for user login
/// 
/// Handles the business logic for authenticating a user with phone and password.
/// Returns Either<Failure, UserEntity>:
/// - Left(AuthFailure) if credentials are invalid
/// - Left(NetworkFailure) if no internet connection
/// - Right(UserEntity) if login successful
class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    // Input validation
    if (params.phone.isEmpty || params.password.isEmpty) {
      return const Left(
        ValidationFailure(
          message: 'Phone and password are required',
        ),
      );
    }

    // Validate phone format (basic example)
    if (params.phone.length < 10) {
      return const Left(
        ValidationFailure(
          message: 'Invalid phone number',
        ),
      );
    }

    // Delegate to repository
    return await repository.login(
      phone: params.phone,
      password: params.password,
      deviceToken: params.deviceToken,
    );
  }
}

/// Parameters for login use case
class LoginParams {
  final String phone;
  final String password;
  final String? deviceToken;

  const LoginParams({
    required this.phone,
    required this.password,
    this.deviceToken,
  });
}
