import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository _repository;
  LoginUseCase(this._repository);

  Future<void> call(
          {required String phone,
          required String password,
          String? fcmToken}) =>
      _repository.login(phone: phone, password: password, fcmToken: fcmToken);
}
