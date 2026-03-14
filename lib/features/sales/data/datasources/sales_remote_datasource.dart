import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sales_request_model/sales_request_model.dart';
import 'package:dio/dio.dart';

class SalesRemoteDatasource {
  Dio get _dio => DioClient.dio;

  Future<CustomResponseModel> getSalesPagination({
    int page = 1,
    String? search,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      log('🔄 Fetching sales - Page: $page, Search: $search, From: $fromDate, To: $toDate');

      final response = await _dio.get(
        ApiEndpoints.sales.sales,
        queryParameters: {
          'page': page,
          if (search != null && search.isNotEmpty) 'search': search,
          if (fromDate != null && fromDate.isNotEmpty) 'from': fromDate,
          if (toDate != null && toDate.isNotEmpty) 'to': toDate,
        },
      );

      log('✅ Sales API Response: ${response.realUri}');
      log('📊 Status Code: ${response.statusCode}');
      log('📦 Data Count: ${(response.data['data'] as Map?)?['count'] ?? 0}');

      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error fetching sales: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> getSaleDetails(int saleId) async {
    try {
      final response = await _dio.get(ApiEndpoints.sales.salesDetailV4(saleId));
      log('Sales get response: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error get sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> createSale(SalesRequestModel salesRequest) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.sales.salesV4,
        data: salesRequest.toJson(),
      );
      log('Sales create response: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error creating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateSale(SalesRequestModel salesRequest) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.sales.updateSaleV4(salesRequest.id!),
        data: salesRequest.toJson(),
      );
      log('Sales update response: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Future<CustomResponseModel> updateSaleVariants({
  //   required int saleId,
  //   required List<ProductSelectedModel> products,
  // }) async {
  //   try {
  //     final response = await _dio.patch(
  //       '${ApiPaths.salesUpdateVariant}/$saleId/',
  //       data: {
  //         'variants': products
  //             .map((e) => e.toCustomJson(includeMeasurement: false))
  //             .toList(),
  //       },
  //     );
  //     log('Sales update variants response: ${response.data}');
  //     return CustomResponseModel.fromJson(response.data);
  //   } catch (e, stack) {
  //     log('Error updating sale: $e', stackTrace: stack);
  //     rethrow;
  //   }
  // }

  Future<CustomResponseModel> deleteSale(int saleId) async {
    try {
      final response =
          await _dio.delete(ApiEndpoints.sales.deleteSaleV4(saleId));
      log('Sales delete response: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error deleting sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get invoice PDF bytes for viewing/downloading
  Future<Uint8List> getInvoicePdfBytes(int saleId) async {
    try {
      final url = ApiEndpoints.sales.downloadInvoice(saleId);
      log('Fetching sale invoice PDF from: $url');

      final response = await _dio.get(
        url,
        queryParameters: {'send_whatsapp': false},
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        log('Invoice PDF fetched successfully, size: ${response.data.length} bytes');
        return Uint8List.fromList(response.data as List<int>);
      } else {
        // Decode the JSON error body from bytes to show the actual backend message
        String errorMessage =
            'Failed to fetch invoice (HTTP ${response.statusCode})';
        try {
          final jsonStr = utf8.decode(response.data as List<int>);
          final jsonBody = jsonDecode(jsonStr) as Map<String, dynamic>;
          final msg = jsonBody['message'] as String?;
          final devMsg = jsonBody['dev_message'] as String?;
          if (msg != null && msg.isNotEmpty) {
            errorMessage = msg;
            log('Backend error: $msg | dev: $devMsg');
          }
        } catch (_) {}
        log('Error fetching invoice PDF: ${response.statusCode} - $errorMessage');
        throw errorMessage;
      }
    } catch (e, stack) {
      log('Error fetching sale invoice PDF: $e', stackTrace: stack);
      rethrow;
    }
  }
}
