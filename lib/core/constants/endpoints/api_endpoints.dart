import 'package:bookie_buddy_web/core/constants/endpoints/account_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/auth_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/bookings_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/client_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/notifications_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/product_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/sales_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/service_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/shop_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/staff_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/tax_configuration_endpoints.dart';

/// Centralized, namespaced API endpoints facade used across the app.
/// Each category of endpoints is grouped into its own class for better organization.
/// All fields are final to ensure immutability and prevent accidental changes.
///
/// Usage:
/// ```dart
/// final authLoginPath = ApiEndpoints.auth.login;
/// final salesListPath = ApiEndpoints.sales.sales;
/// ```
final class ApiEndpoints {
  const ApiEndpoints._();

  static const accounts = AccountEndpoints();
  static const auth = AuthEndpoints();
  static const shop = ShopEndpoints();
  static const service = ServiceEndpoints();
  static const products = ProductEndpoints();
  static const bookings = BookingsEndpoints();
  static const client = ClientEndpoints();
  static const sales = SalesEndpoints();
  static const notifications = NotificationsEndpoints();
  static const staff = StaffEndpoints();
  static const taxConfiguration = TaxConfigurationEndpoints();
}
