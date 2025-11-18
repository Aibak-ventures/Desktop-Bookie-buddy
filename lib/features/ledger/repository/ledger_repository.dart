import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/enums/invoice_enums.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/ledger/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_bookings_grouped_model/ledger_bookings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_payment_grouped_model/ledger_payment_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_pendings_grouped_model/ledger_pendings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_sales_grouped_model/ledger_sales_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_security_amount_grouped_model/ledger_security_amount_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/services/ledger_service.dart';
import 'package:bookie_buddy_web/features/ledger/services/payment_service.dart';
import 'package:bookie_buddy_web/features/ledger/services/pending_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

class LedgerRepository {
  final LedgerService _ledgerService;
  final PendingService _balanceService;
  final PaymentService _paymentService;

  LedgerRepository({
    required LedgerService ledgerService,
    required PendingService balanceService,
    required PaymentService paymentService,
  }) : _ledgerService = ledgerService,
       _balanceService = balanceService,
       _paymentService = paymentService;

  Future<PaginationModel<LedgerSecurityAmountDailyModel>>
  getSecurityAmountsPagination({required int page, int? clientId}) async {
    try {
      final response = await safeApiCall(
        () => _ledgerService.fetchSecurityAmountsPagination(
          page: page,
          clientId: clientId,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerSecurityAmountDailyModel>.fromJson(
          response.data,
          (item) => LedgerSecurityAmountDailyModel.fromJson(
            item as Map<String, dynamic>,
          ),
          customJsonParser: (dataJson, itemFromJson) {
            final data = LedgerSecurityAmountGroupedModel.fromCustomJson(
              dataJson as Map<String, dynamic>,
            );
            return data.dailySecurityAmounts;
          },
        );
      }
      log('Get Security Amounts Pagination Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get Security Amounts Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<LedgerPendingsDailyModel>> getPendingPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _balanceService.fetchPendingPagination(
          page: page,
          clientId: clientId,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerPendingsDailyModel>.fromJson(
          response.data,
          (item) =>
              LedgerPendingsDailyModel.fromJson(item as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) {
            final data = LedgerPendingsGroupedModel.fromCustomJson(
              dataJson as Map<String, dynamic>,
            );
            return data.dailyPendings;
          },
        );
      }
      log('Get Pending Pagination Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get Pending Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<LedgerPaymentsDailyModel>> getPaymentsPagination({
    int page = 1,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _paymentService.fetchPaymentsPagination(
          page: page,
          clientId: clientId,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerPaymentsDailyModel>.fromJson(
          response.data,
          (item) =>
              LedgerPaymentsDailyModel.fromJson(item as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) {
            final data = LedgerPaymentGroupedModel.fromCustomJson(dataJson);
            return data.dailyPayments;
          },
        );
      }
      log('Get Payments Pagination Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get Payments Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<LedgerBookingDailyModel>> getBookingsPagination({
    int page = 1,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _ledgerService.fetchBookingsPagination(
          page: page,
          clientId: clientId,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerBookingDailyModel>.fromJson(
          response.data,
          (item) =>
              LedgerBookingDailyModel.fromJson(item as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) =>
              LedgerBookingsGroupedModel.fromCustomJson(
                dataJson as Map<String, dynamic>,
              ).dailyBookings,
        );
      }
      log('Get ledger Bookings Pagination Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get ledger Bookings Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<LedgerSaleDailyModel>> getSalesPagination({
    int page = 1,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () =>
            _ledgerService.fetchSalesPagination(page: page, clientId: clientId),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerSaleDailyModel>.fromJson(
          response.data,
          (item) => LedgerSaleDailyModel.fromJson(item as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) =>
              LedgerSalesGroupedModel.fromCustomJson(
                dataJson as Map<String, dynamic>,
              ).dailySales,
        );
      }
      log('Get ledger Sales Pagination Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get ledger Sales Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<DailySummaryModel> getLedgerDaySummary({
    required String date,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _paymentService.fetchLedgerDayWiseSummary(
          date: date,
          clientId: clientId,
        ),
      );
      if (response.status.isSuccess) {
        return DailySummaryModel.fromJson(response.data);
      }
      log('Error fetching ledger day-wise summary: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error fetching ledger day-wise summary: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<List<LedgerInvoiceEntryModel>> getLedgerInvoiceData({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) async {
    try {
      final response = await safeApiCall(
        () => _ledgerService.fetchDataForInvoicePdf(
          fromDate: fromDate,
          toDate: toDate,
          type: type,
          clientId: clientId,
        ),
      );
      if (response.status.isSuccess) {
        return (response.data as List)
            .map(
              (item) => LedgerInvoiceEntryModel.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      }
      log('Get Ledger Invoice Data Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get Ledger Invoice Data Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<String> downloadLedgerInvoice({
    required String fromDate,
    required String toDate,
    String type = 'all',
    LedgerType ledgerType = LedgerType.all,
    int? clientId,
  }) async {
    try {
      final fileName =
          '${ledgerType.isAll ? 'ledger' : ledgerType.value}_report_${fromDate}_to_${toDate}.xlsx';
      
      // For web, we'll handle the file differently
      if (kIsWeb) {
        // Web implementation - we'll return a temp path that won't be used
        final response = await safeApiCall(
          () => _ledgerService.downloadLedgerInvoice(
            fromDate: fromDate,
            toDate: toDate,
            type: type,
            clientId: clientId,
            filePath: fileName, // Just pass filename for web
          ),
        );
        if (response != null) {
          log('Download Ledger Invoice Error: ${response.devMessage}');
          throw response.message;
        }
        return fileName; // Return filename for web
      }
      
      // Windows Desktop - use Downloads folder
      String filePath;
      if (Platform.isWindows) {
        final downloadsDir = Directory('${Platform.environment['USERPROFILE']}\\Downloads');
        if (!downloadsDir.existsSync()) {
          downloadsDir.createSync(recursive: true);
        }
        filePath = '${downloadsDir.path}\\$fileName';
      } else {
        // Mobile - use temp directory
        final dir = await getTemporaryDirectory();
        filePath = '${dir.path}/$fileName';
      }
      final response = await safeApiCall(
        () => _ledgerService.downloadLedgerInvoice(
          fromDate: fromDate,
          toDate: toDate,
          type: type,
          clientId: clientId,
          filePath: filePath,
        ),
      );
      if (response != null) {
        log('Download Ledger Invoice Error: ${response.devMessage}');
        throw response.message;
      }
      return filePath;
    } catch (e, stack) {
      log('Error downloading ledger invoice: $e', stackTrace: stack);
      rethrow;
    }
  }
}
