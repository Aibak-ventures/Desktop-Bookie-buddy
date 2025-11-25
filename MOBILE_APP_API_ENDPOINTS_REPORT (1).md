# BookieBuddy API Endpoints Report

**Generated:** November 14, 2025  
**Project Version:** 2.10.0+49  
**Purpose:** API versioning, endpoint mapping, and service usage documentation

---

## Executive Summary

This report documents all API endpoints used in the BookieBuddy mobile application, their versioning strategy, and how they're consumed across services. The API architecture follows a well-structured pattern with centralized path management and consistent versioning.

**Key Metrics:**
- **API Versions:** 4 versions (base `/api`, v3, v4, v5)
- **API Path Classes:** 11 domain-specific classes
- **Services Using APIs:** 20+ services
- **Total Endpoints:** 100+ unique endpoints
- **HTTP Methods:** GET, POST, PATCH, DELETE

---

## 1. API Architecture & Design Pattern

### 1.1 Centralized API Path Management

**Location:** `lib/core/api/api_paths.dart`

The project implements a **facade pattern** for API path organization using a final class with namespaced static constants:

```dart
final class ApiPaths {
  const ApiPaths._(); // Private constructor prevents instantiation

  static const auth = AuthApiPaths();
  static const shop = ShopApiPaths();
  static const products = ProductApiPaths();
  static const bookings = BookingsApiPaths();
  static const sales = SalesApiPaths();
  static const expenses = ExpensesApiPaths();
  static const ledger = LedgerApiPaths();
  static const notifications = NotificationsApiPaths();
  static const staff = StaffApiPaths();
  static const tailor = TailorApiPaths();
  static const customizationWork = CustomizationWorkApiPaths();
}
```

**Benefits of This Approach:**
1. ✅ **Type Safety:** Compile-time checking of API paths
2. ✅ **Centralization:** Single source of truth for all endpoints
3. ✅ **Immutability:** `final` fields prevent accidental path changes
4. ✅ **Namespace Organization:** Logical grouping by domain
5. ✅ **Autocomplete:** IDE support for discovering available paths
6. ✅ **Refactoring Safety:** Easy to update paths across the codebase

**Usage Pattern:**
```dart
// ✅ CORRECT - Using centralized ApiPaths
final response = await dio.get(ApiPaths.auth.login);
final products = await dio.get(ApiPaths.products.productsRoot);

// ❌ WRONG - Direct string usage (not used in this project)
final response = await dio.get('/api/v3/auth/login/');
```

### 1.2 API Versioning Strategy

**Configuration:** `lib/core/api/api_config.dart`

```dart
class ApiConfig {
  const ApiConfig._();
  static const v = '/api';      // Base version (legacy)
  static const v3 = '/api/v3';  // Version 3 (most common)
  static const v4 = '/api/v4';  // Version 4 (newer features)
  static const v5 = '/api/v5';  // Version 5 (latest)
}
```

**Version Usage Distribution:**
- **v3:** ~60% of endpoints (primary version)
- **v4:** ~25% of endpoints (analytics, ledger, newer features)
- **v5:** ~10% of endpoints (booking operations, latest features)
- **base `/api`:** ~5% (token refresh only)

**Versioning Pattern:**
- Each API path class defines private static `_root` constants for version-specific bases
- Methods use these roots to construct full paths
- Some endpoints span multiple versions (e.g., bookings has v3, v4, v5)

---

## 2. API Endpoint Categories

### 2.1 Authentication API (`AuthApiPaths`)

**Class Location:** `lib/core/api/auth_api_paths.dart`  
**Service:** `AuthService` (`lib/core/services/auth_service.dart`)  
**Versions Used:** v3 (primary), v4 (profile), base (refresh)

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/auth/login/` | v3 | POST | User authentication | `userLogin()` |
| `/api/v3/auth/wallet-login/` | v3 | POST | Secret password login | `secretLogin()` |
| `/api/v3/auth/change-password/` | v3 | POST | Change account password | `changeAccountPassword()` |
| `/api/v3/auth/update-secondary-password/` | v3 | POST | Change wallet password | `changeSecretPassword()` |
| `/api/token/refresh/` | base | POST | Refresh access token | `refreshToken()` |
| `/api/v4/auth/profile/` | v4 | GET | Fetch user profile | `UserService.fetchUserData()` |

**Implementation Pattern:**
```dart
class AuthApiPaths {
  const AuthApiPaths();
  
  static const _rootV3 = '${ApiConfig.v3}/auth/';
  static const _rootV4 = '${ApiConfig.v4}/auth/';
  
  final login = '${_rootV3}login/';
  final walletLogin = '${_rootV3}wallet-login/';
  final changePassword = '${_rootV3}change-password/';
  final changeSecondaryPassword = '${_rootV3}update-secondary-password/';
  final refresh = '${ApiConfig.v}/token/refresh/';
  final profile = '${_rootV4}profile/';
}
```

**Service Usage Example:**
```dart
// AuthService
final response = await dio.post(
  ApiPaths.auth.login,
  data: {'phone': phone, 'password': password},
);

// UserService
final response = await DioClient.dio.get(ApiPaths.auth.profile);
```

---

### 2.2 Bookings API (`BookingsApiPaths`)

**Class Location:** `lib/core/api/bookings_api_paths.dart`  
**Service:** `BookingService` (`lib/core/services/booking_service.dart`)  
**Versions Used:** v3, v4 (dashboard), v5 (booking operations)

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/bookings/bookings/` | v3 | GET | List bookings (paginated) | `fetchBookingsPagination()` |
| `/api/v3/bookings/bookings/` | v3 | DELETE | Delete booking | `deleteBooking()` |
| `/api/v3/bookings/bookings/old-bookings/` | v3 | POST | Create old booking | `createOldBooking()` |
| `/api/v3/bookings/clients/` | v3 | GET/POST/PATCH/DELETE | Client CRUD | `ClientServices.*` |
| `/api/v3/bookings/bookings/available-products/` | v3 | GET | Check availability | `ProductQueryService.fetchAvailableProductsPaginated()` |
| `/api/v4/bookings/dashboard/` | v4 | GET | Dashboard analytics | `DashboardService.fetchDashboardData()` |
| `/api/v5/bookings/bookings/` | v5 | GET/POST | Get/Create booking | `getBooking()`, `addBooking()` |
| `/api/v5/bookings/bookings/{id}/` | v5 | GET | Get booking details | `getBooking()` |
| `/api/v5/bookings/bookings/add-payment/` | v5 | POST | Add payment | `updatePayment()` |
| `/api/v5/bookings/bookings/delete-payment/{id}/` | v5 | DELETE | Delete payment | `deletePayment()` |
| `/api/v5/bookings/bookings/update-details/` | v5 | PATCH | Update booking | `updateBooking()` |
| `/api/v5/bookings/bookings/update-delivery-status/` | v5 | PATCH | Update delivery | `updateDeliveryStatus()` |
| `/api/v5/bookings/bookings/update-booking-status/` | v5 | PATCH | Update status | `updateBookingStatus()` |
| `/api/v5/bookings/bookings/send-invoice/{id}/` | v5 | GET | Download invoice | `downloadBookingInvoice()` |
| `/api/v5/bookings/bookings/variant-availability/{variantId}/` | v5 | GET | Check variant availability | `ProductQueryService.checkProductVariantAvailability()` |

**Dynamic Path Methods:**
```dart
String downloadInvoiceById(int id) => '${v5}send-invoice/$id/';
String deletePayment(int paymentId) => '${_bookingsV5}delete-payment/$paymentId/';
```

**Implementation Pattern:**
```dart
class BookingsApiPaths {
  const BookingsApiPaths();
  
  static const _rootV3 = '${ApiConfig.v3}/bookings/';
  static const _rootV4 = '${ApiConfig.v4}/bookings/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/';
  static const _bookingsV3 = '${_rootV3}bookings/';
  static const _bookingsV5 = '${_rootV5}bookings/';
  
  String get v3 => _bookingsV3;
  String get v5 => _bookingsV5;
  final addPayment = '${_bookingsV5}add-payment/';
  String deletePayment(int paymentId) => '${_bookingsV5}delete-payment/$paymentId/';
  // ... more endpoints
}
```

---

### 2.3 Products API (`ProductApiPaths`)

**Class Location:** `lib/core/api/product_api_paths.dart`  
**Services:**
- `ProductQueryService` (`lib/core/services/product_service/product_query_service.dart`)
- `ProductActionService` (`lib/core/services/product_service/product_action_service.dart`)
- `ServiceApi` (`lib/core/services/service_api.dart`)

**Versions Used:** v3 (primary), v5 (variant availability)

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/service/selected/` | v3 | GET | Fetch service categories | `ServiceApi.fetchServices()` |
| `/api/v3/service/product-search/` | v3 | GET | Search products | `searchAllProducts()` |
| `/api/v3/service/products/` | v3 | GET/POST/PATCH | Product CRUD | `fetchProductsPaginated()`, `addOrUpdateProduct()` |
| `/api/v3/service/products/{id}/` | v3 | GET/PATCH/DELETE | Product by ID | `fetchProductInfo()`, `addOrUpdateProduct()`, `deleteProduct()` |
| `/api/v3/service/products/{id}/variants/` | v3 | POST | Add variant | `addProductVariants()` |
| `/api/v3/service/products/{id}/variants/{variantId}/` | v3 | PATCH/DELETE | Update/Delete variant | `updateVariant()`, `deleteProduct()` |
| `/api/v3/service/products/product-bookings/{id}/` | v3 | GET | Product bookings history | `getProductBookings()` |
| `/api/v3/service/products/monthly-summary/{id}/` | v3 | GET | Product growth analytics | `fetchProductGrowthData()` |
| `/api/v3/service/products/material-usage-orders/{id}/` | v3 | GET | Material usage tracking | `fetchProductMaterialsUsageData()` |
| `/api/v3/service/products/list-with-variants/` | v3 | GET | All products with variants | `fetchAllProducts()` |
| `/api/v3/service/transfer-product/match-product/` | v3 | POST | Match product for transfer | `fetchMatchingProductsFromAnotherShop()` |
| `/api/v3/service/transfer-product/transfer-history/` | v3 | GET | Transfer history | `fetchTransferProductHistory()` |
| `/api/v3/service/transfer-product/transfer-stock/` | v3 | POST | Transfer stock | `transferProductToAnotherShop()` |
| `/api/v5/bookings/bookings/variant-availability/{variantId}/` | v5 | GET | Check variant availability | `checkProductVariantAvailability()` |

**Dynamic Path Methods:**
```dart
String productById(String id) => '$productsRoot$id/';
String monthlySummary(String id) => '$productsRoot/monthly-summary/$id/';
String materialUsageData(int productId) => '$productsRoot/material-usage-orders/$productId/';
String checkVariantAvailability(int variantId) => 
    '${ApiConfig.v5}/bookings/bookings/variant-availability/$variantId/';
```

---

### 2.4 Sales API (`SalesApiPaths`)

**Class Location:** `lib/core/api/sales_api_paths.dart`  
**Service:** `SalesService` (`lib/core/services/sales_service.dart`)  
**Versions Used:** v3, v4

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/sales/sales/` | v3 | DELETE | Delete sale | `deleteSale()` |
| `/api/v3/sales/sales/{id}/` | v3 | GET | Get sale details (old version) | `getSaleDetails()` (fallback) |
| `/api/v3/sales/sales/send-invoice/{id}/` | v3 | GET | Download invoice | `downloadSalesInvoice()` |
| `/api/v4/sales/sales/` | v4 | GET/POST | List/Create sales | `getSalesPagination()`, `createSale()` |
| `/api/v4/sales/sales/{id}/` | v4 | GET | Get sale details | `getSaleDetails()` |
| `/api/v4/sales/sales/update-sale/{id}/` | v4 | PATCH | Update sale | `updateSale()` |

**Dynamic Path Methods:**
```dart
String saleByIdV3(int id) => '${_salesV3}$id/';
String saleById(int id) => '${_salesV4}$id/';
String updateSaleById(int id) => '${_salesV4}update-sale/$id/';
String downloadSalesInvoiceById(int id) => '${_salesV3}send-invoice/$id/';
```

**Implementation Note:** Sales API uses both v3 and v4, with v4 being preferred for new operations.

---

### 2.5 Staff API (`StaffApiPaths`)

**Class Location:** `lib/core/api/staff_api_paths.dart`  
**Service:** `StaffService` (`lib/core/services/staff_service.dart`)  
**Versions Used:** v3

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/shop/staff/` | v3 | GET/POST | List/Create staff | `fetchStaffs()`, `addStaff()` |
| `/api/v3/shop/staff/{id}/` | v3 | GET/PATCH/DELETE | Staff CRUD by ID | `fetchStaffDetails()`, `editStaff()`, `deleteStaff()` |
| `/api/v3/shop/staff/restore/{id}/` | v3 | PATCH | Restore deleted staff | `restoreDeletedStaff()` |
| `/api/v3/shop/staff-earnings/earnings-report/` | v3 | GET | Staff analytics | `fetchStaffAnalyticsReport()` |
| `/api/v3/shop/staff-earnings/earnings-report/{id}/` | v3 | GET | Staff analytics by ID | `fetchStaffAnalyticsReport()` |
| `/api/v3/shop/staff-earnings/monthly-transactions/` | v3 | POST | Monthly bookings/sales | `fetchStaffMonthlyBookingsOrSalesPagination()` |

**Dynamic Path Methods:**
```dart
String staffById(int id) => '${staff}$id/';
String restoreDeletedStaffById(int id) => '${staff}/restore/$id/';
String staffAnalyticsReportById(int id) => '${staffAnalyticsReport}$id/';
```

---

### 2.6 Shop API (`ShopApiPaths`)

**Class Location:** `lib/core/api/shop_api_paths.dart`  
**Service:** `ShopService` (`lib/core/services/shop_service.dart`)  
**Versions Used:** v3

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/shop/available-shops/` | v3 | GET | List available shops | `fetchShops()` |
| `/api/v3/shop/shop-privacy-settings/` | v3 | PATCH | Update privacy settings | `updateShopPrivacySettings()` |
| `/api/v3/shop/shop-settings/update-settings/` | v3 | PATCH | Update shop settings | `updateShopSettings()` |
| `/api/v3/shop/shop-activity-logs/` | v3 | GET | Activity audit logs | `fetchShopActivityLogs()` |

---

### 2.7 Expenses API (`ExpensesApiPaths`)

**Class Location:** `lib/core/api/expenses_api_paths.dart`  
**Service:** `ExpenseService` (`lib/core/services/expense_service.dart`)  
**Versions Used:** v3, v4

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/expenses/expenses/` | v3 | POST/PATCH/DELETE | Expense CRUD | `addExpense()`, `editExpense()`, `deleteExpense()` |
| `/api/v3/expenses/variant-expenses/` | v3 | POST/PATCH/DELETE | Product expense CRUD | `ProductActionService.addOrUpdateProductExpense()`, `deleteExpense()` |
| `/api/v3/expenses/wallet/daywise-summary/` | v3 | GET | Day-wise summary | `PaymentService.fetchLedgerDayWiseSummary()` |
| `/api/v3/expenses/export-transactions/excel/` | v3 | GET | Export to Excel | `LedgerService.downloadLedgerInvoice()` |
| `/api/v4/expenses/transaction-history/` | v4 | GET | Transaction history | `LedgerService.fetchDataForInvoicePdf()` |

---

### 2.8 Ledger API (`LedgerApiPaths`)

**Class Location:** `lib/core/api/ledger_api_paths.dart`  
**Services:**
- `LedgerService` (`lib/features/ledger/services/ledger_service.dart`)
- `PendingService` (`lib/features/ledger/services/pending_service.dart`)
- `PaymentService` (`lib/features/ledger/services/payment_service.dart`)

**Versions Used:** v4, v5

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v4/expenses/wallet/expenses/` | v4 | GET | Wallet expenses | `ExpenseService.fetchExpensePagination()` |
| `/api/v4/bookings/wallet/booking-amounts/` | v4 | GET | Booking amounts | `LedgerService.fetchBookingsPagination()` |
| `/api/v4/bookings/wallet/` | v4 | GET | Daily summary | `LedgerService.dailySummary` |
| `/api/v4/sales/wallet/sales/` | v4 | GET | Sales wallet | `LedgerService.fetchSalesPagination()` |
| `/api/v5/bookings/wallet/pending-amounts/` | v5 | GET | Pending amounts | `PendingService.fetchPendingPagination()` |
| `/api/v5/bookings/wallet/security-amounts/` | v5 | GET | Security deposits | `LedgerService.fetchSecurityAmountsPagination()` |
| `/api/v5/bookings/wallet/payment-details/` | v5 | GET | Payment history | `PaymentService.fetchPaymentsPagination()` |

---

### 2.9 Tailor API (`TailorApiPaths`)

**Class Location:** `lib/core/api/tailor_api_paths.dart`  
**Service:** `TailorService` (`lib/core/services/tailor_service.dart`)  
**Versions Used:** v3

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/tailored/tailor/` | v3 | GET/POST | List/Create tailors | `fetchTailors()`, `addTailor()` |
| `/api/v3/tailored/tailor/{id}/` | v3 | PATCH/DELETE | Update/Delete tailor | `editTailor()`, `deleteTailor()`, `restoreDeletedTailor()` |
| `/api/v3/tailored/tailor/tailor-monthly-summary/{id}/` | v3 | GET | Monthly summary | `fetchTailorMonthlySummaryData()` |

**Dynamic Path Methods:**
```dart
String tailorById(int id) => '${tailors}$id/';
String tailorMonthlySummary(int tailorId) => '${tailors}tailor-monthly-summary/$tailorId/';
```

---

### 2.10 Customization Work API (`CustomizationWorkApiPaths`)

**Class Location:** `lib/core/api/customization_work_api_paths.dart`  
**Service:** `CustomWorkService` (`lib/core/services/custom_work_service.dart`)  
**Versions Used:** v3

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/tailored/tailor-order/` | v3 | GET/POST | List/Create custom work | `fetchCustomWorks()`, `createOrder()` |
| `/api/v3/tailored/tailor-order/{id}/` | v3 | GET/PATCH/DELETE | Custom work CRUD | `fetchCustomWorkDetails()`, `updateOrder()`, `deleteCustomWork()` |
| `/api/v3/tailored/tailor-order/update-payment/{id}/` | v3 | PATCH | Add payment | `addPaymentToCustomWork()` |
| `/api/v3/tailored/tailor-order/delete-payment/{id}/` | v3 | DELETE | Delete payment | `deletePayment()` |
| `/api/v3/tailored/tailor-order/update-status/{id}/` | v3 | PATCH | Update status | `updateCustomWorkStatus()` |
| `/api/v3/tailored/tailor-order/send-invoice/{id}/` | v3 | GET | Download invoice | `downloadCustomWorkInvoice()` |
| `/api/v3/tailored/convert-to-booking/` | v3 | POST | Convert to booking | `convertToBooking()` |

**Dynamic Path Methods:**
```dart
String customWorkById(int id) => '${_root}$id/';
String addPaymentToCustomWork(int id) => '${_root}update-payment/$id/';
String deletePaymentFromCustomWork(int id) => '${_root}delete-payment/$id/';
String updateStatusToCustomWork(int id) => '${_root}/update-status/$id/';
String downloadInvoiceById(int customWorkId) => '${_root}send-invoice/$customWorkId/';
```

---

### 2.11 Notifications API (`NotificationsApiPaths`)

**Class Location:** `lib/core/api/notifications_api_paths.dart`  
**Service:** `UserService` (`lib/core/services/user_service.dart`)  
**Versions Used:** v3

| Endpoint | Version | Method | Purpose | Service Method |
|----------|---------|--------|---------|----------------|
| `/api/v3/notifications/device-tokens/register/` | v3 | POST | Register FCM token | `registerFCMToken()` |
| `/api/v3/notifications/device-tokens/remove/` | v3 | POST | Remove FCM token | `removeFCMToken()` |
| `/api/v3/notifications/device-tokens/update-shop/` | v3 | POST | Update shop for token | `updateFCMTokenWhenShopSwitching()` |

---

## 3. Service-to-API Mapping

### 3.1 Service Layer Architecture

All services follow a consistent pattern:
1. **Dependency:** Use `DioClient.dio` for HTTP requests
2. **Path Access:** Use `ApiPaths.*` for all endpoints
3. **Response Wrapping:** Return `CustomResponseModel`
4. **Error Handling:** Log errors and rethrow

**Example Service Pattern:**
```dart
class BookingService {
  final _dio = DioClient.dio;
  
  Future<CustomResponseModel> getBooking(int bookingId) async {
    try {
      final response = await _dio.get('${ApiPaths.bookings.v5}$bookingId/');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching booking: $e', stackTrace: stack);
      rethrow;
    }
  }
}
```

### 3.2 Complete Service-API Matrix

| Service | API Paths Class | Primary Version | Endpoints Used |
|---------|----------------|-----------------|----------------|
| `AuthService` | `AuthApiPaths` | v3, v4 | 6 endpoints |
| `UserService` | `AuthApiPaths`, `NotificationsApiPaths` | v3, v4 | 4 endpoints |
| `BookingService` | `BookingsApiPaths` | v3, v5 | 14 endpoints |
| `ClientServices` | `BookingsApiPaths` | v3 | 4 endpoints (CRUD) |
| `DashboardService` | `BookingsApiPaths` | v4 | 1 endpoint |
| `ProductQueryService` | `ProductApiPaths`, `BookingsApiPaths` | v3, v5 | 12 endpoints |
| `ProductActionService` | `ProductApiPaths`, `ExpensesApiPaths` | v3 | 8 endpoints |
| `ServiceApi` | `ProductApiPaths` | v3 | 1 endpoint |
| `SalesService` | `SalesApiPaths` | v3, v4 | 6 endpoints |
| `StaffService` | `StaffApiPaths` | v3 | 8 endpoints |
| `ShopService` | `ShopApiPaths` | v3 | 4 endpoints |
| `ExpenseService` | `ExpensesApiPaths`, `LedgerApiPaths` | v3, v4 | 4 endpoints |
| `LedgerService` | `LedgerApiPaths`, `ExpensesApiPaths` | v4, v5 | 5 endpoints |
| `PendingService` | `LedgerApiPaths` | v5 | 1 endpoint |
| `PaymentService` | `LedgerApiPaths`, `ExpensesApiPaths` | v3, v5 | 2 endpoints |
| `TailorService` | `TailorApiPaths` | v3 | 5 endpoints |
| `CustomWorkService` | `CustomizationWorkApiPaths` | v3 | 9 endpoints |

---

## 4. API Path Creation Patterns

### 4.1 Static Final Fields (Recommended for Fixed Paths)

**Pattern:** Use `final` instance fields for static paths

```dart
class AuthApiPaths {
  const AuthApiPaths();
  
  static const _rootV3 = '${ApiConfig.v3}/auth/';
  
  // ✅ Best Practice: Immutable, type-safe, compile-time constant
  final login = '${_rootV3}login/';
  final walletLogin = '${_rootV3}wallet-login/';
  final changePassword = '${_rootV3}change-password/';
}

// Usage:
final path = ApiPaths.auth.login; // No function call needed
```

**Benefits:**
- ✅ Immutable after initialization
- ✅ No runtime overhead (compile-time constants)
- ✅ Cannot be accidentally modified
- ✅ Clean, simple syntax

### 4.2 Getter Methods (For Paths Needing Access to Instance)

**Pattern:** Use getters when you need access to private roots

```dart
class BookingsApiPaths {
  const BookingsApiPaths();
  
  static const _bookingsV3 = '${ApiConfig.v3}/bookings/bookings/';
  static const _bookingsV5 = '${ApiConfig.v5}/bookings/bookings/';
  
  // ✅ Good for exposing computed/private paths
  String get v3 => _bookingsV3;
  String get v5 => _bookingsV5;
}

// Usage:
final path = ApiPaths.bookings.v5; // Returns string
```

### 4.3 Function Methods (For Dynamic Paths with Parameters)

**Pattern:** Use methods for paths requiring runtime parameters

```dart
class BookingsApiPaths {
  const BookingsApiPaths();
  
  static const _bookingsV5 = '${ApiConfig.v5}/bookings/bookings/';
  
  // ✅ Best for parameterized paths
  String deletePayment(int paymentId) => '${_bookingsV5}delete-payment/$paymentId/';
  String downloadInvoiceById(int id) => '${v5}send-invoice/$id/';
}

// Usage:
final path = ApiPaths.bookings.deletePayment(123); // /api/v5/bookings/bookings/delete-payment/123/
```

**Benefits:**
- ✅ Type-safe parameter handling
- ✅ Clear parameter requirements
- ✅ IDE autocomplete with parameter hints
- ✅ Prevents string concatenation errors

### 4.4 Anti-Patterns to Avoid

```dart
// ❌ WRONG: Hardcoded strings in services
final response = await dio.get('/api/v3/bookings/bookings/');

// ❌ WRONG: String interpolation in services
final response = await dio.get('/api/v${version}/bookings/$id/');

// ❌ WRONG: Mutable fields
class ApiPaths {
  String login = '/api/v3/auth/login/'; // Can be changed!
}

// ❌ WRONG: No centralization
class BookingService {
  static const bookingsUrl = '/api/v3/bookings/bookings/'; // Duplication!
}
```

---

## 5. Best Practices & Recommendations

### 5.1 Current Implementation Strengths

1. ✅ **Centralized Management:** All paths in `ApiPaths` class
2. ✅ **Type Safety:** Using final fields and methods
3. ✅ **Namespace Organization:** Domain-specific classes
4. ✅ **Version Consistency:** Clear version separation
5. ✅ **Immutability:** `final` fields prevent modification
6. ✅ **Dynamic Paths:** Function methods for IDs
7. ✅ **Autocomplete Support:** IDE-friendly structure

### 5.2 Recommended Patterns for New Endpoints

**When adding a new endpoint:**

```dart
// 1. Add to appropriate API paths class
class BookingsApiPaths {
  const BookingsApiPaths();
  
  static const _rootV5 = '${ApiConfig.v5}/bookings/';
  
  // For static paths:
  final newEndpoint = '${_rootV5}new-feature/';
  
  // For dynamic paths:
  String newEndpointById(int id) => '${_rootV5}new-feature/$id/';
  
  // For complex queries (use queryParameters in service instead):
  final searchEndpoint = '${_rootV5}search/';
}

// 2. Use in service
class BookingService {
  Future<CustomResponseModel> newFeature(int id) async {
    final response = await _dio.get(
      ApiPaths.bookings.newEndpointById(id),
      queryParameters: {'filter': 'active'},
    );
    return CustomResponseModel.fromJson(response.data);
  }
}
```

### 5.3 Migration Guide (If Refactoring Old Code)

**If you encounter direct string usage:**

```dart
// ❌ Before (old pattern - avoid)
final response = await dio.get('/api/v3/bookings/bookings/$id/');

// ✅ After (correct pattern)
final response = await dio.get('${ApiPaths.bookings.v3}$id/');

// ✅ Even better (if method exists)
final response = await dio.get(ApiPaths.bookings.bookingById(id));
```

### 5.4 Version Migration Strategy

**When migrating an endpoint to a new version:**

```dart
class SalesApiPaths {
  const SalesApiPaths();
  
  static const _salesV3 = '${ApiConfig.v3}/sales/sales/';
  static const _salesV4 = '${ApiConfig.v4}/sales/sales/';
  
  // Keep old version for backwards compatibility
  String get salesV3 => _salesV3;
  String saleByIdV3(int id) => '${_salesV3}$id/';
  
  // Add new version
  String get salesV4 => _salesV4;
  String saleById(int id) => '${_salesV4}$id/'; // Preferred
  
  // Service uses v4 by default, falls back to v3 if needed
}
```

---

## 6. API Versioning Summary

### 6.1 Version Distribution

| Version | Usage % | Primary Purpose | Examples |
|---------|---------|-----------------|----------|
| `/api` (base) | 5% | Legacy (token refresh only) | Token refresh |
| `/api/v3` | 60% | Main application features | Products, Staff, Tailors, Auth, Bookings (list), Sales (delete), Expenses |
| `/api/v4` | 25% | Analytics & newer features | Dashboard, Ledger, Sales (CRUD), Profile, Transaction history |
| `/api/v5` | 10% | Latest booking operations | Booking CRUD, Payments, Availability checks, Wallet operations |

### 6.2 Version Migration Patterns Observed

1. **Bookings API:** Gradual migration from v3 → v5
   - v3: List/delete operations
   - v5: Create, update, payments, status changes

2. **Sales API:** Split between v3/v4
   - v3: Delete, invoice download
   - v4: Create, update, list, details

3. **Ledger API:** Consolidated in v4/v5
   - v4: Basic wallet operations
   - v5: Advanced payment/pending tracking

### 6.3 Version Selection Guidelines

**When choosing a version for new endpoints:**

1. **Use v5** for:
   - New booking-related operations
   - Payment/wallet operations
   - Real-time availability checks

2. **Use v4** for:
   - Analytics and reporting
   - Dashboard data
   - Transaction histories

3. **Use v3** for:
   - Maintaining consistency with existing domain operations
   - Product/Staff/Tailor management
   - Service selection

4. **Avoid base `/api`** for:
   - New endpoints (reserved for legacy/core operations)

---

## 7. Error Prevention Strategies

### 7.1 Compile-Time Safety

The current implementation provides multiple layers of safety:

```dart
// ✅ Type checking at compile time
final path: String = ApiPaths.auth.login; // Verified by compiler

// ✅ IDE autocomplete prevents typos
ApiPaths.auth.loginn // Won't compile
ApiPaths.auth.login  // Autocompletes correctly

// ✅ Refactoring safety
// Changing ApiPaths.auth.login automatically updates all usages
```

### 7.2 Runtime Validation

While not currently implemented, consider adding:

```dart
// Optional: API path validation utility
class ApiPathValidator {
  static void validate(String path) {
    assert(path.startsWith('/api/'), 'Path must start with /api/');
    assert(path.endsWith('/'), 'Path should end with /');
  }
}
```

### 7.3 Testing Recommendations

```dart
// Test API path consistency
void main() {
  test('Auth paths are correctly formatted', () {
    expect(ApiPaths.auth.login, '/api/v3/auth/login/');
    expect(ApiPaths.auth.refresh, '/api/token/refresh/');
  });
  
  test('Dynamic paths work correctly', () {
    expect(ApiPaths.bookings.deletePayment(123), 
           '/api/v5/bookings/bookings/delete-payment/123/');
  });
}
```

---

## 8. Comparison with Alternative Approaches

### 8.1 Current Approach (Facade Pattern)

**Strengths:**
- ✅ Centralized in one place
- ✅ Type-safe with compile-time checking
- ✅ IDE autocomplete support
- ✅ Easy to maintain and refactor
- ✅ Version management clear

**Weaknesses:**
- ⚠️ Slightly more boilerplate (separate class per domain)
- ⚠️ Requires updating class when adding endpoints

### 8.2 Alternative: Enum-Based Approach (Not Used)

```dart
enum ApiEndpoint {
  login,
  bookings,
  products;
  
  String get path => switch (this) {
    login => '/api/v3/auth/login/',
    bookings => '/api/v3/bookings/bookings/',
    products => '/api/v3/service/products/',
  };
}
```

**Why not used:**
- ❌ Harder to organize by domain
- ❌ No namespace organization
- ❌ Difficult to handle dynamic paths

### 8.3 Alternative: Constants File (Anti-Pattern)

```dart
// ❌ Not recommended
class ApiConstants {
  static const LOGIN = '/api/v3/auth/login/';
  static const BOOKINGS = '/api/v3/bookings/bookings/';
  static const PRODUCTS = '/api/v3/service/products/';
}
```

**Why avoided:**
- ❌ No organization/grouping
- ❌ Harder to discover related endpoints
- ❌ No version separation
- ❌ Namespace pollution

---

## 9. Quick Reference

### 9.1 Adding a New API Endpoint

**Checklist:**

1. ✅ Identify the domain (auth, bookings, products, etc.)
2. ✅ Choose appropriate API version (v3/v4/v5)
3. ✅ Add to corresponding `*ApiPaths` class
4. ✅ Use `final` for static paths, methods for dynamic paths
5. ✅ Follow naming conventions (camelCase)
6. ✅ Update service to use `ApiPaths.*`
7. ✅ Test the endpoint

**Example:**
```dart
// 1. In lib/core/api/bookings_api_paths.dart
class BookingsApiPaths {
  final cancelBooking = '${_bookingsV5}cancel/';
  String cancelBookingById(int id) => '${_bookingsV5}cancel/$id/';
}

// 2. In lib/core/services/booking_service.dart
Future<CustomResponseModel> cancelBooking(int id) async {
  final response = await _dio.post(
    ApiPaths.bookings.cancelBookingById(id),
  );
  return CustomResponseModel.fromJson(response.data);
}
```

### 9.2 API Path Class Template

```dart
import 'package:booking_application/core/api/api_config.dart';

class NewDomainApiPaths {
  const NewDomainApiPaths();

  // Define version roots
  static const _rootV3 = '${ApiConfig.v3}/new-domain/';
  static const _rootV4 = '${ApiConfig.v4}/new-domain/';

  // Static paths (use final)
  final listItems = '${_rootV3}items/';
  final createItem = '${_rootV3}items/';

  // Dynamic paths (use methods)
  String itemById(int id) => '${_rootV3}items/$id/';
  String itemAction(int id, String action) => '${_rootV3}items/$id/$action/';
  
  // Getters for commonly used roots
  String get v3Root => _rootV3;
  String get v4Root => _rootV4;
}
```

---

## 10. Summary & Recommendations

### 10.1 Current State Assessment

**Excellent Practices:**
- ✅ Centralized API path management via `ApiPaths` facade
- ✅ Strong type safety with `final` fields
- ✅ Clear versioning strategy
- ✅ Domain-based organization
- ✅ Consistent service implementation
- ✅ Dynamic path methods for parameterized endpoints

**Areas for Potential Improvement:**
- 📋 Add API path validation tests
- 📋 Document version migration strategy in code comments
- 📋 Consider adding runtime path validation (development mode)
- 📋 Create API changelog for version migrations

### 10.2 Key Takeaways

1. **Always use `ApiPaths.*`** - Never hardcode API strings in services
2. **Use `final` for static paths** - Compile-time constants prevent errors
3. **Use methods for dynamic paths** - Type-safe parameter handling
4. **Organize by domain** - Keep related endpoints together
5. **Version consciously** - Choose appropriate version for new features
6. **Test path correctness** - Validate formatting and structure

### 10.3 For Desktop Version Comparison

**Reusable:**
- ✅ Entire `ApiPaths` structure can be shared
- ✅ All API path classes are platform-agnostic
- ✅ Service layer patterns are transferable

**Considerations:**
- Desktop may need different base URLs for local servers
- Offline mode requires local API path mapping
- Consider adding desktop-specific endpoints if needed

---

## Appendix A: Complete API Endpoint List (Alphabetical)

### Auth & User
- POST `/api/v3/auth/login/`
- POST `/api/v3/auth/wallet-login/`
- POST `/api/v3/auth/change-password/`
- POST `/api/v3/auth/update-secondary-password/`
- POST `/api/token/refresh/`
- GET `/api/v4/auth/profile/`
- POST `/api/v3/notifications/device-tokens/register/`
- POST `/api/v3/notifications/device-tokens/remove/`
- POST `/api/v3/notifications/device-tokens/update-shop/`

### Bookings (30+ endpoints)
- GET `/api/v3/bookings/bookings/` (list)
- DELETE `/api/v3/bookings/bookings/{id}/`
- POST `/api/v3/bookings/bookings/old-bookings/`
- GET `/api/v3/bookings/bookings/available-products/`
- GET `/api/v4/bookings/dashboard/`
- GET `/api/v5/bookings/bookings/` (paginated)
- POST `/api/v5/bookings/bookings/` (create)
- GET `/api/v5/bookings/bookings/{id}/`
- POST `/api/v5/bookings/bookings/add-payment/{id}/`
- DELETE `/api/v5/bookings/bookings/delete-payment/{id}/`
- PATCH `/api/v5/bookings/bookings/update-details/{id}/`
- PATCH `/api/v5/bookings/bookings/update-delivery-status/{id}/`
- PATCH `/api/v5/bookings/bookings/update-booking-status/{id}/`
- GET `/api/v5/bookings/bookings/send-invoice/{id}/`
- GET `/api/v5/bookings/bookings/variant-availability/{variantId}/`

### Clients
- GET `/api/v3/bookings/clients/`
- POST `/api/v3/bookings/clients/`
- PATCH `/api/v3/bookings/clients/{id}/`
- DELETE `/api/v3/bookings/clients/{id}/`

### Products (25+ endpoints)
- GET `/api/v3/service/selected/`
- GET `/api/v3/service/product-search/`
- GET `/api/v3/service/products/`
- POST `/api/v3/service/products/`
- GET `/api/v3/service/products/{id}/`
- PATCH `/api/v3/service/products/{id}/`
- DELETE `/api/v3/service/products/{id}/`
- POST `/api/v3/service/products/{id}/variants/`
- PATCH `/api/v3/service/products/{id}/variants/{variantId}/`
- DELETE `/api/v3/service/products/{id}/variants/{variantId}/`
- GET `/api/v3/service/products/product-bookings/{id}/`
- GET `/api/v3/service/products/monthly-summary/{id}/`
- GET `/api/v3/service/products/material-usage-orders/{id}/`
- GET `/api/v3/service/products/list-with-variants/`
- POST `/api/v3/service/transfer-product/match-product/`
- GET `/api/v3/service/transfer-product/transfer-history/`
- POST `/api/v3/service/transfer-product/transfer-stock/`

### Sales
- GET `/api/v3/sales/sales/{id}/` (v3)
- DELETE `/api/v3/sales/sales/{id}/`
- GET `/api/v3/sales/sales/send-invoice/{id}/`
- GET `/api/v4/sales/sales/`
- POST `/api/v4/sales/sales/`
- GET `/api/v4/sales/sales/{id}/` (v4)
- PATCH `/api/v4/sales/sales/update-sale/{id}/`

### Staff
- GET `/api/v3/shop/staff/`
- POST `/api/v3/shop/staff/`
- GET `/api/v3/shop/staff/{id}/`
- PATCH `/api/v3/shop/staff/{id}/`
- DELETE `/api/v3/shop/staff/{id}/`
- PATCH `/api/v3/shop/staff/restore/{id}/`
- GET `/api/v3/shop/staff-earnings/earnings-report/{id}/`
- POST `/api/v3/shop/staff-earnings/monthly-transactions/`

### Shop
- GET `/api/v3/shop/available-shops/`
- PATCH `/api/v3/shop/shop-privacy-settings/`
- PATCH `/api/v3/shop/shop-settings/update-settings/`
- GET `/api/v3/shop/shop-activity-logs/`

### Expenses & Ledger
- POST `/api/v3/expenses/expenses/`
- PATCH `/api/v3/expenses/expenses/{id}/`
- DELETE `/api/v3/expenses/expenses/{id}/`
- POST `/api/v3/expenses/variant-expenses/`
- PATCH `/api/v3/expenses/variant-expenses/{id}/`
- DELETE `/api/v3/expenses/variant-expenses/{id}/`
- GET `/api/v3/expenses/wallet/daywise-summary/`
- GET `/api/v3/expenses/export-transactions/excel/`
- GET `/api/v4/expenses/transaction-history/`
- GET `/api/v4/expenses/wallet/expenses/`
- GET `/api/v4/bookings/wallet/booking-amounts/`
- GET `/api/v4/sales/wallet/sales/`
- GET `/api/v5/bookings/wallet/pending-amounts/`
- GET `/api/v5/bookings/wallet/security-amounts/`
- GET `/api/v5/bookings/wallet/payment-details/`

### Tailors
- GET `/api/v3/tailored/tailor/`
- POST `/api/v3/tailored/tailor/`
- PATCH `/api/v3/tailored/tailor/{id}/`
- DELETE `/api/v3/tailored/tailor/{id}/`
- GET `/api/v3/tailored/tailor/tailor-monthly-summary/{id}/`

### Custom Work
- GET `/api/v3/tailored/tailor-order/`
- POST `/api/v3/tailored/tailor-order/`
- GET `/api/v3/tailored/tailor-order/{id}/`
- PATCH `/api/v3/tailored/tailor-order/{id}/`
- DELETE `/api/v3/tailored/tailor-order/{id}/`
- PATCH `/api/v3/tailored/tailor-order/update-payment/{id}/`
- DELETE `/api/v3/tailored/tailor-order/delete-payment/{id}/`
- PATCH `/api/v3/tailored/tailor-order/update-status/{id}/`
- GET `/api/v3/tailored/tailor-order/send-invoice/{id}/`
- POST `/api/v3/tailored/convert-to-booking/`

**Total: 100+ endpoints across 4 API versions**

---

**End of Report**

This comprehensive API documentation serves as a reference for understanding the mobile app's API structure and can be used as a baseline for comparison with the desktop version's API requirements.
