import 'dart:developer';

import 'package:bookie_buddy_web/core/services/auth_service.dart';

class AuthRepository {
  Future<void> loginUser(
    String phone,
    String password,
  ) async {
    print('🔥 AuthRepository: loginUser called with phone: $phone');
    try {
      print('🔥 AuthRepository: About to call AuthService.userLogin');
      await AuthService.userLogin(
        phone, password);
      print('🔥 AuthRepository: AuthService.userLogin completed successfully');
    } catch (e) {
      print('🔥 AuthRepository: AuthService.userLogin failed with error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> secretLogin(String password) async {
    try {
      return await AuthService.secretLogin(password);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<void> clearUserSession() async {
    try {
      await AuthService.clearUserSession();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
