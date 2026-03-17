import 'package:bookie_buddy_web/core/constants/enums/ledger_enums.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_bookings_grouped_model/ledger_bookings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_expense_grouped_model/ledger_expense_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_payment_grouped_model/ledger_payment_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_pendings_grouped_model/ledger_pendings_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_sales_grouped_model/ledger_sales_grouped_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_security_amount_grouped_model/ledger_security_amount_grouped_model.dart';

abstract interface class ILedgerRepository {
  Future<PaginationModel<LedgerSecurityAmountDailyModel>>
      getSecurityAmountsPagination({required int page, int? clientId});

  Future<PaginationModel<LedgerPendingsDailyModel>> getPendingPagination({
    required int page,
    int? clientId,
  });

  Future<PaginationModel<LedgerPaymentsDailyModel>> getPaymentsPagination({
    int page = 1,
    int? clientId,
  });

  Future<PaginationModel<LedgerBookingDailyModel>> getBookingsPagination({
    int page = 1,
    int? clientId,
  });

  Future<PaginationModel<LedgerSaleDailyModel>> getSalesPagination({
    int page = 1,
    int? clientId,
  });

  Future<DailySummaryModel> getLedgerDaySummary({
    required String date,
    int? clientId,
  });

  Future<List<LedgerInvoiceEntryModel>> getLedgerInvoiceData({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  });

  Future<String> downloadLedgerInvoice({
    required String fromDate,
    required String toDate,
    String type = 'all',
    LedgerType ledgerType = LedgerType.all,
    int? clientId,
  });

  Future<PaginationModel<LedgerExpenseDailyModel>> getExpensePagination({
    required int page,
    int? clientId,
  });
}
