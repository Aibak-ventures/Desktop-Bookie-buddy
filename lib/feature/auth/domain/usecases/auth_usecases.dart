import '../../../../core/models/auth_models.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponse, LoginRequest> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Result<LoginResponse>> call(LoginRequest params) async {
    return await repository.login(params);
  }
}

class RefreshTokenUseCase implements UseCase<RefreshTokenResponse, RefreshTokenRequest> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Result<RefreshTokenResponse>> call(RefreshTokenRequest params) async {
    return await repository.refreshToken(params);
  }
}

class GetUserProfileUseCase implements UseCase<UserModel, NoParams> {
  final AuthRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Result<UserModel>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}

class ChangePasswordUseCase implements UseCase<void, ChangePasswordRequest> {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Result<void>> call(ChangePasswordRequest params) async {
    return await repository.changePassword(params);
  }
}

class SecretLoginUseCase implements UseCase<SecretLoginResponse, SecretLoginRequest> {
  final AuthRepository repository;

  SecretLoginUseCase(this.repository);

  @override
  Future<Result<SecretLoginResponse>> call(SecretLoginRequest params) async {
    return await repository.secretLogin(params);
  }
}

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Result<void>> call(NoParams params) async {
    return await repository.clearUserSession();
  }
}
