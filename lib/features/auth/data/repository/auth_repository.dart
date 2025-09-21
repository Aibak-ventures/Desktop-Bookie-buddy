import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/errors/failures.dart';

import '../api/iauth_api_service.dart';
import '../dto/auth_login_response.dart';
import 'iauth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthApiService _authApiService;
  AuthRepository(this._authApiService);

  @override
  Future<AuthLoginResponse> login(Map<String, dynamic> data) async {
    try {
      debugPrint("🔐 Login: Repository");
      final response = await _authApiService.login(data);
      debugPrint("Response in Repository: $response");
      
      if (response.statusCode != HttpStatus.ok) {
        debugPrint('Repository Error: ${response.data}');
        throw ServerFailure(
          message: response.data["message"] ?? "Login failed",
          statusCode: response.statusCode,
        );
      }
      
      final result = AuthLoginResponse.fromJson(response.data);
      debugPrint("Successfully parsed response in Repository");
      return result;
    } catch (e) {
      debugPrint("Repository error: $e");
      if (e is Failure) {
        rethrow; // Preserve original Failure object
      }
      throw ServerFailure(message: e.toString());
    }
  }
}
