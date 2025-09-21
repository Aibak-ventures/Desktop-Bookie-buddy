import '../data/dto/auth_login_response.dart';
import '../domain/model/auth_login_model.dart';

abstract class IAuthService {
  //Login
  Future<AuthLoginResponse> login(AuthLoginModel loginModel);
}
