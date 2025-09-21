import 'package:dio/dio.dart';
import '../env/env_config.dart';
import 'uri_mixin.dart';
import 'interceptors/global_dio_interceptor.dart';

/// Base API Service class that follows clean architecture principles
/// This class handles all the common API functionality
class ApiService with UriMixin {
  late final Dio _dio;
  
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  
  ApiService._internal() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      connectTimeout: EnvConfig.connectTimeout,
      receiveTimeout: EnvConfig.receiveTimeout,
      sendTimeout: EnvConfig.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add the global interceptor
    _dio.interceptors.add(GlobalDioInterceptor());
    
    // Add logging interceptor in development
    if (EnvConfig.isDevelopment) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ));
    }
  }

  /// GET request method
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
  }) async {
    final url = getUri(endpoint, pathParams: pathParams, queryParameters: queryParameters);
    
    try {
      final response = await _dio.get(
        url,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// POST request method
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
  }) async {
    final url = getUri(endpoint, pathParams: pathParams, queryParameters: queryParameters);
    
    try {
      final response = await _dio.post(
        url,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// PUT request method
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
  }) async {
    final url = getUri(endpoint, pathParams: pathParams, queryParameters: queryParameters);
    
    try {
      final response = await _dio.put(
        url,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// DELETE request method
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
  }) async {
    final url = getUri(endpoint, pathParams: pathParams, queryParameters: queryParameters);
    
    try {
      final response = await _dio.delete(
        url,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// PATCH request method
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
  }) async {
    final url = getUri(endpoint, pathParams: pathParams, queryParameters: queryParameters);
    
    try {
      final response = await _dio.patch(
        url,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Handle Dio exceptions and convert them to app-specific exceptions
  Exception _handleDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');
      
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        final message = _extractErrorMessage(dioException.response?.data) ?? 
                       'An error occurred';
        return Exception('Server error ($statusCode): $message');
      
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      
      case DioExceptionType.badCertificate:
        return Exception('Certificate error');
      
      case DioExceptionType.unknown:
        return Exception(dioException.message ?? 'An unexpected error occurred');
    }
  }

  /// Extract error message from response data
  String? _extractErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      return responseData['message'] ?? 
             responseData['error'] ?? 
             responseData['detail'];
    }
    return null;
  }

  /// Get the underlying Dio instance (use sparingly)
  Dio get dio => _dio;
}
