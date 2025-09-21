import 'package:flutter/material.dart';
import '../../../core/errors/failures.dart';
import '../data/dto/auth_login_response.dart';
import '../data/repository/iauth_repository.dart';
import '../domain/model/auth_login_model.dart';
import 'iauth_service.dart';

class AuthService implements IAuthService {
  final IAuthRepository _authRepository;

  AuthService(this._authRepository);

  @override
  Future<AuthLoginResponse> login(AuthLoginModel loginModel) async {
    try {
      debugPrint("🔐 Login: Service");
      final response = await _authRepository.login(loginModel.toJson());
      debugPrint("Response in Service: $response");
      return response;
    } on Failure catch (_) {
      rethrow;
    } catch (e) {
      debugPrint('Unexpected Service Error: $e');
      throw ServerFailure(message: 'An unexpected error occurred');
    }
  }
}
