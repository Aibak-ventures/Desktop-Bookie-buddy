import '../../../../core/models/auth_models.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/usecases/usecase.dart';

abstract class AuthRepository {
  Future<Result<LoginResponse>> login(LoginRequest request);
  Future<Result<RefreshTokenResponse>> refreshToken(RefreshTokenRequest request);
  Future<Result<UserModel>> getUserProfile();
  Future<Result<void>> changePassword(ChangePasswordRequest request);
  Future<Result<SecretLoginResponse>> secretLogin(SecretLoginRequest request);
  Future<Result<void>> clearUserSession();
}
