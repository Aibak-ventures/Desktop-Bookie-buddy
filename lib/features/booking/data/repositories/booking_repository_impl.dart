import 'dart:developer';
import 'dart:typed_data';

import 'package:bookie_buddy_shared/core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/data/models/document_file_model.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/desktop_booking_item_entity/desktop_booking_item_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/status_counts_entity/status_counts_entity.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/desktop_booking_model/desktop_booking_item_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/desktop_booking_model/status_counts_model.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_request_model/booking_request_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

class BookingRepositoryImpl implements IBookingRepository {
  final BookingRemoteDatasource _datasource;
  BookingRepositoryImpl(this._datasource);

  // Get a single booking
  @override
  Future<BookingDetailsEntity> getBooking(int bookingId) async {
    try {
      final response = await safeApiCall(
        () => _datasource.getBooking(bookingId),
      );
      if (response.status.isSuccess) {
        return BookingDetailsModel.fromJson(response.data).toEntity();
      }
      log('Error fetching booking: ${response.devMessage}');
      throw response.message ?? 'Failed to fetch booking';
    } catch (e, stack) {
      log('Error fetching booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Create a booking
  @override
  Future<int> addBooking(
    BookingRequestEntity bookingData, {
    List<DocumentFileEntity>? documents,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.addBooking(
          BookingRequestModel.fromEntity(bookingData),
          documents: documents == null
              ? null
              : DocumentFileModel.fromEntityList(documents),
        ),
      );
      if (response.status.isSuccess) {
        if (response.data is Map) {
          final data = response.data as Map;
          if (data.containsKey('id')) return data['id'] as int;
          if (data.containsKey('booking_id')) return data['booking_id'] as int;
          if (data.containsKey('sale_id')) return data['sale_id'] as int;
        }
        if (response.data is int) return response.data as int;
        return 0; // Or handle error
      }
      log('Error adding booking: ${response.devMessage}');
      throw response.message ?? 'Failed to add booking';
    } catch (e, stack) {
      log('Error adding booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Create a sale
  @override
  Future<int> createSale(SalesRequestEntity saleData) async {
    try {
      final map = <String, dynamic>{
        if (saleData.staffId != null) 'staff_id': saleData.staffId,
        if (saleData.clientPhone != null && saleData.clientPhone!.isNotEmpty)
          'client_phone': saleData.clientPhone,
        if (saleData.address != null && saleData.address!.isNotEmpty)
          'client_address': saleData.address,
        if (saleData.saleDate != null) 'sale_date': saleData.saleDate,
        if (saleData.description != null) 'description': saleData.description,
        'send_invoice': saleData.sendPdfToWhatsApp,
        'variants': (saleData.products ?? [])
            .map(
              (p) => {
                'id': p.variant.variantId,
                'quantity': p.quantity,
                'amount': p.amount * p.quantity,
              },
            )
            .toList(),
        'paid_amount': saleData.paidAmount ?? 0,
        if (saleData.accountId != null) 'account_id': saleData.accountId,
        'discount': saleData.discountAmount ?? 0,
        'decrease_stock': saleData.stockCountDecrease ?? true,
      };
      final response = await safeApiCall(() => _datasource.createSale(map));
      if (response.status.isSuccess) {
        if (response.data is Map) {
          final data = response.data as Map;
          if (data.containsKey('sale_id')) return data['sale_id'] as int;
          if (data.containsKey('id')) return data['id'] as int;
        }
        if (response.data is int) return response.data as int;
        return 0;
      }
      log('Error creating sale: ${response.devMessage}');
      throw response.message ?? 'Failed to create sale';
    } catch (e, stack) {
      log('Error creating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Create old booking
  @override
  Future<void> createOldBooking(BookingRequestEntity bookingData) async {
    try {
      final response = await safeApiCall(
        () => _datasource.createOldBooking(
          BookingRequestModel.fromEntity(bookingData),
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error creating old booking: ${response.devMessage}');
      throw response.message ?? 'Failed to create old booking';
    } catch (e, stack) {
      log('Error creating old booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update amount or part of booking
  @override
  Future<void> updatePayment({
    required int bookingId,
    required int amount,
    required int accountId,
    String? paymentDate,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updatePayment(
          bookingId: bookingId,
          amount: amount,
          accountId: accountId,
          paymentDate: paymentDate,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating payment: ${response.devMessage}');
      throw response.message ?? 'Failed to update payment';
    } catch (e, stack) {
      log('Error updating payment: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> deletePayment(int paymentId) async {
    try {
      final response = await safeApiCall(
        () => _datasource.deletePayment(paymentId),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error deleting payment: ${response.devMessage}');
      throw response.message ?? 'Failed to delete payment';
    } catch (e, stack) {
      log('Error deleting payment: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update full booking data
  @override
  Future<CustomResponseModel> updateBooking(
    int bookingId,
    BookingRequestEntity updatedBooking,
  ) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateBooking(
          bookingId,
          BookingRequestModel.fromEntity(updatedBooking),
        ),
      );
      if (response.status.isSuccess || response.status.isInsufficientStock) {
        return response;
      }
      log('Error updating booking: ${response.devMessage}');
      throw response.message ?? 'Failed to update booking';
    } catch (e, stack) {
      log('Error updating booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update booking with partial data (only changed fields)
  // Used for incremental updates in edit mode
  // Supports FormData for file uploads and document management
  @override
  Future<CustomResponseModel> updateBookingPartial(
    int bookingId,
    Map<String, dynamic> partialData, {
    List<DocumentFileEntity>? newDocuments,
    List<String>? removedDocumentUrls,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateBookingPartial(
          bookingId,
          partialData,
          newDocuments: newDocuments
              ?.map((doc) => DocumentFileModel.fromEntity(doc))
              .toList(),
          removedDocumentUrls: removedDocumentUrls,
        ),
      );
      if (response.status.isSuccess) {
        return response;
      }
      if (response.status.isInsufficientStock) {
        final data = response.data as Map<String, dynamic>?;
        final productName = data?['product_name'] ?? 'Unknown Product';
        final attribute = data?['attribute'] ?? '';
        final fromDate = data?['out_of_stock_between']?['from'] ?? '';
        final toDate = data?['out_of_stock_between']?['to'] ?? '';
        throw 'Insufficient stock for "$productName${attribute.isNotEmpty ? " ($attribute)" : ""}". '
            'Not available from $fromDate to $toDate.';
      }
      log('Error updating booking partial: ${response.devMessage}');
      throw response.message ?? 'Failed to update booking';
    } catch (e, stack) {
      log('Error updating booking partial: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Delete a booking
  @override
  Future<void> deleteBooking(int bookingId) async {
    try {
      final response = await safeApiCall(
        () => _datasource.deleteBooking(bookingId),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error deleting booking: ${response.devMessage}');
      throw response.message ?? 'Failed to delete booking';
    } catch (e, stack) {
      log('Error deleting booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Cancel booking by updating delivery status and optionally adding refund
  @override
  Future<void> cancelBooking({
    required int bookingId,
    int? refundAmount,
    int? accountId,
  }) async {
    try {
      // First, update delivery status to cancelled
      final cancelResponse = await safeApiCall(
        () => _datasource.cancelBooking(bookingId: bookingId),
      );
      if (!cancelResponse.status.isSuccess) {
        log('Error cancelling booking: ${cancelResponse.devMessage}');
        throw cancelResponse.message ?? 'Failed to cancel booking';
      }

      // If there's a refund amount, add the refund
      if (refundAmount != null && refundAmount > 0 && accountId != null) {
        final refundResponse = await safeApiCall(
          () => _datasource.addRefund(
            bookingId: bookingId,
            amount: refundAmount,
            accountId: accountId,
            refundReason: 'Booking cancelled',
          ),
        );
        if (!refundResponse.status.isSuccess) {
          log('Error adding refund: ${refundResponse.devMessage}');
          throw refundResponse.message ?? 'Failed to add refund';
        }
      }
    } catch (e, stack) {
      log('Error cancelling booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update payment status
  @override
  Future<void> updateBookingStatus(
    int bookingId,
    BookingStatus bookingStatus,
  ) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateBookingStatus(
          bookingId: bookingId,
          bookingStatus: bookingStatus.value,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating booking status: ${response.devMessage}');
      throw response.message ?? 'Failed to update booking status';
    } catch (e, stack) {
      log('Error updating booking status: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update booking status (delivery or payment)
  @override
  Future<void> updateDeliveryStatus(
    int bookingId,
    DeliveryStatus deliveryStatus,
  ) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateDeliveryStatus(
          bookingId: bookingId,
          deliveryStatus: deliveryStatus.value,
        ),
      );

      if (response.status.isSuccess) {
        return;
      }
      log('Error updating delivery status: ${response.devMessage}');
      throw response.message ?? 'Failed to update delivery status';
    } catch (e, stack) {
      log('Error updating delivery status: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Fetch bookings list with pagination support
  @override
  Future<PaginationModel<BookingEntity>> loadBookingsPagination({
    required LoadBookingType status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
    String? nextPageUrl,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchBookingsPagination(
          status: status,
          page: page,
          startDate: startDate,
          endDate: endDate,
          searchQuery: searchQuery,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel.fromJson(
          response.data,
          (json) =>
              BookingsModel.fromJson(json as Map<String, dynamic>).toEntity(),
          customJsonParser: (dataJson, itemFromJson) =>
              (dataJson as List<dynamic>?)
                  ?.map((item) => itemFromJson(item))
                  .toList() ??
              <BookingEntity>[],
        );
      }
      log('Error fetching bookings pagination: ${response.devMessage}');
      throw response.message ?? 'Failed to fetch bookings';
    } catch (e, stack) {
      log('Error fetching bookings pagination: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Fetch desktop bookings list with pagination support and status counts
  @override
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
    String? purchaseMode,
    int page = 1,
    String? nextPageUrl,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchDesktopBookingsPagination(
          status: status,
          page: page,
          startDate: startDate,
          endDate: endDate,
          searchQuery: searchQuery,
          purchaseMode: purchaseMode,
          nextPageUrl: nextPageUrl,
        ),
      );
      if (response.status.isSuccess) {
        final pagination = PaginationModel.fromJson(
          response.data,
          (json) => DesktopBookingItemModel.fromJson(
            json as Map<String, dynamic>,
          ).toEntity(),
          customJsonParser: (dataJson, itemFromJson) {
            // dataJson is already the List of bookings from json['data']
            final dataList = dataJson as List<dynamic>?;
            return dataList
                    ?.map((item) => itemFromJson(item))
                    .toList()
                    .cast<DesktopBookingItemEntity>() ??
                <DesktopBookingItemEntity>[];
          },
        );

        final statusCountsJson = response.data['status_counts'];
        final statusCounts = statusCountsJson != null
            ? StatusCountsModel.fromJson(
                statusCountsJson as Map<String, dynamic>,
              ).toEntity()
            : null;

        return (pagination: pagination, statusCounts: statusCounts);
      }
      log('Error fetching desktop bookings pagination: ');
      throw response.message ?? 'Failed to fetch desktop bookings';
    } catch (e, stack) {
      log('Error fetching desktop bookings pagination: ', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<String> downloadBookingInvoice({
    required int bookingId,
    required String fileName,
  }) async {
    try {
      String filePath;

      if (kIsWeb) {
        // For web, we don't need to save to filesystem
        // Just return a temporary path identifier
        filePath = '/temp/$fileName.pdf';
      } else {
        // For mobile/desktop, use path_provider
        final dir = await getTemporaryDirectory();
        filePath = '${dir.path}/$fileName.pdf';
      }

      final response = await safeApiCall(
        () => _datasource.downloadBookingInvoice(
          bookingId: bookingId,
          filePath: filePath,
        ),
      );
      if (response != null) {
        log('Download Booking Invoice Error: ${response.devMessage}');
        throw response.message ?? 'Failed to download invoice';
      }
      return filePath;
    } catch (e, stack) {
      log('Error downloading booking invoice: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Future<PaginationModel<BookingsModel>> searchBookings(
  //   String query, {
  //   required int page,
  //   String? startDate,
  //   String? endDate,
  //   String status = 'all',
  // }) async {
  //   try {
  //     final response = await safeApiCall(
  //       () => _searchService.searchAllBookings(
  //         query,
  //         page: page,
  //         status: status,
  //         startDate: startDate,
  //         endDate: endDate,
  //       ),
  //     );
  //     if (response.status.isSuccess) {
  //       return PaginationModel.fromJson(
  //         response.data,
  //         (json) => BookingsModel.fromJson(json as Map<String, dynamic>),
  //         customJsonParser: (dataJson, itemFromJson) =>
  //             (dataJson as List<dynamic>?)
  //                 ?.map((item) => itemFromJson(item))
  //                 .toList() ??
  //             <BookingsModel>[],
  //       );
  //     }
  //     log('Error searching bookings: ${response.devMessage}');
  //     throw response.message ?? 'Failed to complete operation';
  //   } catch (e, stack) {
  //     log('Error searching bookings: $e', stackTrace: stack);
  //     rethrow;
  //   }
  // }

  @override
  Future<List<BookingPaymentHistoryEntity>> getPaymentHistory(
    int bookingId,
  ) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchPaymentHistory(bookingId),
      );
      if (response.status.isSuccess) {
        final paymentData =
            (response.data as Map<String, dynamic>)['payments']
                as List<dynamic>;
        return paymentData
            .map(
              (e) => BookingDetailsPaymentHistoryModel.fromJson(e).toEntity(),
            )
            .toList();
      }
      log('Error fetching payment history: ${response.devMessage}');
      throw response.message ?? 'Failed to fetch payment history';
    } catch (e, stack) {
      log('Error fetching payment history: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Send invoice to WhatsApp and return the response
  @override
  Future<void> sendInvoice(int bookingId, bool sendWhatsApp) async {
    try {
      final response = await safeApiCall(
        () => _datasource.sendInvoice(
          bookingId: bookingId,
          sendWhatsApp: sendWhatsApp,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error sending invoice: ${response.devMessage}');
      throw response.message ?? 'Failed to send invoice';
    } catch (e, stack) {
      log('Error sending invoice: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get invoice PDF bytes for viewing/downloading
  @override
  Future<Uint8List> getInvoicePdfBytes(int bookingId) async {
    try {
      return await _datasource.getInvoicePdfBytes(bookingId);
    } catch (e, stack) {
      log('Error getting invoice PDF: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> addRefund({
    required int bookingId,
    required int amount,
    required int accountId,
    String? refundReason,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.addRefund(
          bookingId: bookingId,
          amount: amount,
          accountId: accountId,
          refundReason: refundReason,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error adding refund: ${response.devMessage}');
      throw response.message ?? 'Failed to add refund';
    } catch (e, stack) {
      log('Error adding refund: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> deleteRefund({
    required int bookingId,
    required int refundId,
  }) async {
    try {
      final response = await safeApiCall(
        () =>
            _datasource.deleteRefund(bookingId: bookingId, refundId: refundId),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error deleting refund: ${response.devMessage}');
      throw response.message ?? 'Failed to delete refund';
    } catch (e, stack) {
      log('Error deleting refund: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateSecurityRefund({
    required int bookingId,
    int? refundAmount,
    int? deductionAmount,
    required int accountId,
    String? note,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateSecurityRefund(
          bookingId: bookingId,
          refundAmount: refundAmount,
          deductionAmount: deductionAmount,
          accountId: accountId,
          note: note,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating security refund: ${response.devMessage}');
      throw response.message ?? 'Failed to update security refund';
    } catch (e, stack) {
      log('Error updating security refund: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> deleteSecurityRefundedPayment({required int refundId}) async {
    try {
      final response = await safeApiCall(
        () => _datasource.deleteSecurityRefundedPayment(refundId: refundId),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error deleting security refunded payment: ${response.devMessage}');
      throw response.message ?? 'Failed to delete security refunded payment';
    } catch (e, stack) {
      log('Error deleting security refunded payment: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<CustomResponseModel> updatePartialReturn({
    required int bookingId,
    required List<int> returnedProductIds,
    required List<int> notReturnedProductIds,
    required String? newReturnDate,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updatePartialReturn(
          bookingId: bookingId,
          returnedProductIds: returnedProductIds,
          notReturnedProductIds: notReturnedProductIds,
          newReturnDate: newReturnDate,
        ),
      );
      if (response.status.isSuccess || response.status.isInsufficientStock) {
        return response;
      }
      log('Error updating partial return: ${response.devMessage}');
      throw response.message ?? 'Failed to update partial return';
    } catch (e, stack) {
      log('Error updating partial return: $e', stackTrace: stack);
      rethrow;
    }
  }
}
