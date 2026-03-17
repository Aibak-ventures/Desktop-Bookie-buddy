import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';

class LedgerSummaryModel {
  final UserShopModel shopDetails;
  final String fromDate;
  final String toDate;
  final double totalReceived;
  final double totalExpense;
  final double total;
  final double balance;

  final bool isSinglePdf;
  final List<LedgerInvoiceEntryModel> entries;
  final String pdfName;

  LedgerSummaryModel({
    required this.shopDetails,
    required this.fromDate,
    required this.toDate,
    required this.isSinglePdf,
    required this.totalReceived,
    required this.totalExpense,
    required this.total,
    required this.balance,
    required this.entries,
    this.pdfName = 'ledger',
  });
}
