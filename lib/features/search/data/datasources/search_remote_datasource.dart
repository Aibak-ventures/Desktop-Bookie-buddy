import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

class SearchRemoteDatasource {
  final Dio _dio;

  SearchRemoteDatasource({required Dio dio}) : _dio = dio;

  /// fetch global search
  Future<CustomResponseModel> fetchGlobalSearch({
    required int page,
    String? searchQuery,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.search.globalSearch,
        queryParameters: {
          'page': page,
          'search': searchQuery,
          'start_date': startDate,
          'end_date': endDate,
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
