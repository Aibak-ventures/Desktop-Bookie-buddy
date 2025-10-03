import 'package:bookie_buddy_web/core/error/exceptions/product_exceptions.dart';
import 'package:dio/dio.dart';

Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw 'Connection timed out. Please try again.';
    } else if (e.type == DioExceptionType.connectionError) {
      throw 'No internet connection.';
    } else if (e.type == DioExceptionType.badResponse) {
      throw _mapStatusCodeToMessage(e.response?.statusCode);
    } else if (e.type == DioExceptionType.sendTimeout) {
      throw 'Request timed out. Please check your connection and try again.';
    } else if (e.type == DioExceptionType.badCertificate) {
      throw 'Bad certificate error. Please check your connection.';
    } else if (e.type == DioExceptionType.cancel) {
      throw 'Request was cancelled. Please try again.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      throw 'Request timed out. Please check your connection and try again.';
    } else if (e.type == DioExceptionType.unknown) {
      throw 'Unknown error occurred. Please try again.';
    } else {
      throw 'Unexpected error: ${e.message}';
    }
  } on AppException catch (e) {
    throw e.message;
  } catch (e) {
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
