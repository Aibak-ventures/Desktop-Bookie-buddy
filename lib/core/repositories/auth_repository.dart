import '../models/user_token.dart';

abstract class AuthRepository {
  Future<UserToken?> getToken();
  Future<void> saveToken(UserToken token);
  Future<void> clearToken();
  Future<bool> hasValidToken();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}

class AuthRepositoryImpl implements AuthRepository {
  // This would be implemented with SharedPreferences or secure storage
  // For now, just providing the interface
  
  @override
  Future<UserToken?> getToken() async {
    // Implementation would get token from storage
    return null;
  }

  @override
  Future<void> saveToken(UserToken token) async {
    // Implementation would save token to storage
  }

  @override
  Future<void> clearToken() async {
    // Implementation would clear token from storage
  }

  @override
  Future<bool> hasValidToken() async {
    final token = await getToken();
    return token != null && token.isValid;
  }

  @override
  Future<String?> getAccessToken() async {
    final token = await getToken();
    return token?.accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final token = await getToken();
    return token?.refreshToken;
  }
}
