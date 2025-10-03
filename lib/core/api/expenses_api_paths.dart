import 'package:bookie_buddy_web/core/api/api_config.dart';

class ExpensesApiPaths {
  static const _root = '${ApiConfig.v3}/expenses/';
  static const expenses = '${_root}expenses/';
  static const variantExpenses = '${_root}variant-expenses/';
  static const transactionHistory = '${_root}transaction-history/';
  static const daywiseSummary = '${_root}wallet/daywise-summary/';
  static const exportTransactionsExcel = '${_root}export-transactions/excel/';
}
