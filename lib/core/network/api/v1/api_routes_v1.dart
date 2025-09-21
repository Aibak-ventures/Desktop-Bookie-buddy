import '../../../env/env_config.dart';

class ApiRoutesV1 {
  // * =====[ API Health ]=====
  String apiHealth = EnvConfig.baseUrl;

  // * =====[ Auth Routes ]=====
  //Request OTP
  String requestOTP = 'auth/access:request-otp';
  //Verify OTP
  String verifyOTP = 'auth/access:verify-otp';
  //Complete Profile
  String completeProfile = 'auth/access:complete-profile';
  //Logout Profile
  String logoutProfile = 'auth/logout';
  //Refresh Token
  String refreshToken = 'auth/access:refresh';
  //Login
  String login = 'auth/login/';
  //User Profile
  String getUserProfileDetails = 'auth/me';
  //Change Password
  String changePassword = 'auth/change-password';
  //Secret Login
  String secretLogin = 'auth/secret-login';
}
