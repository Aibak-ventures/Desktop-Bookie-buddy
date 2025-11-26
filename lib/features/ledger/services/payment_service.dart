import 'dart:developer';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/api_paths.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

class PaymentService {
  Dio get _dio => DioClient.dio;

  Future<CustomResponseModel> fetchPaymentsPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await _dio.get(
        ApiPaths.ledger.paymentDetails,
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log('Fetch Payments Pagination Response: ${response.realUri.toString()} ,${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error loading payments: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchLedgerDayWiseSummary({
    required String date,
    int? clientId,
  }) async {
    try {
      log('date wise summary Date: $date');
      final response = await _dio.get(
        ApiPaths.expenses.daywiseSummary,
        queryParameters: {
          'date': date,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log('ledger day wise summary response: ${response.realUri.toString()} ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching ledger day-wise summary: $e', stackTrace: stack);
      rethrow;
    }
  }
}
