import 'dart:developer';
import '../../../../core/models/auth_models.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<LoginResponse>> login(LoginRequest request) async {
    try {
      log('🔥 AuthRepository: login called with phone: ${request.phone}');

      // Check network connectivity
      if (!(await networkInfo.isConnected)) {
        return Result.failure(
          NetworkFailure(message: 'No internet connection. Please check your network and try again.')
        );
      }

      log('🔥 AuthRepository: About to call AuthRemoteDataSource.login');
      final response = await remoteDataSource.login(request);
      log('🔥 AuthRepository: AuthRemoteDataSource.login completed successfully');

      return Result.success(response);
    } on Failure catch (e) {
      log('🔥 AuthRepository: AuthRemoteDataSource.login failed with Failure: $e');
      return Result.failure(e);
    } catch (e, stack) {
      log('🔥 AuthRepository: AuthRemoteDataSource.login failed with unexpected error: $e', stackTrace: stack);
      return Result.failure(
        UnknownFailure(message: 'An unexpected error occurred: $e')
      );
    }
  }

  @override
  Future<Result<RefreshTokenResponse>> refreshToken(RefreshTokenRequest request) async {
    try {
      log('🔄 AuthRepository: refreshToken called');

      if (!(await networkInfo.isConnected)) {
        return Result.failure(
          NetworkFailure(message: 'No internet connection. Please check your network and try again.')
        );
      }

      final response = await remoteDataSource.refreshToken(request);
      return Result.success(response);
    } on Failure catch (e) {
      log('🔄 AuthRepository: refreshToken failed with Failure: $e');
      return Result.failure(e);
    } catch (e, stack) {
      log('🔄 AuthRepository: refreshToken failed with unexpected error: $e', stackTrace: stack);
      return Result.failure(
        UnknownFailure(message: 'Failed to refresh token: $e')
      );
    }
  }

  @override
  Future<Result<UserModel>> getUserProfile() async {
    try {
      log('👤 AuthRepository: getUserProfile called');

      if (!(await networkInfo.isConnected)) {
        return Result.failure(
          NetworkFailure(message: 'No internet connection. Please check your network and try again.')
        );
      }

      final response = await remoteDataSource.getUserProfile();
      return Result.success(response);
    } on Failure catch (e) {
      log('👤 AuthRepository: getUserProfile failed with Failure: $e');
      return Result.failure(e);
    } catch (e, stack) {
      log('👤 AuthRepository: getUserProfile failed with unexpected error: $e', stackTrace: stack);
      return Result.failure(
        UnknownFailure(message: 'Failed to get user profile: $e')
      );
    }
  }

  @override
  Future<Result<void>> changePassword(ChangePasswordRequest request) async {
    try {
      log('🔑 AuthRepository: changePassword called');

      if (!(await networkInfo.isConnected)) {
        return Result.failure(
          NetworkFailure(message: 'No internet connection. Please check your network and try again.')
        );
      }

      await remoteDataSource.changePassword(request);
      return Result.success(null);
    } on Failure catch (e) {
      log('🔑 AuthRepository: changePassword failed with Failure: $e');
      return Result.failure(e);
    } catch (e, stack) {
      log('🔑 AuthRepository: changePassword failed with unexpected error: $e', stackTrace: stack);
      return Result.failure(
        UnknownFailure(message: 'Failed to change password: $e')
      );
    }
  }

  @override
  Future<Result<SecretLoginResponse>> secretLogin(SecretLoginRequest request) async {
    try {
      log('🔐 AuthRepository: secretLogin called');

      if (!(await networkInfo.isConnected)) {
        return Result.failure(
          NetworkFailure(message: 'No internet connection. Please check your network and try again.')
        );
      }

      final response = await remoteDataSource.secretLogin(request);
      return Result.success(response);
    } on Failure catch (e) {
      log('🔐 AuthRepository: secretLogin failed with Failure: $e');
      return Result.failure(e);
    } catch (e, stack) {
      log('🔐 AuthRepository: secretLogin failed with unexpected error: $e', stackTrace: stack);
      return Result.failure(
        UnknownFailure(message: 'Secret login failed: $e')
      );
    }
  }

  @override
  Future<Result<void>> clearUserSession() async {
    try {
      log('🧹 AuthRepository: clearUserSession called');
      
      // In a complete implementation, this would also:
      // 1. Clear tokens from local storage
      // 2. Clear user data from cache
      // 3. Cancel any pending requests
      // 4. Reset any user-specific state
      
      // For now, we'll just return success
      // This will be implemented when we add local data sources
      
      return Result.success(null);
    } catch (e, stack) {
      log('🧹 AuthRepository: clearUserSession failed with error: $e', stackTrace: stack);
      return Result.failure(
        UnknownFailure(message: 'Failed to clear user session: $e')
      );
    }
  }
}
