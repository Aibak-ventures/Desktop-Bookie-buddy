import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class BookingsEndpoints {
  const BookingsEndpoints();

  static const _rootV3 = '${ApiConfig.v3}/bookings/';
  static const _rootV4 = '${ApiConfig.v4}/bookings/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/';

  static const _bookingsV3 = '${_rootV3}bookings/';
  static const _bookingsV5 = '${_rootV5}bookings/';

  final bookingsV3 = _bookingsV3;
  final bookingsV5 = _bookingsV5;
  final desktopList = '${_rootV5}bookings/desktop-list/';
  final oldBookings = '${_bookingsV3}old-bookings/';
  final dashboard = '${_rootV4}dashboard/';

  String bookingDetailV3(int id) => '${_bookingsV3}$id/';
  String bookingDetailV5(int id) => '${_bookingsV5}$id/';
  String paymentHistory(int bookingId) =>
      '${_bookingsV3}payment-details/$bookingId/';
  String addPayment(int bookingId) => '${_bookingsV5}add-payment/$bookingId/';
  String deletePayment(int id) => '${_bookingsV5}delete-payment/$id/';
  String updateDetails(int bookingId) =>
      '${_bookingsV5}update-details/$bookingId/';
  String updateDeliveryStatus(int bookingId) =>
      '${_bookingsV5}update-delivery-status/$bookingId/';
  String updateBookingStatus(int bookingId) =>
      '${_bookingsV5}update-booking-status/$bookingId/';
  String sendBookingInvoice(int bookingId) =>
      '${_bookingsV5}send-invoice/$bookingId/'; // Send invoice endpoint (returns PDF)
  String downloadBookingInvoice(int bookingId) =>
      '${_bookingsV5}send-invoice/$bookingId/'; // Same endpoint for download

  String addRefund(int bookingId) => '${_bookingsV5}refund/$bookingId/';
  String deleteRefund({required int bookingId, required int refundId}) =>
      '${_bookingsV5}refund/$bookingId/$refundId/';

  String updateSecurityRefund(int bookingId) =>
      '${_bookingsV5}security-adjustment/$bookingId/';
  String deleteSecurityRefundedPayment({required int refundId}) =>
      '${_bookingsV5}delete-security-adjustment/$refundId/';

  String updatePartialReturn(int bookingId) =>
      '${_bookingsV5}partial-return/$bookingId/';
}
