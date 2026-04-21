import 'dart:typed_data';

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/desktop_booking_item_entity/desktop_booking_item_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/status_counts_entity/status_counts_entity.dart';
import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';

abstract interface class IBookingRepository {
  Future<BookingDetailsEntity> getBooking(int bookingId);

  Future<int> addBooking(BookingRequestEntity bookingData);

  Future<int> createSale(Map<String, dynamic> saleData);

  Future<void> createOldBooking(BookingRequestEntity bookingData);

  Future<void> updatePayment({
    required int bookingId,
    required int amount,
    required int accountId,
  });

  Future<void> deletePayment(int paymentId);

  Future<CustomResponseModel> updateBooking(
    int bookingId,
    BookingRequestEntity updatedBooking,
  );

  Future<CustomResponseModel> updateBookingPartial(
    int bookingId,
    Map<String, dynamic> partialData, {
    List<DocumentFileEntity>? newDocuments,
    List<String>? removedDocumentUrls,
  });

  Future<void> deleteBooking(int bookingId);

  Future<void> cancelBooking({
    required int bookingId,
    int? refundAmount,
    int? accountId,
  });

  Future<void> updateBookingStatus(int bookingId, BookingStatus bookingStatus);

  Future<void> updateDeliveryStatus(
    int bookingId,
    DeliveryStatus deliveryStatus,
  );

  Future<PaginationModel<BookingEntity>> loadBookingsPagination({
    required LoadBookingType status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
  });

  Future<
    ({
      PaginationModel<DesktopBookingItemEntity> pagination,
      StatusCountsEntity? statusCounts,
    })
  >
  loadDesktopBookingsPagination({
    required String status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
    String? nextPageUrl,
  });

  Future<String> downloadBookingInvoice({
    required int bookingId,
    required String fileName,
  });

  Future<List<BookingPaymentHistoryEntity>> getPaymentHistory(int bookingId);

  Future<void> sendInvoice(int bookingId, bool sendWhatsApp);

  Future<Uint8List> getInvoicePdfBytes(int bookingId);
}
