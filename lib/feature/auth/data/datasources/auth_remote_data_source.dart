import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/models/auth_models.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/env/env_config.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request);
  Future<UserModel> getUserProfile();
  Future<void> changePassword(ChangePasswordRequest request);
  Future<SecretLoginResponse> secretLogin(SecretLoginRequest request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      log('🔐 AuthRemoteDataSource.login called with phone: ${request.phone}');
      
      // Create a fresh Dio instance to avoid interceptor interference during login
      final loginDio = Dio(BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => true, // Don't throw on HTTP errors
      ));

      log('=== LOGIN REQUEST DEBUG ===');
      log('Base URL: ${loginDio.options.baseUrl}');
      log('Full URL: ${loginDio.options.baseUrl}${EnvConfig.loginEndpoint}');
      log('Request data: ${request.toJson()}');
      log('Headers: ${loginDio.options.headers}');
      log('===========================');

      final response = await loginDio.post(
        EnvConfig.loginEndpoint,
        data: request.toJson(),
      );

      log('Response status: ${response.statusCode}');
      log('Response data: ${response.data.toString()}');

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else if (response.statusCode == 405) {
        throw ServerFailure(message: 'Method not allowed. Please check if the login endpoint is configured correctly.');
      } else if (response.statusCode == 400) {
        final errorResponse = ApiErrorResponse.fromJson(response.data ?? {});
        throw ValidationFailure(message: errorResponse.errorMessage);
      } else if (response.statusCode == 401) {
        final errorResponse = ApiErrorResponse.fromJson(response.data ?? {});
        throw AuthenticationFailure(
          message: errorResponse.errorMessage.isNotEmpty 
            ? errorResponse.errorMessage 
            : 'Phone number or password is incorrect'
        );
      } else {
        throw ServerFailure(message: 'Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e, stack) {
      log('DioException in login: $e', stackTrace: stack);
      
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkFailure(message: "Request timeout. Please check your connection and try again.");
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkFailure(message: "Connection error. Please check your internet connection.");
      } else if (e.response != null) {
        final errorResponse = ApiErrorResponse.fromJson(e.response?.data ?? {});
        throw ServerFailure(message: errorResponse.errorMessage);
      } else {
        throw NetworkFailure(message: "Network error occurred. Please try again.");
      }
    } catch (e, stack) {
      log('Unexpected error in login: $e', stackTrace: stack);
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request) async {
    try {
      log('🔄 AuthRemoteDataSource.refreshToken called');
      
      // Create a separate Dio instance for refresh to avoid infinite loops
      final refreshDio = Dio(BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => true,
      ));

      final response = await refreshDio.post(
        EnvConfig.refreshTokenEndpoint,
        data: request.toJson(),
      );

      log('Refresh token response status: ${response.statusCode}');
      log('Refresh token response data: ${response.data.toString()}');

      if (response.statusCode == 200) {
        return RefreshTokenResponse.fromJson(response.data);
      } else {
        throw AuthenticationFailure(message: 'Failed to refresh token');
      }
    } on DioException catch (e, stack) {
      log('DioException in refreshToken: $e', stackTrace: stack);
      
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkFailure(message: "Request timeout. Please check your connection and try again.");
      } else {
        throw AuthenticationFailure(message: 'Failed to refresh token');
      }
    } catch (e, stack) {
      log('Unexpected error in refreshToken: $e', stackTrace: stack);
      throw AuthenticationFailure(message: 'Failed to refresh token');
    }
  }

  @override
  Future<UserModel> getUserProfile() async {
    try {
      log('👤 AuthRemoteDataSource.getUserProfile called');

      final response = await _dio.get(
        EnvConfig.userProfileEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('User profile response status: ${response.statusCode}');
      log('User profile response data: ${response.data.toString()}');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerFailure(message: 'Failed to get user profile');
      }
    } on DioException catch (e, stack) {
      log('DioException in getUserProfile: $e', stackTrace: stack);
      
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkFailure(message: "Request timeout. Please check your connection and try again.");
      } else if (e.response?.statusCode == 401) {
        throw AuthenticationFailure(message: 'Authentication failed. Please login again.');
      } else {
        throw ServerFailure(message: 'Failed to get user profile');
      }
    } catch (e, stack) {
      log('Unexpected error in getUserProfile: $e', stackTrace: stack);
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    try {
      log('🔑 AuthRemoteDataSource.changePassword called');

      final response = await _dio.post(
        EnvConfig.changePasswordEndpoint,
        data: request.toJson(),
        options: Options(
          validateStatus: (status) => true,
        ),
      );

      log('Change password response status: ${response.statusCode}');
      log('Change password response data: ${response.data.toString()}');

      if (response.statusCode != 200) {
        if (response.statusCode == 400) {
          final errorResponse = ApiErrorResponse.fromJson(response.data ?? {});
          throw ValidationFailure(message: errorResponse.errorMessage);
        } else {
          final errorResponse = ApiErrorResponse.fromJson(response.data ?? {});
          throw ServerFailure(message: errorResponse.errorMessage);
        }
      }
    } on DioException catch (e, stack) {
      log('DioException in changePassword: $e', stackTrace: stack);
      
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkFailure(message: "Request timeout. Please check your connection and try again.");
      } else {
        throw ServerFailure(message: 'Failed to change password');
      }
    } catch (e, stack) {
      log('Unexpected error in changePassword: $e', stackTrace: stack);
      if (e is Failure) rethrow;
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<SecretLoginResponse> secretLogin(SecretLoginRequest request) async {
    try {
      log('🔐 AuthRemoteDataSource.secretLogin called');

      final response = await _dio.post(
        EnvConfig.secretLoginEndpoint,
        data: request.toJson(),
        options: Options(
          validateStatus: (status) => true,
        ),
      );

      log('Secret login response status: ${response.statusCode}');
      log('Secret login response data: ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['message'] == 'success') {
          return const SecretLoginResponse(
            success: true, 
            message: 'Authentication successful'
          );
        } else {
          return SecretLoginResponse(
            success: false,
            message: responseData['error'] ?? 
                     responseData['message'] ?? 
                     'Incorrect Password'
          );
        }
      } else {
        return SecretLoginResponse(
          success: false,
          message: response.data['message'] ?? 'Unexpected error occurred'
        );
      }
    } on DioException catch (e, stack) {
      log('DioException in secretLogin: $e', stackTrace: stack);
      
      String message = 'Unexpected error occurred';
      if (e.response?.data != null) {
        message = e.response!.data['message'] ?? message;
      }
      
      return SecretLoginResponse(success: false, message: message);
    } catch (e, stack) {
      log('Unexpected error in secretLogin: $e', stackTrace: stack);
      return SecretLoginResponse(success: false, message: 'Error: $e');
    }
  }
}
