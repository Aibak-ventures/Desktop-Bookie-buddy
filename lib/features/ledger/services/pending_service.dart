import 'dart:developer';
import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

class PendingService {
  Dio get _dio => DioClient.dio;

  Future<CustomResponseModel> fetchPendingPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.ledger.pendingAmounts,
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log('Fetch Pending Pagination Response: ${response.realUri.toString()} ,${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch Pending Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
