import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';

class RegisterFCMTokenUseCase {
  final IUserRepository _repository;

  RegisterFCMTokenUseCase(this._repository);

  Future<void> call(String token) => _repository.registerFCMToken(token);
}
