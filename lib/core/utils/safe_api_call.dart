import 'package:bookie_buddy_web/core/error/exceptions/product_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } on DioException catch (e) {
    // Log the error for debugging
    if (kDebugMode) {
      print(
          'HTTP Error - Status: ${e.response?.statusCode}, Type: ${e.type}, Message: ${e.message}');
      print('*** DioException ***:');
      print('uri: ${e.requestOptions.uri}');
      print('${e.toString()}');
    }

    if (e.type == DioExceptionType.connectionTimeout) {
      throw 'Connection timed out. Please try again.';
    } else if (e.type == DioExceptionType.connectionError) {
      // Provide specific CORS error message for web development
      if (kIsWeb) {
        if (kDebugMode) {
          throw 'CORS Error: Please run the app with CORS disabled.\n'
              'Use: run_web_dev.bat or flutter run -d chrome --web-browser-flag "--disable-web-security"\n'
              'Or install a CORS browser extension for development.';
        } else {
          throw 'Network connection error. Please check your internet connection.';
        }
      } else {
        throw 'No internet connection.';
      }
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;

      // Try to extract error message from response
      String? serverMessage;
      if (responseData is Map<String, dynamic>) {
        serverMessage = responseData['message'] ??
            responseData['error'] ??
            responseData['detail'];
      }

      // Use server message if available, otherwise use status code mapping
      if (serverMessage != null && serverMessage.isNotEmpty) {
        throw serverMessage;
      } else {
        throw _mapStatusCodeToMessage(statusCode);
      }
    } else if (e.type == DioExceptionType.sendTimeout) {
      throw 'Request timed out. Please check your connection and try again.';
    } else if (e.type == DioExceptionType.badCertificate) {
      throw 'Security certificate error. Please check your connection.';
    } else if (e.type == DioExceptionType.cancel) {
      throw 'Request was cancelled. Please try again.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      throw 'Server response timeout. Please check your connection and try again.';
    } else if (e.type == DioExceptionType.unknown) {
      if (kDebugMode) {
        throw 'Unknown network error: ${e.message ?? "Please try again."}';
      } else {
        throw 'Network error occurred. Please try again.';
      }
    } else {
      throw 'Unexpected error: ${e.message ?? "Something went wrong."}';
    }
  } on AppException catch (e) {
    throw e.message;
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print('Unexpected error in safeApiCall: $e');
      print('StackTrace: $stackTrace');
    }
    throw 'Something went wrong. Please try again.';
  }
}

String _mapStatusCodeToMessage(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request. Please check your input.';
    case 401:
      return 'Unauthorized access. Please login again.';
    case 403:
      return "You don't have permission to access this.";
    case 404:
      return 'Requested resource not found.';
    case 409:
      return 'Conflict detected. This may already exist.';
    case 422:
      return 'Unprocessable request. Check submitted data.';
    case 500:
      return 'Internal server error. Please try again later.';
    case 503:
    case 502:
      return 'Service temporarily unavailable. Try again later.';
    default:
      return "Unexpected error (${statusCode ?? 'unknown'}). Try again.";
  }
}
