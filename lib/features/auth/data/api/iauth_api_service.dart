import 'package:dio/dio.dart';

abstract class IAuthApiService {
  //Login
  Future<Response> login(Map<String, dynamic> body);

  //Request OTP
  Future<Response> requestOtp(Map<String, dynamic> body);

  //Verify OTP
  Future<Response> verifyOTP(Map<String, dynamic> body, Map<String, String> headers);

  //Complete Profile
  Future<Response> completeProfile(Map<String, dynamic> body, Map<String, String> headers);

  //Logout Profile
  Future<Response> logoutProfile(Map<String, dynamic> body, Map<String, String> headers);

  //Get Profile Details
  Future<Response> getProfileDetails();
  
  //Delete user account
  Future<Response> deleteAccount();

  //Refresh Token
  Future<Response> refreshToken(Map<String, String> headers, Map<String, dynamic> body);
}
