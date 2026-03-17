import 'dart:developer';

import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/utils/download_file_from_url.dart';
import 'package:dio/dio.dart';

class LedgerRemoteDatasource {
  final Dio _dio;

  LedgerRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<CustomResponseModel> fetchDataForInvoicePdf({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) async {
    try {
      final response = await _dio.get(
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
      final response = await _dio.get(
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
      final response = await _dio.get(
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
      final response = await _dio.get(
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
      final response = await _dio.get(
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

  Future<CustomResponseModel> fetchPaymentsPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.ledger.paymentDetails,
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
        ApiEndpoints.expenses.dayWiseSummary,
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
