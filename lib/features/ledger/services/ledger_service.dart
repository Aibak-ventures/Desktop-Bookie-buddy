import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/utils/download_file_from_url.dart';

class LedgerService {
  Future<CustomResponseModel> fetchDataForInvoicePdf({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.expenses.transactionHistory,
        queryParameters: {
          'from_date': fromDate,
          'to_date': toDate,
          'type': type,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log('Fetch data for invoice pdf Response: ${response.realUri.toString()} ,${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching data for invoice pdf: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel?> downloadLedgerInvoice({
    required String fromDate,
    required String toDate,
    required String filePath,
    int? clientId,
    String type = 'all',
  }) async =>
      downloadFileFromUrl(
        url: ApiEndpoints.expenses.exportTransactionsExcel,
        filePath: filePath,
        queryParameters: {
          'from_date': fromDate,
          'to_date': toDate,
          'type': type,
          if (clientId != null) 'client_id': clientId,
        },
      );

  Future<CustomResponseModel> fetchSecurityAmountsPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.ledger.securityAmounts,
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );

      log(response.realUri.toString());
      // log('Fetch ledger Security Amounts Pagination Response: ${response.realUri.toString()} ,${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log(
        'Error fetching ledger security amounts pagination: $e',
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchBookingsPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.ledger.bookingAmounts,
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log('Fetch ledger Bookings Pagination Response: ${response.realUri.toString()} ,${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching ledger bookings pagination: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchSalesPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.ledger.sales,
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log(
      //   'Fetch ledger sales Pagination Response: ${response.realUri.toString()} ,${response.data}',
      // );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching ledger sales pagination: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Fetch all expenses
  Future<CustomResponseModel> fetchExpensePagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.ledger.expenses,
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log('Fetch Expenses Response: ${response.realUri.toString()}, Data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch Expenses Error: ${e}', stackTrace: stack);
      rethrow;
    }
  }
}
