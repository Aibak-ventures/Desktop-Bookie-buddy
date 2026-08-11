import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:dio/dio.dart';

class GlobalSearchRemoteDatasource {
  const GlobalSearchRemoteDatasource(this._dio);

  final Dio _dio;

  Future<CustomResponseModel> fetchGlobalSearch({
    required int page,
    String? searchQuery,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.bookings.desktopList,
        queryParameters: {
          'page': page,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
          if (startDate != null && startDate.isNotEmpty)
            'start_date': startDate,
          if (endDate != null && endDate.isNotEmpty) 'end_date': endDate,
        },
      );
      log(
        'fetch global search response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching global search: $e', stackTrace: stack);
      rethrow;
    }
  }
}
