# API Fixes Quick Reference

**Generated:** November 14, 2025  
**Status:** Critical API issues requiring immediate fixes

---

## 🔴 CRITICAL FIXES (Must Do Today - 2 hours)

### 1. Fix Dashboard API Version (10 minutes)

**File:** `lib/features/home/services/dashboard_service.dart:18`

**WRONG:**
```dart
final response = await DioClient.dio.get(
  '/api/v2/bookings/dashboard/',  // ❌ v2 is outdated!
  queryParameters: {'page': page},
);
```

**CORRECT:**
```dart
final response = await DioClient.dio.get(
  ApiPaths.bookings.dashboard,  // ✅ Uses v4
  queryParameters: {'page': page},
);
```

---

### 2. Fix Sales API (30 minutes)

**File:** `lib/core/api/sales_api_paths.dart`

**REPLACE ALL with:**
```dart
import 'package:bookie_buddy_web/core/api/api_config.dart';

class SalesApiPaths {
  const SalesApiPaths();
  
  static const _salesV3 = '${ApiConfig.v3}/sales/sales/';
  static const _salesV4 = '${ApiConfig.v4}/sales/sales/';
  
  // v3 (for delete & invoice download)
  static const String salesV3 = _salesV3;
  static String downloadInvoice(int id) => '${_salesV3}send-invoice/$id/';
  
  // v4 (PREFERRED for CRUD)
  static const String sales = _salesV4;  // List & Create
  static String saleById(int id) => '${_salesV4}$id/';  // Details
  static String updateSale(int id) => '${_salesV4}update-sale/$id/';  // Update (with ID!)
}
```

**Update Service:**
```dart
// lib/core/services/sales_service.dart

// Change updateSale method:
Future<CustomResponseModel> updateSale(SalesRequestModel salesRequest) async {
  try {
    final response = await _dio.patch(
      ApiPaths.sales.updateSale(salesRequest.id!),  // ✅ Now has ID in path
      data: salesRequest.toJson(),
    );
    log('Sales update response: ${response.data}');
    return CustomResponseModel.fromJson(response.data);
  } catch (e, stack) {
    log('Error updating sale: $e', stackTrace: stack);
    rethrow;
  }
}
```

---

### 3. Fix Ledger API Versions (15 minutes)

**File:** `lib/core/api/ledger_api_paths.dart`

**REPLACE:**
```dart
import 'package:bookie_buddy_web/core/api/api_config.dart';

class LedgerApiPaths {
  const LedgerApiPaths();
  
  static const _rootV4 = '${ApiConfig.v4}/bookings/wallet/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/wallet/';  // ✅ Add v5

  static const expenses = '${ApiConfig.v4}/expenses/wallet/expenses/';
  
  // ✅ v5 for these:
  static const pendingAmounts = '${_rootV5}pending-amounts/';
  static const securityAmounts = '${_rootV5}security-amounts/';
  static const paymentDetails = '${_rootV5}payment-details/';
  
  // v4 for these:
  static const bookingAmounts = '${_rootV4}booking-amounts/';
  static const dailySummary = _rootV4;
  
  // ✅ Fix to v4:
  static const sales = '${ApiConfig.v4}/sales/wallet/sales/';  // Was v3
}
```

---

### 4. Fix Expenses Transaction History (10 minutes)

**File:** `lib/core/api/expenses_api_paths.dart`

**CHANGE:**
```dart
class ExpensesApiPaths {
  static const _rootV3 = '${ApiConfig.v3}/expenses/';
  static const _rootV4 = '${ApiConfig.v4}/expenses/';  // ✅ Add v4
  
  static const expenses = '${_rootV3}expenses/';
  static const variantExpenses = '${_rootV3}variant-expenses/';
  static const daywiseSummary = '${_rootV3}wallet/daywise-summary/';
  static const exportTransactionsExcel = '${_rootV3}export-transactions/excel/';
  
  // ✅ Fix to v4:
  static const transactionHistory = '${_rootV4}transaction-history/';  // Was v3
}
```

---

### 5. Add Missing Booking Methods (10 minutes)

**File:** `lib/core/api/bookings_api_paths.dart`

**ADD:**
```dart
class BookingsApiPaths {
  static const _rootV3 = '${ApiConfig.v3}/bookings/';
  static const _rootV4 = '${ApiConfig.v4}/bookings/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/';

  static const bookingsV3 = '${_rootV3}bookings/';
  static const bookingsV4 = '${_rootV4}bookings/';
  static const bookingsV5 = '${_rootV5}bookings/';
  static const addPayment = '${bookingsV5}add-payment/';
  static const updateDetails = '${bookingsV5}update-details/';
  static const updateDeliveryStatus = '${bookingsV5}update-delivery-status/';
  static const updateBookingStatus = '${bookingsV5}update-booking-status/';
  static const oldBookings = '${bookingsV3}old-bookings/';
  static const clients = '${_rootV3}clients/';
  static const availableProducts = '${bookingsV3}available-products/';
  static const dashboard = '${_rootV4}dashboard/';  // ✅ v4 not v3!
  
  // ✅ FIX invoice path:
  static String downloadBookingInvoice(int bookingId) =>
      '${bookingsV5}send-invoice/$bookingId/';  // Was: $bookingId/download-invoice/
  
  // ✅ ADD delete payment:
  static String deletePayment(int paymentId) =>
      '${bookingsV5}delete-payment/$paymentId/';
  
  // ✅ ADD client by ID:
  static String clientById(int id) => '${clients}$id/';
}
```

---

## ⚠️ WEEK 1 PRIORITIES (4 hours)

### 6. Create Tailor API Paths (30 minutes)

**Create:** `lib/core/api/tailor_api_paths.dart`
```dart
import 'package:bookie_buddy_web/core/api/api_config.dart';

class TailorApiPaths {
  const TailorApiPaths();
  
  static const _root = '${ApiConfig.v3}/tailored/';
  static const tailors = '${_root}tailor/';
  
  static String tailorById(int id) => '${tailors}$id/';
  static String tailorMonthlySummary(int tailorId) => 
      '${tailors}tailor-monthly-summary/$tailorId/';
}
```

**Update:** `lib/core/api/api_paths.dart`
```dart
import 'package:bookie_buddy_web/core/api/tailor_api_paths.dart';

class ApiPaths {
  // ... existing
  static const tailor = _TailorNamespace();
}

class _TailorNamespace {
  const _TailorNamespace();
  String get tailors => TailorApiPaths.tailors;
  String tailorById(int id) => TailorApiPaths.tailorById(id);
  String tailorMonthlySummary(int id) => TailorApiPaths.tailorMonthlySummary(id);
}
```

---

### 7. Create Custom Work API Paths (45 minutes)

**Create:** `lib/core/api/customization_work_api_paths.dart`
```dart
import 'package:bookie_buddy_web/core/api/api_config.dart';

class CustomizationWorkApiPaths {
  const CustomizationWorkApiPaths();
  
  static const _root = '${ApiConfig.v3}/tailored/tailor-order/';
  
  static const customWorks = _root;
  static String customWorkById(int id) => '${_root}$id/';
  static String addPayment(int id) => '${_root}update-payment/$id/';
  static String deletePayment(int id) => '${_root}delete-payment/$id/';
  static String updateStatus(int id) => '${_root}update-status/$id/';
  static String downloadInvoice(int id) => '${_root}send-invoice/$id/';
  
  static const convertToBooking = '${ApiConfig.v3}/tailored/convert-to-booking/';
}
```

---

### 8. Add Missing Product Endpoints (20 minutes)

**File:** `lib/core/api/service_api_paths.dart`

**ADD:**
```dart
class ServiceApiPaths {
  static const _root = '${ApiConfig.v3}/service/';
  static const selected = '${_root}selected/';
  static const productSearch = '${_root}product-search/';
  static const productsRoot = '${_root}products/';

  static String productById(String id) => '$productsRoot$id/';
  static String monthlySummary(String id) =>
      '$productsRoot/monthly-summary/$id/';

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

  // Product Transfer (already has these)
  static const _transferRoot = '${_root}transfer-product/';
  static const matchProduct = '${_transferRoot}match-product/';
  static const transferHistory = '${_transferRoot}transfer-history/';
  static const transferStock = '${_transferRoot}transfer-stock/';
}
```

---

### 9. Add Missing Staff & Shop Endpoints (15 minutes)

**File:** `lib/core/api/staff_api_paths.dart`
```dart
class StaffApiPaths {
  static const _root = '${ApiConfig.v3}/shop/';
  static const String staff = '${_root}staff/';
  static const String staffAnalyticsReport =
      '${_root}staff-earnings/earnings-report/';
  static const String staffMonthlyBookingsOrSales =
      '${_root}staff-earnings/monthly-transactions/';
      
  static String staffById(int id) => '${staff}$id/';
  
  // ✅ ADD THIS:
  static String restoreDeletedStaff(int id) => '${staff}restore/$id/';
  
  static String staffAnalyticsReportById(int id) =>
      '${staffAnalyticsReport}$id/';
}
```

**File:** `lib/core/api/shop_api_paths.dart`
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

---

## 📊 TESTING CHECKLIST

After fixes, test:

- [ ] Dashboard loads correctly (v4)
- [ ] Sales CRUD operations work (v4)
- [ ] Ledger shows correct data (v4/v5)
- [ ] Pending amounts load (v5)
- [ ] Transaction history loads (v4)
- [ ] Booking invoice download works
- [ ] Booking payment delete works

---

**Total Time:** ~2 hours for critical fixes + 4 hours for Week 1 priorities

**See:** DESKTOP_API_COMPARISON_REPORT.md for full details
