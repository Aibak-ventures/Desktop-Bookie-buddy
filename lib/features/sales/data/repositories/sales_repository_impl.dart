import 'dart:developer';
import 'dart:typed_data';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/sales/data/datasources/sales_remote_datasource.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sales_request_model/sales_request_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class SalesRepositoryImpl implements ISalesRepository {
  final SalesRemoteDatasource _service;

  SalesRepositoryImpl({required SalesRemoteDatasource service})
      : _service = service;

  @override
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
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error getting sales pagination: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<SaleDetailsModel> getSaleDetails(int saleId) async {
    try {
      final response = await safeApiCall(() => _service.getSaleDetails(saleId));

      if (response.status.isSuccess) {
        return SaleDetailsModel.fromJson(response.data);
      }

      log('Failed to get sale: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error getting sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> createSale(SalesRequestModel salesRequest) async {
    try {
      final response = await safeApiCall(
        () => _service.createSale(salesRequest),
      );

      if (!response.status.isSuccess) {
        log('Failed to create sale: ${response.devMessage}');
        throw response.message ?? 'Failed to complete operation';
      }
    } catch (e, stack) {
      log('Error creating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
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
        throw response.message ?? 'Failed to complete operation';
      }
    } catch (e, stack) {
      log('Error updating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> deleteSale(int saleId) async {
    try {
      final response = await safeApiCall(() => _service.deleteSale(saleId));

      if (!response.status.isSuccess) {
        log('Failed to delete sale: ${response.devMessage}');
        throw response.message ?? 'Failed to complete operation';
      }
    } catch (e, stack) {
      log('Error deleting sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<Uint8List> getInvoicePdfBytes(int saleId) async {
    try {
      return await _service.getInvoicePdfBytes(saleId);
    } catch (e, stack) {
      log('Error getting invoice PDF: $e', stackTrace: stack);
      rethrow;
    }
  }
}
