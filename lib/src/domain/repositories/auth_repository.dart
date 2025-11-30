import 'package:dartz/dartz.dart';
import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/domain/entities/auth/user_entity.dart';

/// Auth repository interface (contract)
/// 
/// This defines WHAT the repository should do, not HOW.
/// The implementation is in the data layer.
/// 
/// This follows the Dependency Inversion Principle:
/// - High-level modules (use cases) depend on abstractions (this interface)
/// - Low-level modules (data layer) implement the abstractions
abstract class AuthRepository {
  /// Login user with phone and password
  /// 
  /// Returns:
  /// - Right(UserEntity) on successful login
  /// - Left(AuthFailure) if credentials are invalid
  /// - Left(NetworkFailure) if no internet connection
  /// - Left(ServerFailure) if server error occurs
  Future<Either<Failure, UserEntity>> login({
    required String phone,
    required String password,
    String? deviceToken,
  });

  /// Logout current user
  /// 
  /// Returns:
  /// - Right(void) on successful logout
  /// - Left(Failure) if logout fails
  Future<Either<Failure, void>> logout();

  /// Get current authenticated user
  /// 
  /// Returns:
  /// - Right(UserEntity) if user is logged in
  /// - Left(AuthFailure) if no user is logged in
  /// - Left(CacheFailure) if local storage fails
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Refresh authentication token
  /// 
  /// Returns:
  /// - Right(String) with new access token
  /// - Left(AuthFailure) if refresh token is invalid
  /// - Left(NetworkFailure) if no internet connection
  Future<Either<Failure, String>> refreshToken(String refreshToken);
}
