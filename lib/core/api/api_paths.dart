import 'package:bookie_buddy_web/core/api/api_config.dart';
import 'package:bookie_buddy_web/core/api/auth_api_paths.dart';
import 'package:bookie_buddy_web/core/api/bookings_api_paths.dart';
import 'package:bookie_buddy_web/core/api/expenses_api_paths.dart';
import 'package:bookie_buddy_web/core/api/ledger_api_paths.dart';
import 'package:bookie_buddy_web/core/api/notifications_api_paths.dart';
import 'package:bookie_buddy_web/core/api/sales_api_paths.dart';
import 'package:bookie_buddy_web/core/api/service_api_paths.dart';
import 'package:bookie_buddy_web/core/api/shop_api_paths.dart';
import 'package:bookie_buddy_web/core/api/staff_api_paths.dart';

/// Centralized, namespaced API paths facade used across the app.
///
/// Exposes strongly-typed "namespaces" so call sites can use
/// `ApiPaths.auth.login`, `ApiPaths.bookings.bookingsV4`, etc.
class ApiPaths {
  ApiPaths._(); // private constructor to prevent instantiation

  // Optional: API version segments
  static const config = _ApiConfigNamespace();

  static const auth = _AuthNamespace();
  static const shop = _ShopNamespace();
  static const service = _ServiceNamespace();
  static const bookings = _BookingsNamespace();
  static const sales = _SalesNamespace();
  static const expenses = _ExpensesNamespace();
  static const ledger = _LedgerNamespace();
  static const notifications = _NotificationsNamespace();
  static const staff = _StaffNamespace();
}

class _ApiConfigNamespace {
  const _ApiConfigNamespace();
  String get v => ApiConfig.v;
  String get v3 => ApiConfig.v3;
  String get v4 => ApiConfig.v4;
}

class _AuthNamespace {
  const _AuthNamespace();
  String get login => AuthApiPaths.login;
  String get walletLogin => AuthApiPaths.walletLogin;
  String get changePassword => AuthApiPaths.changePassword;
  String get changeSecondaryPassword => AuthApiPaths.changeSecondaryPassword;
  String get refresh => AuthApiPaths.refresh;
  String get profile => AuthApiPaths.profile;
}

class _ShopNamespace {
  const _ShopNamespace();
  String get availableShops => ShopApiPaths.availableShops;
  String get privacySettings => ShopApiPaths.privacySettings;
  String get updateSettings => ShopApiPaths.updateSettings;
}

class _ServiceNamespace {
  const _ServiceNamespace();
  String get selected => ServiceApiPaths.selected;
  String get productSearch => ServiceApiPaths.productSearch;
  String get productsRoot => ServiceApiPaths.productsRoot;
  String productById(String id) => ServiceApiPaths.productById(id);
  String monthlySummary(String id) => ServiceApiPaths.monthlySummary(id);

  // Product Transfer
  String get matchProduct => ServiceApiPaths.matchProduct;
  String get transferHistory => ServiceApiPaths.transferHistory;
  String get transferStock => ServiceApiPaths.transferStock;
}

class _BookingsNamespace {
  const _BookingsNamespace();
  String get bookingsV3 => BookingsApiPaths.bookingsV3;
  String get bookingsV4 => BookingsApiPaths.bookingsV4;
  String get bookingsV5 => BookingsApiPaths.bookingsV5;
  String get addPayment => BookingsApiPaths.addPayment;
  String get updateDetails => BookingsApiPaths.updateDetails;
  String get updateDeliveryStatus => BookingsApiPaths.updateDeliveryStatus;
  String get updateBookingStatus => BookingsApiPaths.updateBookingStatus;
  String get oldBookings => BookingsApiPaths.oldBookings;
  String get clients => BookingsApiPaths.clients;
  String get availableProducts => BookingsApiPaths.availableProducts;
  String get dashboard => BookingsApiPaths.dashboard;
}

class _SalesNamespace {
  const _SalesNamespace();
  String get sales => SalesApiPaths.sales;
  String get updateSale => SalesApiPaths.updateSale;
}

class _ExpensesNamespace {
  const _ExpensesNamespace();
  String get expenses => ExpensesApiPaths.expenses;
  String get variantExpenses => ExpensesApiPaths.variantExpenses;
  String get transactionHistory => ExpensesApiPaths.transactionHistory;
  String get daywiseSummary => ExpensesApiPaths.daywiseSummary;
  String get exportTransactionsExcel =>
      ExpensesApiPaths.exportTransactionsExcel;
}

class _LedgerNamespace {
  const _LedgerNamespace();
  String get expenses => LedgerApiPaths.expenses;
  String get pendingAmounts => LedgerApiPaths.pendingAmounts;
  String get securityAmounts => LedgerApiPaths.securityAmounts;
  String get bookingAmounts => LedgerApiPaths.bookingAmounts;
  String get sales => LedgerApiPaths.sales;
  String get paymentDetails => LedgerApiPaths.paymentDetails;
  String get dailySummary => LedgerApiPaths.dailySummary;
}

class _NotificationsNamespace {
  const _NotificationsNamespace();
  String get register => NotificationsApiPaths.register;
  String get remove => NotificationsApiPaths.remove;
  String get updateShop => NotificationsApiPaths.updateShop;
}

class _StaffNamespace {
  const _StaffNamespace();
  String get staff => StaffApiPaths.staff;
  String get staffMonthlyBookingsOrSales =>
      StaffApiPaths.staffMonthlyBookingsOrSales;
  String get staffAnalyticsReport => StaffApiPaths.staffAnalyticsReport;
  String staffById(int id) => StaffApiPaths.staffById(id);
  String staffAnalyticsReportById(int id) =>
      StaffApiPaths.staffAnalyticsReportById(id);
}
