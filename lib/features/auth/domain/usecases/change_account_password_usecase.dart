import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';

class ChangeAccountPasswordUseCase {
  final IAuthRepository _repository;
  ChangeAccountPasswordUseCase(this._repository);

  Future<void> call(
          {required String oldPassword,
          required String newPassword,
          required bool logoutFromAllDevices}) =>
      _repository.changeAccountPassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          logoutFromAllDevices: logoutFromAllDevices);
}
