import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/ledger_enums.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_expense_grouped_model/ledger_expense_grouped_model.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_bookings_grouped_model/ledger_bookings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_payment_grouped_model/ledger_payment_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_pendings_grouped_model/ledger_pendings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_sales_grouped_model/ledger_sales_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_security_amount_grouped_model/ledger_security_amount_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/data/datasources/ledger_remote_datasource.dart';
import 'package:path_provider/path_provider.dart';

class LedgerRepositoryImpl implements ILedgerRepository {
  final LedgerRemoteDatasource _datasource;

  LedgerRepositoryImpl({
    required LedgerRemoteDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<PaginationModel<LedgerSecurityAmountDailyModel>>
      getSecurityAmountsPagination({required int page, int? clientId}) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchSecurityAmountsPagination(
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
      throw response.message ?? 'Failed to get security amounts';
    } catch (e, stack) {
      log('Get Security Amounts Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<LedgerPendingsDailyModel>> getPendingPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchPendingPagination(
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
      throw response.message ?? 'Failed to get pending pagination';
    } catch (e, stack) {
      log('Get Pending Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<LedgerPaymentsDailyModel>> getPaymentsPagination({
    int page = 1,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchPaymentsPagination(
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
      throw response.message ?? 'Failed to get payments pagination';
    } catch (e, stack) {
      log('Get Payments Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<LedgerBookingDailyModel>> getBookingsPagination({
    int page = 1,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchBookingsPagination(
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
      throw response.message ?? 'Failed to get bookings pagination';
    } catch (e, stack) {
      log('Get ledger Bookings Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<LedgerSaleDailyModel>> getSalesPagination({
    int page = 1,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchSalesPagination(page: page, clientId: clientId),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerSaleDailyModel>.fromJson(
          response.data,
          (item) => LedgerSaleDailyModel.fromJson(item as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) =>
              LedgerSalesGroupedModel.fromCustomJson(
            dataJson as Map<String, dynamic>,
          ),
        );
      }
      log('Get ledger Sales Pagination Error: ${response.devMessage}');
      throw response.message ?? 'Failed to get sales pagination';
    } catch (e, stack) {
      log('Get ledger Sales Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<DailySummaryModel> getLedgerDaySummary({
    required String date,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchLedgerDayWiseSummary(
          date: date,
          clientId: clientId,
        ),
      );
      if (response.status.isSuccess) {
        return DailySummaryModel.fromJson(response.data);
      }
      log('Error fetching ledger day-wise summary: ${response.devMessage}');
      throw response.message ?? 'Failed to fetch ledger summary';
    } catch (e, stack) {
      log('Error fetching ledger day-wise summary: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<List<LedgerInvoiceEntryModel>> getLedgerInvoiceData({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchDataForInvoicePdf(
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
      throw response.message ?? 'Failed to get ledger invoice data';
    } catch (e, stack) {
      log('Get Ledger Invoice Data Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<String> downloadLedgerInvoice({
    required String fromDate,
    required String toDate,
    String type = 'all',
    LedgerType ledgerType = LedgerType.all,
    int? clientId,
  }) async {
    try {
      final dir =
          await getTemporaryDirectory(); // You can also use getExternalStorageDirectory()
      final filePath =
          '${dir.path}/${ledgerType.isAll ? 'ledger' : ledgerType.value}_report_${fromDate}_to_${toDate}.xlsx';
      final response = await safeApiCall(
        () => _datasource.downloadLedgerInvoice(
          fromDate: fromDate,
          toDate: toDate,
          type: type,
          clientId: clientId,
          filePath: filePath,
        ),
      );
      if (response != null) {
        log('Download Ledger Invoice Error: ${response.devMessage}');
        throw response.message ?? 'Failed to download ledger invoice';
      }
      return filePath;
    } catch (e, stack) {
      log('Error downloading ledger invoice: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<LedgerExpenseDailyModel>> getExpensePagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchExpensePagination(page: page),
      );
      if (response.status.isSuccess) {
        return PaginationModel<LedgerExpenseDailyModel>.fromJson(
          response.data,
          (item) =>
              LedgerExpenseDailyModel.fromJson(item as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) {
            final expenses = LedgerExpenseGroupedModel.fromCustomJson(
              dataJson as Map<String, dynamic>,
            );
            return expenses.dailyExpenses;
          },
        );
      }
      log('Get Expense Pagination Error: ${response.devMessage}');
      throw response.message ?? 'Failed to get expense pagination';
    } catch (e, stack) {
      log('Get Expense Pagination Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
