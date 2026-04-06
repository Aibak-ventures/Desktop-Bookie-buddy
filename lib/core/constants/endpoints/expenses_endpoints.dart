import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class ExpensesEndpoints {
  static const _root = '${ApiConfig.v3}/expenses/';
  static const expenses = '${_root}expenses/';
  static const variantExpenses = '${_root}variant-expenses/';
  static const transactionHistory =
      '${ApiConfig.v4}/expenses/transaction-history/';
  static const daywiseSummary = '${_root}wallet/daywise-summary/';
  static const exportTransactionsExcel = '${_root}export-transactions/excel/';
}
