import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class LedgerEndpoints {
  static const _rootV4 = '${ApiConfig.v4}/bookings/wallet/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/wallet/';

  static const expenses = '${ApiConfig.v4}/expenses/wallet/expenses/';
  static const pendingAmounts = '${_rootV5}pending-amounts/';
  static const securityAmounts = '${_rootV5}security-amounts/';
  static const bookingAmounts = '${_rootV4}booking-amounts/';
  static const sales = '${ApiConfig.v4}/sales/wallet/sales/';
  static const paymentDetails = '${_rootV5}payment-details/';
  static const dailySummary = _rootV4; // backward compatibility
}
