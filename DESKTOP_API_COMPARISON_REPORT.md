# Desktop vs Mobile API Endpoints Comparison Report

**Generated:** November 14, 2025  
**Desktop Version:** 0.1.0+01  
**Mobile Version:** 2.10.0+49  
**Purpose:** Identify API version mismatches and structural issues

---

## Executive Summary

This report compares the Desktop application's API implementation against the Mobile app's documented API endpoints to identify:
- **API version mismatches** (Desktop using older/wrong versions)
- **Missing API endpoints** (Desktop doesn't have endpoints Mobile uses)
- **Structural differences** (Different organization or paths)
- **Required migrations** (Which endpoints need version updates)

### Key Findings:

| Issue Type | Count | Severity |
|------------|-------|----------|
| **Critical Version Mismatches** | 5 | 🔴 HIGH |
| **Missing API Endpoint Classes** | 2 | 🔴 CRITICAL |
| **Incomplete Endpoints** | 8+ | ⚠️ MEDIUM |
| **Wrong Version Usage** | 3 | ⚠️ MEDIUM |
| **Missing Dynamic Methods** | 6+ | 📋 LOW |

---

## 1. API Structure Comparison

### 1.1 API Path Classes

| API Domain | Mobile Has | Desktop Has | Status |
|------------|------------|-------------|--------|
| **ApiConfig** | ✅ v, v3, v4, v5 | ✅ v, v3, v4, v5 | ✅ Match |
| **AuthApiPaths** | ✅ Full | ✅ Full | ✅ Match |
| **ShopApiPaths** | ✅ Full | ⚠️ Incomplete | ⚠️ Missing activity logs |
| **ServiceApiPaths** | ✅ Full (as ProductApiPaths) | ⚠️ Incomplete | ⚠️ Missing variants, materials |
| **BookingsApiPaths** | ✅ Full | ⚠️ Incomplete | ⚠️ Wrong versions, missing methods |
| **SalesApiPaths** | ✅ Full | ❌ Incomplete | 🔴 Wrong version, missing methods |
| **StaffApiPaths** | ✅ Full | ✅ Mostly complete | ⚠️ Missing restore method |
| **ExpensesApiPaths** | ✅ Full | ⚠️ Incomplete | ⚠️ Wrong transaction history path |
| **LedgerApiPaths** | ✅ Full | ⚠️ Incomplete | ⚠️ Wrong sales path, missing v5 |
| **NotificationsApiPaths** | ✅ Full | ✅ Full | ✅ Match |
| **TailorApiPaths** | ✅ Full | ❌ MISSING | 🔴 CRITICAL |
| **CustomizationWorkApiPaths** | ✅ Full | ❌ MISSING | 🔴 CRITICAL |

---

## 2. CRITICAL Issues (Must Fix Immediately)

### 2.1 🔴 MISSING: Tailor API Paths Class

**Mobile Has:** Complete `TailorApiPaths` class
**Desktop Has:** ❌ NOTHING

**Mobile Implementation:**
```dart
class TailorApiPaths {
  const TailorApiPaths();
  
  static const _root = '${ApiConfig.v3}/tailored/';
  static const tailors = '${_root}tailor/';
  
  String tailorById(int id) => '${tailors}$id/';
  String tailorMonthlySummary(int tailorId) => 
      '${tailors}tailor-monthly-summary/$tailorId/';
}
```

**Impact:** 🔴 CRITICAL - Desktop cannot implement Tailor module without this

**Required Action:**
1. Create `lib/core/api/tailor_api_paths.dart`
2. Add to `api_paths.dart` facade
3. Implement TailorService

**Estimated Effort:** 30 minutes

---

### 2.2 🔴 MISSING: Customization Work API Paths Class

**Mobile Has:** Complete `CustomizationWorkApiPaths` class (9 endpoints)
**Desktop Has:** ❌ NOTHING

**Mobile Implementation:**
```dart
class CustomizationWorkApiPaths {
  const CustomizationWorkApiPaths();
  
  static const _root = '${ApiConfig.v3}/tailored/tailor-order/';
  
  String customWorkById(int id) => '${_root}$id/';
  String addPaymentToCustomWork(int id) => '${_root}update-payment/$id/';
  String deletePaymentFromCustomWork(int id) => '${_root}delete-payment/$id/';
  String updateStatusToCustomWork(int id) => '${_root}update-status/$id/';
  String downloadInvoiceById(int id) => '${_root}send-invoice/$id/';
  
  static const convertToBooking = '${ApiConfig.v3}/tailored/convert-to-booking/';
}
```

**Impact:** 🔴 CRITICAL - Desktop cannot implement Custom Work module

**Required Action:**
1. Create `lib/core/api/customization_work_api_paths.dart`
2. Add to `api_paths.dart` facade
3. Implement CustomWorkService

**Estimated Effort:** 45 minutes

---

### 2.3 🔴 WRONG VERSION: Dashboard API (v2 vs v4)

**Mobile Uses:** `/api/v4/bookings/dashboard/`  
**Desktop Uses:** `/api/v2/bookings/dashboard/` ❌ WRONG!

**Location:** `lib/features/home/services/dashboard_service.dart:18`

**Current (WRONG):**
```dart
final response = await DioClient.dio.get(
  '/api/v2/bookings/dashboard/',  // ❌ v2 is outdated!
  queryParameters: {'page': page},
);
```

**Should Be:**
```dart
final response = await DioClient.dio.get(
  ApiPaths.bookings.dashboard,  // Uses v4 correctly
  queryParameters: {'page': page},
);
```

**Issues:**
1. ❌ Using v2 (very old version)
2. ❌ Hardcoded path instead of `ApiPaths`
3. ❌ Mobile uses v4, desktop uses v2 (compatibility issues)

**Impact:** 🔴 HIGH - May return wrong data structure, deprecated endpoint

**Fix:**
```dart
// 1. Update BookingsApiPaths
class BookingsApiPaths {
  static const dashboard = '${_rootV4}dashboard/';  // ✅ Already correct!
}

// 2. Update DashboardService
class DashboardService {
  Future<(PaginationModel<BookingsModel>, CarouselDataModel)>
      fetchDashboardData(int page) async {
    try {
      final response = await DioClient.dio.get(
        ApiPaths.bookings.dashboard,  // ✅ Use centralized path
        queryParameters: {'page': page},
      );
      // ... rest
    }
  }
}
```

**Estimated Effort:** 10 minutes

---

### 2.4 🔴 WRONG VERSION: Sales API (v3 only vs v3+v4)

**Mobile Uses:**
- v3: DELETE, invoice download  
- v4: GET (list), POST (create), GET (details), PATCH (update)

**Desktop Uses:** v3 ONLY for everything ❌

**Current Desktop Implementation:**
```dart
class SalesApiPaths {
  static const _root = '${ApiConfig.v3}/sales/';  // ❌ Only v3!
  static const sales = '${_root}sales/';
  static const updateSale = '${sales}update-sale/';  // ❌ Wrong path!
}
```

**Mobile Implementation:**
```dart
class SalesApiPaths {
  const SalesApiPaths();
  
  static const _salesV3 = '${ApiConfig.v3}/sales/sales/';
  static const _salesV4 = '${ApiConfig.v4}/sales/sales/';
  
  // v3 endpoints (legacy)
  String get salesV3 => _salesV3;
  String saleByIdV3(int id) => '${_salesV3}$id/';
  String downloadSalesInvoiceById(int id) => '${_salesV3}send-invoice/$id/';
  
  // v4 endpoints (preferred)
  String get salesV4 => _salesV4;  // ✅ List & Create
  String saleById(int id) => '${_salesV4}$id/';  // ✅ Get details
  String updateSaleById(int id) => '${_salesV4}update-sale/$id/';  // ✅ Update
}
```

**Issues:**
1. ❌ Desktop using v3 for all operations
2. ❌ Mobile uses v4 for CRUD operations
3. ❌ Desktop missing dynamic methods for sale operations
4. ❌ Update path is wrong: should be `${_salesV4}update-sale/$id/` not `${sales}update-sale/`

**Impact:** 🔴 HIGH - Desktop may use deprecated API, incompatible with mobile

**Required Fix:**
```dart
class SalesApiPaths {
  static const _salesV3 = '${ApiConfig.v3}/sales/sales/';
  static const _salesV4 = '${ApiConfig.v4}/sales/sales/';
  
  // v3 (for delete & invoice)
  static const String salesV3 = _salesV3;
  static String downloadInvoice(int id) => '${_salesV3}send-invoice/$id/';
  
  // v4 (for CRUD) - PREFERRED
  static const String sales = _salesV4;  // ✅ List & Create use v4
  static String saleById(int id) => '${_salesV4}$id/';  // ✅ Details use v4
  static String updateSale(int id) => '${_salesV4}update-sale/$id/';  // ✅ Update needs ID
}
```

**Service Updates Needed:**
```dart
class SalesService {
  // ✅ Use v4 for list
  Future<CustomResponseModel> getSalesPagination() async {
    final response = await _dio.get(ApiPaths.sales.sales);  // v4
  }
  
  // ✅ Use v4 for details
  Future<CustomResponseModel> getSaleDetails(int saleId) async {
    final response = await _dio.get(ApiPaths.sales.saleById(saleId));  // v4
  }
  
  // ✅ Use v4 for update
  Future<CustomResponseModel> updateSale(SalesRequestModel salesRequest) async {
    final response = await _dio.patch(
      ApiPaths.sales.updateSale(salesRequest.id!),  // v4 with ID method
      data: salesRequest.toJson(),
    );
  }
  
  // ✅ Use v3 for delete (if that's what mobile uses)
  Future<CustomResponseModel> deleteSale(int saleId) async {
    final response = await _dio.delete('${ApiPaths.sales.salesV3}$saleId/');
  }
}
```

**Estimated Effort:** 1 hour

---

### 2.5 🔴 MISSING: Booking Payment Delete Endpoint

**Mobile Has:** `DELETE /api/v5/bookings/bookings/delete-payment/{id}/`  
**Desktop Has:** ❌ MISSING

**Mobile Implementation:**
```dart
class BookingsApiPaths {
  String deletePayment(int paymentId) => '${_bookingsV5}delete-payment/$paymentId/';
}
```

**Desktop Implementation:**
```dart
class BookingsApiPaths {
  // ❌ MISSING: deletePayment method
  static const addPayment = '${bookingsV5}add-payment/';  // Has add but not delete
}
```

**Impact:** 🔴 HIGH - Desktop cannot delete payments from bookings

**Required Fix:**
```dart
class BookingsApiPaths {
  static const addPayment = '${bookingsV5}add-payment/';
  
  // ✅ ADD THIS:
  static String deletePayment(int paymentId) => 
      '${bookingsV5}delete-payment/$paymentId/';
}
```

**Estimated Effort:** 5 minutes

---

## 3. HIGH Priority Issues

### 3.1 ⚠️ WRONG PATH: Expenses Transaction History

**Mobile Uses:** `/api/v4/expenses/transaction-history/`  
**Desktop Uses:** `/api/v3/expenses/transaction-history/` ❌ WRONG VERSION

**Current Desktop:**
```dart
class ExpensesApiPaths {
  static const _root = '${ApiConfig.v3}/expenses/';
  static const transactionHistory = '${_root}transaction-history/';  // ❌ v3
}
```

**Should Be:**
```dart
class ExpensesApiPaths {
  static const _rootV3 = '${ApiConfig.v3}/expenses/';
  static const _rootV4 = '${ApiConfig.v4}/expenses/';
  
  static const transactionHistory = '${_rootV4}transaction-history/';  // ✅ v4
}
```

**Impact:** ⚠️ MEDIUM - May return wrong data format

**Estimated Effort:** 10 minutes

---

### 3.2 ⚠️ WRONG PATH: Ledger Sales

**Mobile Uses:** `/api/v4/sales/wallet/sales/`  
**Desktop Uses:** `/api/v3/sales/wallet/sales/` ❌ WRONG VERSION

**Current Desktop:**
```dart
class LedgerApiPaths {
  static const sales = '${ApiConfig.v3}/sales/wallet/sales/';  // ❌ v3
}
```

**Should Be:**
```dart
class LedgerApiPaths {
  static const sales = '${ApiConfig.v4}/sales/wallet/sales/';  // ✅ v4
}
```

**Impact:** ⚠️ MEDIUM - Ledger may show incorrect sales data

**Estimated Effort:** 5 minutes

---

### 3.3 ⚠️ MISSING: Ledger Pending Amounts (v5)

**Mobile Uses:** `/api/v5/bookings/wallet/pending-amounts/`  
**Desktop Uses:** `/api/v4/bookings/wallet/pending-amounts/` ❌ WRONG VERSION

**Current Desktop:**
```dart
class LedgerApiPaths {
  static const _rootV4 = '${ApiConfig.v4}/bookings/wallet/';
  static const pendingAmounts = '${_rootV4}pending-amounts/';  // ❌ v4
}
```

**Should Be:**
```dart
class LedgerApiPaths {
  static const _rootV4 = '${ApiConfig.v4}/bookings/wallet/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/wallet/';  // ✅ Add v5
  
  static const pendingAmounts = '${_rootV5}pending-amounts/';  // ✅ v5
  static const securityAmounts = '${_rootV5}security-amounts/';  // ✅ v5
  static const paymentDetails = '${_rootV5}payment-details/';  // ✅ v5
}
```

**Impact:** ⚠️ MEDIUM - Pending amounts may not load correctly

**Estimated Effort:** 10 minutes

---

### 3.4 ⚠️ MISSING: Shop Activity Logs Endpoint

**Mobile Has:** `/api/v3/shop/shop-activity-logs/`  
**Desktop Has:** ❌ MISSING

**Required Addition:**
```dart
class ShopApiPaths {
  static const _root = '${ApiConfig.v3}/shop/';
  static const availableShops = '${_root}available-shops/';
  static const privacySettings = '${_root}shop-privacy-settings/';
  static const updateSettings = '${_root}shop-settings/update-settings/';
  
  // ✅ ADD THIS:
  static const activityLogs = '${_root}shop-activity-logs/';
}
```

**Impact:** ⚠️ LOW - Missing audit trail feature

**Estimated Effort:** 5 minutes

---

## 4. MEDIUM Priority Issues (Missing Dynamic Methods)

### 4.1 Missing Product/Service Dynamic Methods

**Mobile Has:**
```dart
class ProductApiPaths {
  String productById(String id) => '$productsRoot$id/';
  String monthlySummary(String id) => '$productsRoot/monthly-summary/$id/';
  String materialUsageData(int productId) => '$productsRoot/material-usage-orders/$productId/';
  String variantById(String productId, String variantId) => 
      '$productsRoot$productId/variants/$variantId/';
  String checkVariantAvailability(int variantId) => 
      '${ApiConfig.v5}/bookings/bookings/variant-availability/$variantId/';
}
```

**Desktop Has:**
```dart
class ServiceApiPaths {
  static String productById(String id) => '$productsRoot$id/';  // ✅ Has
  static String monthlySummary(String id) => '$productsRoot/monthly-summary/$id/';  // ✅ Has
  
  // ❌ MISSING:
  // - materialUsageData(int productId)
  // - variantById(String productId, String variantId)
  // - checkVariantAvailability(int variantId)
  // - Product bookings history
  // - List with variants endpoint
}
```

**Required Additions:**
```dart
class ServiceApiPaths {
  static const _root = '${ApiConfig.v3}/service/';
  static const productsRoot = '${_root}products/';
  
  // Existing
  static String productById(String id) => '$productsRoot$id/';
  static String monthlySummary(String id) => '$productsRoot/monthly-summary/$id/';
  
  // ✅ ADD THESE:
  static String productBookings(int id) => '${productsRoot}product-bookings/$id/';
  static String materialUsage(int id) => '${productsRoot}material-usage-orders/$id/';
  static const listWithVariants = '${productsRoot}list-with-variants/';
  
  // Variant operations
  static String addVariant(String productId) => '${productById(productId)}variants/';
  static String variantById(String productId, String variantId) => 
      '${productById(productId)}variants/$variantId/';
  
  // Availability check (v5)
  static String checkVariantAvailability(int variantId) =>
      '${ApiConfig.v5}/bookings/bookings/variant-availability/$variantId/';
}
```

**Estimated Effort:** 20 minutes

---

### 4.2 Missing Staff Dynamic Methods

**Mobile Has:**
```dart
class StaffApiPaths {
  String staffById(int id) => '${staff}$id/';
  String restoreDeletedStaffById(int id) => '${staff}restore/$id/';  // ✅ Important!
  String staffAnalyticsReportById(int id) => '${staffAnalyticsReport}$id/';
}
```

**Desktop Has:**
```dart
class StaffApiPaths {
  static String staffById(int id) => '${staff}$id/';  // ✅ Has
  static String staffAnalyticsReportById(int id) => 
      '${staffAnalyticsReport}$id/';  // ✅ Has
  
  // ❌ MISSING:
  // - restoreDeletedStaffById(int id)
}
```

**Required Addition:**
```dart
class StaffApiPaths {
  static const staff = '${_root}staff/';
  
  static String staffById(int id) => '${staff}$id/';
  
  // ✅ ADD THIS:
  static String restoreDeletedStaff(int id) => '${staff}restore/$id/';
  
  static String staffAnalyticsReportById(int id) => 
      '${staffAnalyticsReport}$id/';
}
```

**Estimated Effort:** 5 minutes

---

### 4.3 Missing Booking Dynamic Methods

**Mobile Has:**
```dart
class BookingsApiPaths {
  String downloadInvoiceById(int id) => '${v5}send-invoice/$id/';
  String deletePayment(int paymentId) => '${_bookingsV5}delete-payment/$paymentId/';
  
  // Clients
  String clientById(int id) => '${clients}$id/';
}
```

**Desktop Has:**
```dart
class BookingsApiPaths {
  static String downloadBookingInvoice(int bookingId) =>
      '${bookingsV5}$bookingId/download-invoice/';  // ⚠️ WRONG PATH!
  
  // ❌ MISSING:
  // - deletePayment(int paymentId)
  // - clientById(int id)
}
```

**Issues:**
1. ❌ Invoice path is wrong: should be `send-invoice/{id}/` not `{id}/download-invoice/`
2. ❌ Missing deletePayment method
3. ❌ Missing clientById method

**Required Fixes:**
```dart
class BookingsApiPaths {
  static const bookingsV5 = '${_rootV5}bookings/';
  static const clients = '${_rootV3}clients/';
  
  // ✅ FIX: Invoice path
  static String downloadBookingInvoice(int bookingId) =>
      '${bookingsV5}send-invoice/$bookingId/';  // Correct path
  
  // ✅ ADD: Delete payment
  static String deletePayment(int paymentId) =>
      '${bookingsV5}delete-payment/$paymentId/';
  
  // ✅ ADD: Client by ID
  static String clientById(int id) => '${clients}$id/';
}
```

**Estimated Effort:** 10 minutes

---

## 5. Structural Issues

### 5.1 Hardcoded Paths vs Centralized Paths

**Issue:** Desktop's `DashboardService` uses hardcoded path instead of `ApiPaths`

**Bad Example (Current Desktop):**
```dart
final response = await DioClient.dio.get(
  '/api/v2/bookings/dashboard/',  // ❌ Hardcoded!
  queryParameters: {'page': page},
);
```

**Good Example (Should Use):**
```dart
final response = await DioClient.dio.get(
  ApiPaths.bookings.dashboard,  // ✅ Centralized!
  queryParameters: {'page': page},
);
```

**Impact:** ⚠️ MEDIUM - Harder to maintain, version changes require multiple file edits

**Recommendation:** Audit all services for hardcoded paths

---

### 5.2 Missing Const Constructors

**Mobile Pattern:**
```dart
class AuthApiPaths {
  const AuthApiPaths();  // ✅ Const constructor
  
  static const _rootV3 = '${ApiConfig.v3}/auth/';
  static const login = '${_rootV3}login/';
}
```

**Desktop Pattern:**
```dart
class BookingsApiPaths {
  // ❌ No constructor - can't create const instances
  
  static const _rootV3 = '${ApiConfig.v3}/bookings/';
}
```

**Impact:** 📋 LOW - Minor, but inconsistent with mobile

**Recommendation:** Add `const` constructors to all API path classes for consistency

---

## 6. Missing Endpoints Summary

### 6.1 Complete Missing API Modules

| Module | Mobile | Desktop | Action |
|--------|--------|---------|--------|
| **Tailor** | ✅ 5 endpoints | ❌ NONE | 🔴 CREATE tailor_api_paths.dart |
| **Custom Work** | ✅ 9 endpoints | ❌ NONE | 🔴 CREATE customization_work_api_paths.dart |

### 6.2 Missing Individual Endpoints

| Endpoint | Mobile Path | Desktop Status |
|----------|-------------|----------------|
| **Product Material Usage** | `/api/v3/service/products/material-usage-orders/{id}/` | ❌ Missing |
| **Product Bookings History** | `/api/v3/service/products/product-bookings/{id}/` | ❌ Missing |
| **Product List with Variants** | `/api/v3/service/products/list-with-variants/` | ❌ Missing |
| **Product Variant CRUD** | `/api/v3/service/products/{id}/variants/{variantId}/` | ❌ Missing |
| **Variant Availability Check** | `/api/v5/bookings/bookings/variant-availability/{variantId}/` | ❌ Missing |
| **Booking Delete Payment** | `/api/v5/bookings/bookings/delete-payment/{id}/` | ❌ Missing |
| **Staff Restore** | `/api/v3/shop/staff/restore/{id}/` | ❌ Missing |
| **Shop Activity Logs** | `/api/v3/shop/shop-activity-logs/` | ❌ Missing |
| **Sales Invoice Download** | `/api/v3/sales/sales/send-invoice/{id}/` | ❌ Missing |

---

## 7. Version Migration Roadmap

### 7.1 Immediate Fixes (Day 1 - 2 hours)

**Priority 1: Fix Critical Version Mismatches**

1. ✅ **Dashboard API** (10 min)
   - Change: `/api/v2/bookings/dashboard/` → `/api/v4/bookings/dashboard/`
   - File: `lib/features/home/services/dashboard_service.dart`
   - Use: `ApiPaths.bookings.dashboard`

2. ✅ **Sales API** (30 min)
   - Add v4 support to `SalesApiPaths`
   - Update `SalesService` to use v4 for CRUD
   - Keep v3 for delete operation

3. ✅ **Ledger API** (15 min)
   - Fix sales path: v3 → v4
   - Fix pending/security/payment: v4 → v5

4. ✅ **Expenses Transaction History** (10 min)
   - Fix: v3 → v4

5. ✅ **Booking Invoice Path** (5 min)
   - Fix path structure
   - Add deletePayment method

### 7.2 High Priority (Week 1 - 4 hours)

**Priority 2: Create Missing API Classes**

6. ✅ **Tailor API Paths** (30 min)
   - Create `lib/core/api/tailor_api_paths.dart`
   - Add to `ApiPaths` facade
   - 5 endpoints

7. ✅ **Customization Work API Paths** (45 min)
   - Create `lib/core/api/customization_work_api_paths.dart`
   - Add to `ApiPaths` facade
   - 9 endpoints

8. ✅ **Product/Service Missing Methods** (30 min)
   - Add material usage
   - Add variant operations
   - Add availability check
   - Add product bookings history

9. ✅ **Shop Activity Logs** (15 min)
   - Add endpoint to `ShopApiPaths`

10. ✅ **Staff Restore** (10 min)
    - Add restore method to `StaffApiPaths`

### 7.3 Medium Priority (Week 2 - 2 hours)

**Priority 3: Code Quality & Consistency**

11. ✅ **Add Const Constructors** (30 min)
    - Add to all API path classes
    - Match mobile pattern

12. ✅ **Audit for Hardcoded Paths** (1 hour)
    - Search all services for hardcoded API strings
    - Replace with `ApiPaths.*`

13. ✅ **Add Missing Dynamic Methods** (30 min)
    - Client by ID
    - Any other parameterized paths

---

## 8. Implementation Checklist

### 8.1 Critical Fixes (Must Do Today)

- [ ] Fix DashboardService to use v4 (not v2)
- [ ] Update SalesApiPaths to support v3 + v4
- [ ] Update SalesService to use v4 for CRUD
- [ ] Fix LedgerApiPaths versions (sales v4, pending v5)
- [ ] Fix ExpensesApiPaths transaction history to v4
- [ ] Add deletePayment method to BookingsApiPaths
- [ ] Fix booking invoice download path

### 8.2 Missing API Classes (Week 1)

- [ ] Create `tailor_api_paths.dart` with 5 endpoints
- [ ] Create `customization_work_api_paths.dart` with 9 endpoints
- [ ] Add Tailor namespace to `ApiPaths` facade
- [ ] Add CustomizationWork namespace to `ApiPaths` facade

### 8.3 Missing Endpoints (Week 1)

**ServiceApiPaths:**
- [ ] Add `materialUsage(int id)`
- [ ] Add `productBookings(int id)`
- [ ] Add `listWithVariants`
- [ ] Add `addVariant(String productId)`
- [ ] Add `variantById(String productId, String variantId)`
- [ ] Add `checkVariantAvailability(int variantId)` (v5)

**StaffApiPaths:**
- [ ] Add `restoreDeletedStaff(int id)`

**ShopApiPaths:**
- [ ] Add `activityLogs`

**BookingsApiPaths:**
- [ ] Add `clientById(int id)`

**SalesApiPaths:**
- [ ] Add `downloadInvoice(int id)` (v3)

### 8.4 Code Quality (Week 2)

- [ ] Add const constructors to all API path classes
- [ ] Search and replace all hardcoded API paths
- [ ] Add comprehensive unit tests for API paths
- [ ] Document version rationale in comments

---

## 9. Testing Strategy

### 9.1 API Path Unit Tests

**Create:** `test/core/api/api_paths_test.dart`

```dart
void main() {
  group('AuthApiPaths', () {
    test('login path uses v3', () {
      expect(AuthApiPaths.login, '/api/v3/auth/login/');
    });
    
    test('profile path uses v4', () {
      expect(AuthApiPaths.profile, '/api/v4/auth/profile/');
    });
  });
  
  group('BookingsApiPaths', () {
    test('bookings list uses v5', () {
      expect(BookingsApiPaths.bookingsV5, '/api/v5/bookings/bookings/');
    });
    
    test('dashboard uses v4', () {
      expect(BookingsApiPaths.dashboard, '/api/v4/bookings/dashboard/');
    });
    
    test('deletePayment constructs correct path', () {
      expect(
        BookingsApiPaths.deletePayment(123),
        '/api/v5/bookings/bookings/delete-payment/123/',
      );
    });
  });
  
  group('SalesApiPaths', () {
    test('sales CRUD uses v4', () {
      expect(SalesApiPaths.sales, '/api/v4/sales/sales/');
    });
    
    test('sales delete uses v3', () {
      expect(SalesApiPaths.salesV3, '/api/v3/sales/sales/');
    });
    
    test('update sale includes ID in path', () {
      expect(
        SalesApiPaths.updateSale(456),
        '/api/v4/sales/sales/update-sale/456/',
      );
    });
  });
}
```

### 9.2 Integration Tests

- Test actual API calls with correct versions
- Verify response structures match expectations
- Test backward compatibility where needed

---

## 10. Risk Assessment

### 10.1 High Risk Changes

| Change | Risk Level | Mitigation |
|--------|------------|------------|
| Dashboard v2 → v4 | 🔴 HIGH | Test thoroughly, may break response parsing |
| Sales v3 → v4 | 🔴 HIGH | Phase migration, test each endpoint |
| Ledger version updates | ⚠️ MEDIUM | Verify data matches mobile app |

### 10.2 Safe Changes

| Change | Risk Level | Notes |
|--------|------------|-------|
| Add missing endpoints | 🟢 LOW | New functionality, no breaking changes |
| Add const constructors | 🟢 LOW | No functional impact |
| Fix hardcoded paths | 🟢 LOW | Same endpoints, better structure |

---

## 11. Recommended Implementation Order

### Day 1 (2 hours):
1. Fix DashboardService v2 → v4 (CRITICAL)
2. Update SalesApiPaths for v4
3. Fix LedgerApiPaths versions
4. Add deletePayment to BookingsApiPaths

### Week 1 (4 hours):
5. Create TailorApiPaths
6. Create CustomizationWorkApiPaths
7. Add missing Product endpoints
8. Add shop activity logs

### Week 2 (2 hours):
9. Code quality improvements
10. Add unit tests
11. Documentation updates

**Total Effort:** ~8 hours spread over 2 weeks

---

## 12. Summary

### Current State:
- ✅ Good: Centralized API path management via `ApiPaths`
- ✅ Good: Version-aware structure (v3, v4, v5)
- ❌ Bad: 2 complete API modules missing (Tailor, Custom Work)
- ❌ Bad: 5 critical version mismatches
- ❌ Bad: 1 hardcoded path (dashboard)
- ⚠️ Warning: 8+ missing endpoints

### Target State:
- ✅ All API paths use correct versions matching mobile
- ✅ Tailor & Custom Work API classes created
- ✅ All missing endpoints added
- ✅ No hardcoded paths in services
- ✅ Consistent structure across all API classes
- ✅ Comprehensive unit tests

### Priority Actions:
1. 🔴 Fix dashboard v2 → v4 (TODAY)
2. 🔴 Update Sales API to v4 (TODAY)
3. 🔴 Create Tailor API paths (WEEK 1)
4. 🔴 Create Custom Work API paths (WEEK 1)
5. ⚠️ Add missing endpoints (WEEK 1-2)

**Status:** Desktop API structure is ~70% aligned with mobile. Critical issues require immediate attention, but overall structure is sound.
