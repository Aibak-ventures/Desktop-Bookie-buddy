import 'dart:typed_data';

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/models/desktop_booking_model/desktop_booking_item_model.dart';
import 'package:bookie_buddy_web/core/models/desktop_booking_model/status_counts_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:bookie_buddy_web/features/new_booking/models/document_file_model.dart';

abstract interface class IBookingRepository {
  Future<BookingDetailsModel> getBooking(int bookingId);

  Future<int> addBooking(RequestBookingModel bookingData);

  Future<int> createSale(Map<String, dynamic> saleData);

  Future<void> createOldBooking(RequestBookingModel bookingData);

  Future<void> updatePayment({
    required int bookingId,
    required int amount,
    required PaymentMethod paymentMethod,
  });

  Future<CustomResponseModel> updateBooking(
    int bookingId,
    RequestBookingModel updatedBooking,
  );

  Future<CustomResponseModel> updateBookingPartial(
    int bookingId,
    Map<String, dynamic> partialData, {
    List<DocumentFile>? newDocuments,
    List<String>? removedDocumentUrls,
  });

  Future<void> deleteBooking(int bookingId);

  Future<void> cancelBooking({
    required int bookingId,
    int? refundAmount,
    PaymentMethod? paymentMethod,
  });

  Future<void> updateBookingStatus(
    int bookingId,
    BookingStatus bookingStatus,
  );

  Future<void> updateDeliveryStatus(
    int bookingId,
    DeliveryStatus deliveryStatus,
  );

  Future<PaginationModel<BookingsModel>> loadBookingsPagination({
    required LoadBookingType status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
  });

  Future<
      ({
        PaginationModel<DesktopBookingItemModel> pagination,
        StatusCountsModel? statusCounts,
      })> loadDesktopBookingsPagination({
    required String status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
  });

  Future<String> downloadBookingInvoice({
    required int bookingId,
    required String fileName,
  });

  Future<List<BookingDetailsPaymentHistoryModel>> getPaymentHistory(
    int bookingId,
  );

  Future<void> sendInvoice(int bookingId, bool sendWhatsApp);

  Future<Uint8List> getInvoicePdfBytes(int bookingId);
}
