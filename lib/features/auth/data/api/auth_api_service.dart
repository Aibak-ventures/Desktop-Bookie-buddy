import 'package:dio/dio.dart';
import '../../../../core/network/api/v1/api_routes_v1.dart';
import 'package:flutter/material.dart';
import '../../../../core/network/mixin/uri_mixin.dart';
import 'iauth_api_service.dart';

class AuthApiService with UriMixin implements IAuthApiService {
  final Dio dio;

  AuthApiService(this.dio);

  @override
  Future<Response> login(Map<String, dynamic> body) async {
    try {
      debugPrint("🔐 Logging in: API Service");
      final url = getUri(ApiRoutesV1().login, version: 'v3');
      debugPrint("URL in API: $url");
      final response = await dio.post(url, data: body);
      debugPrint("API Response: $response");
      return response;
    } catch (e) {
      debugPrint("Error in login API: $e");
      rethrow;
    }
  }

  @override
  Future<Response> requestOtp(Map<String, dynamic> body) async {
    try {
      debugPrint("Requesting OTP: API Service");
      final url = getUri(ApiRoutesV1().requestOTP, version: 'v2');
      debugPrint("URL in API: $url");
      final response = await dio.post(url, data: body);
      debugPrint("API Response: $response");
      return response;
    } catch (e) {
      debugPrint("Error in API: $e");
      rethrow;
    }
  }

  @override
  Future<Response> verifyOTP(
      Map<String, dynamic> body, Map<String, String> headers) async {
    try {
      debugPrint("Verifying OTP: API Service");
      final url = getUri(ApiRoutesV1().verifyOTP, version: 'v2');
      debugPrint("URL: $url");
      debugPrint("Headers: $headers");
      debugPrint("Request Body: $body");
      final response =
          await dio.post(url, data: body, options: Options(headers: headers));  
      return response;
    } catch (e) {
      debugPrint("Error in verifyOTP: $e");
      rethrow;
    }
  }

  @override
  Future<Response> completeProfile(
      Map<String, dynamic> body, Map<String, String> headers) async {
    try {
      debugPrint("Completing Profile: API Service");
      final url = getUri(ApiRoutesV1().completeProfile, version: 'v2');
      final response =
          await dio.post(url, data: body, options: Options(headers: headers));
      debugPrint("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> logoutProfile(
      Map<String, dynamic> body, Map<String, String> headers) async {
    try {
      debugPrint("Logging out Profile: API Service");
      final url = getUri(ApiRoutesV1().logoutProfile, version: 'v2');
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      debugPrint("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getProfileDetails() async {
    try {
      debugPrint("Getting Profile Details: API Service");
      final url = getUri(ApiRoutesV1().getUserProfileDetails, version: 'v2');
      debugPrint("URL in Getting Profile Details in Auth: $url");
      final response = await dio.get(url);
      debugPrint("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteAccount() async {
    try {
      debugPrint("Deleting Account From Profile: API Service");
      final url = getUri(ApiRoutesV1().getUserProfileDetails, version: 'v2');
      final response = await dio.delete(url);
      debugPrint("API Response: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> refreshToken(Map<String, String> headers, Map<String, dynamic> body) async {
    try {
      debugPrint("Refreshing Token: API Service");
      final url = getUri(ApiRoutesV1().refreshToken, version: 'v2');
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      debugPrint("API Response in Refresh Token: $response");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
