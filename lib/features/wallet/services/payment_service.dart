import 'dart:developer';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/payment_history_model/payment_history_model.dart';
import 'package:dio/dio.dart';

class PaymentService {
  final Dio _dio = DioClient.dio;

  Future<PaginationModel<MonthlyPaymentsModel>> fetchPaymentsPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v2/bookings/wallet/payment-details/',
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId
        },
      );
      log('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data =
            PaymentHistoryModel.fromJson(response.data['results']['payments']);
        return PaginationModel<MonthlyPaymentsModel>(
          data: data.monthlyPayments,
          totalData: response.data['count'],
          nextPageUrl: response.data['next'],
        );
      } else {
        log("Failed to load payments data ${response.statusCode}, data: ${response.data}");
        throw "Failed to load payments data";
      }
    } on DioException catch (e, stack) {
      log("Error loading payments: ${e.message}", stackTrace: stack);
      throw "Error loading payments: ${e.message}";
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchLedgerDayWiseSummary({
    required String date,
    int? clientId,
  }) async {
    try {
      log("date wise summary Date: $date");
      final response = await _dio.get(
        '/api/v1/expenses/wallet/daywise-summary/',
        queryParameters: {
          'date': date,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log('Response status code: ${response.statusCode}, response data: ${response.data}');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response.data['error'] ?? "Failed to load payments data";
      }
    } on DioException catch (e, stack) {
      log("Error loading payments: ${e.message}", stackTrace: stack);
      throw "Error loading payments: ${e.message}";
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
