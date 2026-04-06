abstract interface class IAuthRepository {
  // login
  Future<void> login(
      {required String phone, required String password, String? fcmToken});

  // secret login
  Future<void> secretLogin(String password);

  // clear session
  Future<void> clearSession();

  // refresh token
  Future<bool> refreshToken();

  // change account password
  Future<void> changeAccountPassword({
    required String oldPassword,
    required String newPassword,
    bool logoutFromAllDevices = false,
  });

  // change secret password
  Future<void> changeSecretPassword({
    required String oldPassword,
    required String newPassword,
  });
}
