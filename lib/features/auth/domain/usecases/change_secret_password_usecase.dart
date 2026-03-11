import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';

class ChangeSecretPasswordUseCase {
  final IAuthRepository _repository;
  ChangeSecretPasswordUseCase(this._repository);

  Future<void> call({
    required String oldPassword,
    required String newPassword,
  }) =>
      _repository.changeSecretPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
}
