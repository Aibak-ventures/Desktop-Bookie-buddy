import 'package:bookie_buddy_web/core/network/endpoints/api_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/auth_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/bookings_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/customization_work_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/expenses_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/ledger_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/notifications_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/product_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/sales_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/search_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/service_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/shop_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/staff_endpoints.dart';
import 'package:bookie_buddy_web/core/network/endpoints/tailor_endpoints.dart';

/// Centralized, namespaced API paths facade used across the app.
///
/// Exposes strongly-typed "namespaces" so call sites can use
/// `ApiPaths.auth.login`, `ApiPaths.bookings.bookingsV4`, etc.
class ApiEndpoints {
  ApiEndpoints._(); // private constructor to prevent instantiation

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
  static const tailor = _TailorNamespace();
  static const customizationWork = _CustomizationWorkNamespace();
  static const products = _ProductsNamespace();
  static const search = SearchEndpoints();
}

class _ApiConfigNamespace {
  const _ApiConfigNamespace();
  String get v => ApiConfig.v;
  String get v3 => ApiConfig.v3;
  String get v4 => ApiConfig.v4;
}

class _AuthNamespace {
  const _AuthNamespace();
  String get login => AuthEndpoints.login;
  String get walletLogin => AuthEndpoints.walletLogin;
  String get changePassword => AuthEndpoints.changePassword;
  String get changeSecondaryPassword => AuthEndpoints.changeSecondaryPassword;
  String get refresh => AuthEndpoints.refresh;
  String get profile => AuthEndpoints.profile;
}

class _ShopNamespace {
  const _ShopNamespace();
  String get availableShops => ShopEndpoints.availableShops;
  String get privacySettings => ShopEndpoints.privacySettings;
  String get updateSettings => ShopEndpoints.updateSettings;

  // Shop Summary
  String allShopSummary({
    required int year,
    required int month,
    int? shopId,
  }) =>
      ShopEndpoints.allShopSummary(
        year: year,
        month: month,
        shopId: shopId,
      );

  // Activity Logs
  String get activityLogs => ShopEndpoints.activityLogs;
  String get recentActivities => ShopEndpoints.recentActivities;
  String activityLogsByDate(String date) =>
      ShopEndpoints.activityLogsByDate(date);
}

class _ServiceNamespace {
  const _ServiceNamespace();
  String get selected => ServiceEndpoints.selected;
  String get productSearch => ServiceEndpoints.productSearch;
  String get productsRoot => ServiceEndpoints.productsRoot;
  String productById(String id) => ServiceEndpoints.productById(id);
  String monthlySummary(String id) => ServiceEndpoints.monthlySummary(id);

  // Product Transfer
  String get matchProduct => ServiceEndpoints.matchProduct;
  String get transferHistory => ServiceEndpoints.transferHistory;
  String get transferStock => ServiceEndpoints.transferStock;
}

class _BookingsNamespace {
  const _BookingsNamespace();
  String get bookingsV3 => BookingsEndpoints.bookingsV3;
  String get bookingsV4 => BookingsEndpoints.bookingsV4;
  String get bookingsV5 => BookingsEndpoints.bookingsV5;
  String get desktopList => BookingsEndpoints.desktopList;
  String get addPayment => BookingsEndpoints.addPayment;
  String addRefund(int bookingId) => BookingsEndpoints.addRefund(bookingId);
  String get updateDetails => BookingsEndpoints.updateDetails;
  String get updateDeliveryStatus => BookingsEndpoints.updateDeliveryStatus;
  String get updateBookingStatus => BookingsEndpoints.updateBookingStatus;
  String get oldBookings => BookingsEndpoints.oldBookings;
  String get clients => BookingsEndpoints.clients;
  String get availableProducts => BookingsEndpoints.availableProducts;
  String get dashboard => BookingsEndpoints.dashboard;
  String deletePayment(int id) => BookingsEndpoints.deletePayment(id);
  String sendBookingInvoice(int bookingId) =>
      BookingsEndpoints.sendBookingInvoice(bookingId);
  String downloadBookingInvoice(int bookingId) =>
      BookingsEndpoints.downloadBookingInvoice(bookingId);
  String clientById(int id) => BookingsEndpoints.clientById(id); // Added
}

class _SalesNamespace {
  const _SalesNamespace();
  // v4 paths (all CRUD operations use v4)
  String get sales => SalesEndpoints.sales;
  String get salesV4 => SalesEndpoints.salesV4;
  String salesDetailV4(int id) => SalesEndpoints.salesDetailV4(id);
  String updateSaleV4(int id) => SalesEndpoints.updateSaleV4(id);
  String deleteSaleV4(int id) => SalesEndpoints.deleteSaleV4(id);

  // v3 paths (invoice only)
  String downloadInvoice(int id) => SalesEndpoints.downloadInvoice(id);
}

class _ExpensesNamespace {
  const _ExpensesNamespace();
  String get expenses => ExpensesEndpoints.expenses;
  String get variantExpenses => ExpensesEndpoints.variantExpenses;
  String get transactionHistory => ExpensesEndpoints.transactionHistory;
  String get dayWiseSummary => ExpensesEndpoints.daywiseSummary;
  String get exportTransactionsExcel =>
      ExpensesEndpoints.exportTransactionsExcel;
}

class _LedgerNamespace {
  const _LedgerNamespace();
  String get expenses => LedgerEndpoints.expenses;
  String get pendingAmounts => LedgerEndpoints.pendingAmounts;
  String get securityAmounts => LedgerEndpoints.securityAmounts;
  String get bookingAmounts => LedgerEndpoints.bookingAmounts;
  String get sales => LedgerEndpoints.sales;
  String get paymentDetails => LedgerEndpoints.paymentDetails;
  String get dailySummary => LedgerEndpoints.dailySummary;
}

class _NotificationsNamespace {
  const _NotificationsNamespace();
  String get register => NotificationsEndpoints.register;
  String get remove => NotificationsEndpoints.remove;
  String get updateShop => NotificationsEndpoints.updateShop;
}

class _StaffNamespace {
  const _StaffNamespace();
  String get staff => StaffEndpoints.staff;
  String get staffMonthlyBookingsOrSales =>
      StaffEndpoints.staffMonthlyBookingsOrSales;
  String get staffAnalyticsReport => StaffEndpoints.staffAnalyticsReport;
  String staffById(int id) => StaffEndpoints.staffById(id);
  String staffAnalyticsReportById(int id) =>
      StaffEndpoints.staffAnalyticsReportById(id);

  // Staff Management
  String restoreStaff(int id) => StaffEndpoints.restoreStaff(id);
  String deactivateStaff(int id) => StaffEndpoints.deactivateStaff(id);
}

class _TailorNamespace {
  const _TailorNamespace();
  String get tailors => TailorEndpoints.tailors;
  String tailorById(int id) => TailorEndpoints.tailorById(id);
  String tailorMonthlySummary(int id) =>
      TailorEndpoints.tailorMonthlySummary(id);
  String restoreDeletedTailor(int id) =>
      TailorEndpoints.restoreDeletedTailor(id);
}

class _CustomizationWorkNamespace {
  const _CustomizationWorkNamespace();

  // CRUD Operations
  String get customizationWorks =>
      CustomizationWorkEndpoints.customizationWorks;
  String customizationWorkDetail(int id) =>
      CustomizationWorkEndpoints.customizationWorkDetail(id);
  String updateCustomizationWork(int id) =>
      CustomizationWorkEndpoints.updateCustomizationWork(id);
  String deleteCustomizationWork(int id) =>
      CustomizationWorkEndpoints.deleteCustomizationWork(id);

  // Status Management
  String markAsCompleted(int id) =>
      CustomizationWorkEndpoints.markAsCompleted(id);
  String markAsPending(int id) => CustomizationWorkEndpoints.markAsPending(id);
  String markAsInProgress(int id) =>
      CustomizationWorkEndpoints.markAsInProgress(id);

  // Filtering & Search
  String get searchCustomizationWorks =>
      CustomizationWorkEndpoints.searchCustomizationWorks;
  String get filterByStatus => CustomizationWorkEndpoints.filterByStatus;
}

class _ProductsNamespace {
  const _ProductsNamespace();

  // CRUD Operations
  String get products => ProductEndpoints.products;
  String productDetail(int id) => ProductEndpoints.productDetail(id);
  String updateProduct(int id) => ProductEndpoints.updateProduct(id);
  String deleteProduct(int id) => ProductEndpoints.deleteProduct(id);

  // Product Variants
  String productVariants(int productId) =>
      ProductEndpoints.productVariants(productId);
  String createProductVariant(int productId) =>
      ProductEndpoints.createProductVariant(productId);
  String productVariantDetail(int productId, int variantId) =>
      ProductEndpoints.productVariantDetail(productId, variantId);
  String updateProductVariant(int productId, int variantId) =>
      ProductEndpoints.updateProductVariant(productId, variantId);
  String deleteProductVariant(int productId, int variantId) =>
      ProductEndpoints.deleteProductVariant(productId, variantId);

  // Product Materials
  String productMaterials(int productId) =>
      ProductEndpoints.productMaterials(productId);
  String addProductMaterial(int productId) =>
      ProductEndpoints.addProductMaterial(productId);
  String removeProductMaterial(int productId, int materialId) =>
      ProductEndpoints.removeProductMaterial(productId, materialId);

  // Availability & Stock
  String checkAvailability(int productId) =>
      ProductEndpoints.checkAvailability(productId);
  String updateStock(int productId) => ProductEndpoints.updateStock(productId);
  String get lowStockProducts => ProductEndpoints.lowStockProducts;
  String get outOfStockProducts => ProductEndpoints.outOfStockProducts;

  // Search & Filter
  String get searchProducts => ProductEndpoints.searchProducts;
  String get filterByCategory => ProductEndpoints.filterByCategory;
  String get filterByPrice => ProductEndpoints.filterByPrice;
}
