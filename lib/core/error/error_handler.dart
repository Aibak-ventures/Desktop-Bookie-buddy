import 'dart:developer';

import 'package:bookie_buddy_web/core/error/exceptions/auth_exceptions.dart';
import 'package:bookie_buddy_web/core/error/exceptions/booking_exceptions.dart';
import 'package:bookie_buddy_web/core/error/exceptions/network_exceptions.dart';
import 'package:bookie_buddy_web/core/error/failures.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  static Failure handle(dynamic e) {
    log('Caught exception: $e');
    if (e is AuthException) {
      return AuthFailure(e.message);
    }
    if (e is NetworkException) {
      return NetworkFailure(
        e.message,
        e.errorCode,
      );
    }
    if (e is BookingException) {
      return BookingFailure(e.message);
    }
    // if (e is ProductException) {
    //   return ProductFailure(e.message);
    // }

    if (e is DioException) {
      return _handleDioError(e);
    }
    return const UnknownFailure('Unexpected error occurred');
  }

  static Failure _handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const DioFailure(
            'The connection is taking too long. Please try again.');
      case DioExceptionType.sendTimeout:
        return const DioFailure(
            'The request is taking too long to send. Check your internet.');
      case DioExceptionType.receiveTimeout:
        return const DioFailure('Waiting too long for a response. Try again.');
      case DioExceptionType.badCertificate:
        return const DioFailure(
            'Secure connection failed. Please contact support.');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final message = _mapStatusCodeToMessage(statusCode);
        return DioFailure(message);
      case DioExceptionType.cancel:
        return const DioFailure('The request was cancelled. Try again.');
      case DioExceptionType.connectionError:
        return const DioFailure(
            "Couldn't connect to the server. Please check your internet.");
      case DioExceptionType.unknown:
        return const DioFailure('Something went wrong. Please try again.');
    }
  }

  static String _mapStatusCodeToMessage(int? statusCode) {
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
        return 'Service temporarily unavailable. Try again later.';
      default:
        return "Unexpected error (${statusCode ?? 'unknown'}). Try again.";
    }
  }
}
