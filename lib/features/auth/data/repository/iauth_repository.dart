import '../dto/auth_login_response.dart';

abstract class IAuthRepository {
  //Login
  Future<AuthLoginResponse> login(Map<String, dynamic> data);
}
