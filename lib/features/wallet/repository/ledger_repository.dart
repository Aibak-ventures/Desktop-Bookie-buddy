import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/ledger_security_amount_model/ledger_security_amount_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/payment_history_model/payment_history_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/pending_model/ledger_pending_model.dart';
import 'package:bookie_buddy_web/features/wallet/services/ledger_service.dart';
import 'package:bookie_buddy_web/features/wallet/services/payment_service.dart';
import 'package:bookie_buddy_web/features/wallet/services/pending_service.dart';

class LedgerRepository {
  final LedgerService _ledgerService;
  final PendingService _balanceService;
  final PaymentService _paymentService;

  LedgerRepository({
    required LedgerService ledgerService,
    required PendingService balanceService,
    required PaymentService paymentService,
  })  : _ledgerService = ledgerService,
        _balanceService = balanceService,
        _paymentService = paymentService;

  Future<PaginationModel<LedgerSecurityAmountModel>>
      getSecurityAmountsPagination({
    required int page,
    int? clientId,
  }) async {
    return await _ledgerService.fetchSecurityAmountsPagination(
      page: page,
      clientId: clientId,
    );
  }

  Future<PaginationModel<LedgerPendingModel>> getPendingPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      return await _balanceService.fetchPendingPagination(
        page: page,
        clientId: clientId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginationModel<MonthlyPaymentsModel>> getPaymentsPagination({
    int page = 1,
    int? clientId,
  }) async {
    try {
      return await _paymentService.fetchPaymentsPagination(
        page: page,
        clientId: clientId,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Future<TodaySummary> getPaymentDaySummary({required String date}) async {
  //   try {
  //     final response = await _paymentService.fetchDayWiseSummary(
  //       date: date,
  //     );
  //     return TodaySummary.fromJson(response['payments']);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<int> getExpenseDaySummary({required String date}) async {
    try {
      final response = await _paymentService.fetchLedgerDayWiseSummary(
        date: date,
      );

      return response['expenses']['total'] as int;
    } catch (e) {
      rethrow;
    }
  }

  Future<DailySummaryModel> getLedgerDaySummary({
    required String date,
    int? clientId,
  }) async {
    try {
      final response = await _paymentService.fetchLedgerDayWiseSummary(
        date: date,
        clientId: clientId,
      );
      return DailySummaryModel.fromJson(response);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<List<LedgerInvoiceEntryModel>> getLedgerInvoiceData({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) async {
    return await _ledgerService.fetchDataForInvoicePdf(
      fromDate: fromDate,
      toDate: toDate,
      type: type,
      clientId: clientId,
    );
  }

  Future<String> downloadLedgerInvoice({
    required String fromDate,
    required String toDate,
    String type = 'all',
    int? clientId,
  }) async {
    return await _ledgerService.downloadLedgerInvoice(
      fromDate: fromDate,
      toDate: toDate,
      type: type,
      clientId: clientId,
    );
  }
}
