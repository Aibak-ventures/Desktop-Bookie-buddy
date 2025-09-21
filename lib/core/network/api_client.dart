import 'package:booking_application/core/env/env_config.dart';
import 'package:booking_application/core/network/uri_mixin.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'interceptors/global_dio_interceptor.dart';

class ApiClient with UriMixin {
  static ApiClient? _instance;
  late final Dio _dio;
  final Logger _logger = Logger();

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      connectTimeout: EnvConfig.connectTimeout,
      receiveTimeout: EnvConfig.receiveTimeout,
      sendTimeout: EnvConfig.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _setupInterceptors();
  }

  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(GlobalDioInterceptor());
    
    if (EnvConfig.isDevelopment) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (log) => _logger.d(log),
        ),
      );
    }
  }

  // GET Request
  Future<Response<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final uri = getUri(endpoint, queryParameters: queryParameters, pathParams: pathParams);
    
    return await _dio.get<T>(
      uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // POST Request
  Future<Response<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final uri = getUri(endpoint, queryParameters: queryParameters, pathParams: pathParams);
    
    return await _dio.post<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // PUT Request
  Future<Response<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final uri = getUri(endpoint, queryParameters: queryParameters, pathParams: pathParams);
    
    return await _dio.put<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // PATCH Request
  Future<Response<T>> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final uri = getUri(endpoint, queryParameters: queryParameters, pathParams: pathParams);
    
    return await _dio.patch<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // DELETE Request
  Future<Response<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final uri = getUri(endpoint, queryParameters: queryParameters, pathParams: pathParams);
    
    return await _dio.delete<T>(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Download File
  Future<Response> download(
    String endpoint,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    final uri = getUri(endpoint, queryParameters: queryParameters, pathParams: pathParams);
    
    return await _dio.download(
      uri,
      savePath,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      options: options,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // Upload File
  Future<Response<T>> upload<T>(
    String endpoint,
    FormData formData, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    final uri = getUri(endpoint, queryParameters: queryParameters, pathParams: pathParams);
    
    return await _dio.post<T>(
      uri,
      data: formData,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }
}
