import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/utils/error/error_handler.dart';
import 'package:bookie_buddy_web/utils/error/exceptions/auth_exceptions.dart';
import 'package:bookie_buddy_web/utils/error/exceptions/booking_exceptions.dart';
import 'package:bookie_buddy_web/utils/error/exceptions/network_exceptions.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/home/models/desktop_dashboard_response.dart';
import 'package:dio/dio.dart';

class DashboardService {
  /// Fetches dashboard data from the new desktop-dashboard v4 API endpoint
  Future<DesktopDashboardResponse> fetchDesktopDashboardData({
    int page = 1,
    String? activeShopId,
  }) async {
    try {
      // Use the new desktop-dashboard endpoint
      final response = await DioClient.dio.get(
        '/api/v4/bookings/desktop-dashboard/',
        queryParameters: {
          'page': page,
        },
        options: Options(
          headers: {
            if (activeShopId != null && activeShopId.isNotEmpty)
              'X-Active-Shop-ID': activeShopId,
          },
        ),
      );

      if (response.statusCode != 200) {
        log('status code: ${response.statusCode}, data: ${response.data}');
      }

      _validateResponse(response);

      // API returns {status, message, data} - extract the inner 'data' object
      final responseData = response.data as Map<String, dynamic>;
      final innerData = responseData['data'] as Map<String, dynamic>;

      return DesktopDashboardResponse.fromJson(innerData);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw ErrorHandler.handle(e);
    }
  }

  /// Legacy method for backward compatibility - will be removed once migration is complete
  @Deprecated('Use fetchDesktopDashboardData instead')
  Future<CustomResponseModel> fetchDashboardData(
    int page, {
    bool isOngoing = false,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.bookings.dashboard,
        queryParameters: {
          'page': page,
          if (isOngoing) 'type': 'ongoing',
        },
      );

      if (response.statusCode != 200) {
        log('status code: ${response.statusCode}, data: ${response.data}');
      }

      // Keep your existing validation
      _validateResponse(response);

      // Use your old model here
      return CustomResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw ErrorHandler.handle(e);
    }
  }

  void _validateResponse(Response response) {
    final statusCode = response.statusCode;

    if (statusCode == null) {
      return;
    }

    switch (statusCode) {
      case >= 200 && < 300:
        // Success – no exception needed
        return;

      case 400:
        throw FailedBookingException(
            "Bad request. Please check your input.", 400);

      case 401:
        throw TokenExpiredException("Session expired. Please log in again.");

      case 403:
        throw FailedAuthException("Forbidden. You don't have permission.", 403);

      case 404:
        throw BookingNotFoundException();

      case 500:
        throw ServerException("Internal server error.", 500);

      case 503:
        throw ServerException("Service is unavailable. Try later.", 503);

      default:
        throw FailedNetworkException(
          "Unexpected error: ${statusCode}",
          statusCode,
        );
    }
  }
}
