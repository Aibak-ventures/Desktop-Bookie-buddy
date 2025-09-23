import 'package:bookie_buddy_web/core/services/auth_service.dart';

class ChangePasswordRepository {
  Future<void> changeAccountPassword({
    required String oldPassword,
    required String newPassword,
    bool logoutFromAllDevices = false,
  }) async {
    try {
      await AuthService.changeAccountPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        logoutFromAllDevices: logoutFromAllDevices,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeSecretPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await AuthService.changeSecretPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
