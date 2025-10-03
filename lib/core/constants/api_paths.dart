// /// Centralized API path constants. Grouped by domain.
// /// Only base path segments and static endpoints here; dynamic composition done in services.
// class ApiPaths {
//   const ApiPaths._();

//   // API Versions (keep minimal – upgrade safety)
//   static const String _v = '/api';
//   static const String _v3 = '/api/v3';
//   static const String _v4 = '/api/v4';

//   // ================= Auth =================
//   static const String _authRoot = '$_v3/auth/';
//   static const String authLogin = '${_authRoot}login/';
//   static const String authWalletLogin = '${_authRoot}wallet-login/';
//   static const String authChangePassword = '${_authRoot}change-password/';
//   static const String authChangeSecondaryPassword =
//       '${_authRoot}update-secondary-password/';
//   // Token refresh intentionally version-agnostic (DRF default)
//   static const String authRefresh = '$_v/token/refresh/';
//   static const String authProfile = '${_authRoot}profile/';

//   // ================= Shops =================
//   static const String _shopRoot = '$_v3/shop/';
//   static const String shopsAvailableRoot = '${_shopRoot}available-shops/';
//   static const String shopsPrivacySettings =
//       '${_shopRoot}shop-privacy-settings/';
//   static const String shopsSettings =
//       '${_shopRoot}shop-settings/update-settings/';

//   // ================= Services / Products =================
//   static const String _serviceRoot = '$_v3/service/';
//   static const String servicesSelected = '${_serviceRoot}selected/';
//   static const String productSearch = '${_serviceRoot}product-search/';
//   static const String productsRoot =
//       '${_serviceRoot}products/'; // append product id, variants after
//   static const String productMonthlySummary =
//       '${_serviceRoot}products/monthly-summary/'; // append productId

//   // Product Transfer
//   static const String _productTransferRoot = '${_serviceRoot}transfer-product/';
//   static const String productTransferMatch =
//       '${_productTransferRoot}match-product/';
//   static const String productTransferHistory =
//       '${_productTransferRoot}transfer-history/';
//   static const String productTransferStock =
//       '${_productTransferRoot}transfer-stock/';

//   // ================= Bookings / Clients =================
//   static const String _bookingsRoot = '$_v3/bookings/';
//   static const String _bookingsRootV4 = '$_v4/bookings/';
//   static const String bookingsRoot = '${_bookingsRoot}bookings/';
//   static const String bookingsRootV4 = '${_bookingsRootV4}bookings/';
//   static const String clientsRoot = '${_bookingsRoot}clients/';
//   static const String productsAvailable = '${bookingsRoot}available-products/';
//   static const String dashboard = '${_bookingsRoot}dashboard/';

//   // ================= Sales =================
//   static const String _salesRoot = '$_v3/sales/';
//   static const String salesRoot = '${_salesRoot}sales/';
//   static const String salesUpdate = '${salesRoot}update-sale/';
//   // static const String salesUpdateVariant = '${salesRoot}update-variants/';

//   // ================= Expenses / Ledger =================
//   static const String _expensesRoot = '$_v3/expenses/';
//   static const String expensesRoot = '${_expensesRoot}expenses/';
//   static const String variantExpensesRoot = '${_expensesRoot}variant-expenses/';
//   static const String transactionHistory =
//       '${_expensesRoot}transaction-history/';
//   static const String daywiseSummary =
//       '${_expensesRoot}wallet/daywise-summary/';
//   static const String exportTransactionsExcel =
//       '${_expensesRoot}export-transactions/excel/';

//   // ================= Ledger =================
//   static const String _ledgerRootV4 = '$_v4/bookings/wallet/';

//   static const String ledgerExpenses = '$_v4/expenses/wallet/expenses/';
//   static const String ledgerPending = '${_ledgerRootV4}pending-amounts/';
//   static const String ledgerSecurityAmounts =
//       '${_ledgerRootV4}security-amounts/';
//   static const String ledgerBooking = '${_ledgerRootV4}booking-amounts/';
//   static const String ledgerSales = '$_v3/sales/wallet/sales/';
//   static const String ledgerPaymentDetails = '${_ledgerRootV4}payment-details/';
//   static const String ledgerDailySummary =
//       _ledgerRootV4; // kept for backward naming compatibility

//   // ================= FCM Token Management =================
//   static const String _fcmTokenManagementRoot =
//       '$_v3/notifications/device-tokens/';
//   static const String registerFCMToken = '${_fcmTokenManagementRoot}register/';
//   static const String removeFCMToken = '${_fcmTokenManagementRoot}remove/';
//   static const String updateFCMTokenWhenShopSwitching =
//       '${_fcmTokenManagementRoot}update-shop/';
// }
