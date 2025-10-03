import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/services/sales_service.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/models/sales_request_model/sales_request_model.dart';

class SalesRepository {
  final SalesService _service;

  SalesRepository({required SalesService service}) : _service = service;

  Future<PaginationModel<SaleModel>> getSalesPagination({
    required int page,
    String? search,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.getSalesPagination(
          page: page,
          search: search,
          fromDate: fromDate,
          toDate: toDate,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel.fromJson(
          response.data,
          (json) => SaleModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log('Failed to get sales pagination: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error getting sales pagination: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<SaleDetailsModel> getSaleDetails(int saleId) async {
    try {
      final response = await safeApiCall(() => _service.getSaleDetails(saleId));

      if (response.status.isSuccess) {
        return SaleDetailsModel.fromJson(response.data);
      }

      log('Failed to get sale: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error getting sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> createSale(SalesRequestModel salesRequest) async {
    try {
      final response = await safeApiCall(
        () => _service.createSale(salesRequest),
      );

      if (!response.status.isSuccess) {
        log('Failed to create sale: ${response.devMessage}');
        throw response.message;
      }
    } catch (e, stack) {
      log('Error creating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> updateSale(SalesRequestModel salesRequest) async {
    try {
      assert(
        salesRequest.id != null,
        'Sale ID must not be null when updating a sale.',
      );
      final response = await safeApiCall(
        () => _service.updateSale(salesRequest),
      );

      if (!response.status.isSuccess) {
        log('Failed to update sale: ${response.devMessage}');
        throw response.message;
      }
    } catch (e, stack) {
      log('Error updating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> deleteSale(int saleId) async {
    try {
      final response = await safeApiCall(() => _service.deleteSale(saleId));

      if (!response.status.isSuccess) {
        log('Failed to delete sale: ${response.devMessage}');
        throw response.message;
      }
    } catch (e, stack) {
      log('Error deleting sale: $e', stackTrace: stack);
      rethrow;
    }
  }
}
