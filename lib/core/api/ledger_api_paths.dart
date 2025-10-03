import 'package:bookie_buddy_web/core/api/api_config.dart';

class LedgerApiPaths {
  static const _rootV4 = '${ApiConfig.v4}/bookings/wallet/';

  static const expenses = '${ApiConfig.v4}/expenses/wallet/expenses/';
  static const pendingAmounts = '${_rootV4}pending-amounts/';
  static const securityAmounts = '${_rootV4}security-amounts/';
  static const bookingAmounts = '${_rootV4}booking-amounts/';
  static const sales = '${ApiConfig.v3}/sales/wallet/sales/';
  static const paymentDetails = '${_rootV4}payment-details/';
  static const dailySummary = _rootV4; // backward compatibility
}
