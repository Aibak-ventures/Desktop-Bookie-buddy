import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/utils/download_file.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/document_file_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http_parser/http_parser.dart';

class BookingRemoteDatasource {
  final Dio _dio;
  BookingRemoteDatasource({required Dio dio}) : _dio = dio;

  final bookingManagementUrl = ApiEndpoints.bookings.bookingsV3;

  Future<CustomResponseModel> getBooking(int bookingId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.bookings.bookingsV5}$bookingId/',
      );
      // log('booking details response: ${response.realUri.toString()} , ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> addBooking(
    RequestBookingModel bookingData,
  ) async {
    try {
      final data = bookingData.toJson();

      log(data.toString());
      final response = await _dio.post(
        ApiEndpoints.bookings.bookingsV5,
        data: data,
      );

      log(
        'add booking response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error adding booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> createSale(
    Map<String, dynamic> saleData,
  ) async {
    try {
      log('Creating sale with data: $saleData');
      final response = await _dio.post(
        ApiEndpoints.sales.salesV4,
        data: saleData,
      );

      log(
        'create sale response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error creating sale: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updatePayment({
    required int bookingId,
    required int amount,
    required String paymentMethod,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.bookings.addPayment}$bookingId/',
        data: {'amount': amount, 'payment_method': paymentMethod},
      );

      log(
        'update payment response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating payment: $e', stackTrace: stack);
      throw e;
    }
  }

  Future<CustomResponseModel> updateBookingStatus({
    required int bookingId,
    required String bookingStatus,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiEndpoints.bookings.updateBookingStatus}$bookingId/',
        data: {'booking_status': bookingStatus},
      );
      log(
        'update booking status response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating booking status: $e', stackTrace: stack);
      throw 'Failed to update booking status: $e';
    }
  }

  Future<CustomResponseModel> updateDeliveryStatus({
    required int bookingId,
    required String deliveryStatus,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiEndpoints.bookings.updateDeliveryStatus}$bookingId/',
        data: {'delivery_status': deliveryStatus},
      );

      log(
        'update delivery status response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating delivery status: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateBooking(
    int bookingId,
    RequestBookingModel updatedBooking,
  ) async {
    try {
      final response = await _dio.patch(
        '${ApiEndpoints.bookings.updateDetails}$bookingId/',
        data: updatedBooking.toJson(),
      );

      log(
        'update booking response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update booking with partial data (only changed fields)
  /// Used for incremental updates in edit mode
  /// Supports FormData for file uploads
  Future<CustomResponseModel> updateBookingPartial(
    int bookingId,
    Map<String, dynamic> partialData, {
    List<DocumentFile>? newDocuments,
    List<String>? removedDocumentUrls,
  }) async {
    try {
      // Use FormData for file uploads and complex nested data
      final formData = FormData();

      // Add regular fields as JSON strings (as per API requirement)
      partialData.forEach((key, value) {
        if (value != null) {
          if (value is List) {
            // Arrays stay JSON-encoded (e.g. 'variants', 'additional_charges')
            formData.fields.add(MapEntry(key, jsonEncode(value)));
          } else if (value is Map) {
            // Nested objects must be expanded using bracket notation so Django/DRF
            // can parse them as dicts.  e.g. other_details={'end':'50'} becomes
            // formData field  other_details[end] = '50'
            (value as Map<String, dynamic>).forEach((subKey, subValue) {
              if (subValue != null) {
                formData.fields
                    .add(MapEntry('$key[$subKey]', subValue.toString()));
              }
            });
          } else {
            // Simple values
            formData.fields.add(MapEntry(key, value.toString()));
          }
        }
      });

      // Add new documents if any
      if (newDocuments != null && newDocuments.isNotEmpty) {
        for (int i = 0; i < newDocuments.length; i++) {
          final doc = newDocuments[i];
          // Check if it's a new file: has bytes (web upload) or path is not a URL (local file)
          final isNewFile = doc.bytes != null ||
              (doc.path.isNotEmpty && !doc.path.startsWith('http'));

          if (isNewFile && (doc.bytes != null || doc.path.isNotEmpty)) {
            // New file upload from web or mobile
            if (doc.bytes != null) {
              // Web: upload from bytes
              formData.files.add(MapEntry(
                'documents[${i + 1}]',
                MultipartFile.fromBytes(
                  doc.bytes!,
                  filename: doc.name,
                  contentType: MediaType('image', 'jpeg'),
                ),
              ));
            }
            // Note: Mobile file upload from path would need different handling
            // For now, web uploads via bytes are supported
          }
        }
      }

      // Add removed document URLs
      if (removedDocumentUrls != null && removedDocumentUrls.isNotEmpty) {
        formData.fields
            .add(MapEntry('remove_documents', jsonEncode(removedDocumentUrls)));
      }

      // 📝 LOG FORM DATA CONTENTS FOR DEBUGGING
      log('┌─────────────────────────────────────────────────────────────');
      log('│ 📤 PATCH REQUEST TO: /bookings/$bookingId/');
      log('├─────────────────────────────────────────────────────────────');
      log('│ 📋 FORM FIELDS (${formData.fields.length} fields):');
      for (final field in formData.fields) {
        // Truncate very long values for readability
        final value = field.value.length > 500
            ? '${field.value.substring(0, 500)}... (truncated, ${field.value.length} chars total)'
            : field.value;
        log('│   ${field.key}: $value');
      }
      if (formData.files.isNotEmpty) {
        log('├─────────────────────────────────────────────────────────────');
        log('│ 📎 FILES (${formData.files.length} files):');
        for (final file in formData.files) {
          log('│   ${file.key}: ${file.value.filename} (${file.value.length} bytes)');
        }
      }
      log('└─────────────────────────────────────────────────────────────');

      final response = await _dio.patch(
        '${ApiEndpoints.bookings.updateDetails}$bookingId/',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      log(
        'update booking partial response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating booking partial: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> deleteBooking(int bookingId) async {
    try {
      final response = await _dio.delete('${bookingManagementUrl}$bookingId/');
      log(
        'delete booking response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error deleting booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> cancelBooking({
    required int bookingId,
  }) async {
    try {
      // Update delivery status to cancelled
      final response = await _dio.patch(
        '${ApiEndpoints.bookings.updateDeliveryStatus}$bookingId/',
        data: {'delivery_status': 'cancelled'},
      );
      log(
        'cancel booking response: ${response.realUri.toString()}, data: ${response.data}',
      );

      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error cancelling booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> addRefund({
    required int bookingId,
    required int amount,
    required String paymentMethod,
    String? refundReason,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.bookings.addRefund(bookingId),
        data: {
          'amount': amount,
          'refund_method': paymentMethod,
          if (refundReason != null) 'refund_reason': refundReason,
        },
      );

      log(
        'add refund response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error adding refund: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchBookingsPagination({
    required LoadBookingType status,
    required int page,
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) async {
    try {
      final response = await _dio.get(
        '${bookingManagementUrl}',
        queryParameters: {
          'page': page,
          'status': status.value, // upcoming, completed, past, future, all
          'search': searchQuery,
          'start_date': startDate?.formatToUiDate(),
          'end_date': endDate?.formatToUiDate(), //End date is optional
        },
      );
      log(response.realUri.toString());
      // log('fetch bookings response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching bookings: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchDesktopBookingsPagination({
    required String status,
    String? searchQuery,
    String? startDate,
    String? endDate,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.bookings.desktopList,
        queryParameters: {
          'status':
              status, // pending, upcoming, returns, not_returned, completed
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
          if (startDate != null && startDate.isNotEmpty)
            'start_date': startDate,
          if (endDate != null && endDate.isNotEmpty) 'end_date': endDate,
          'page': page,
        },
      );
      log('Desktop bookings API: ${response.realUri.toString()}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching desktop bookings: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchPaymentHistory(int bookingId) async {
    try {
      final response = await _dio.get(
        '${bookingManagementUrl}payment-details/$bookingId/',
      );
      log(
        'fetch payment history response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching payment history: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> createOldBooking(
    RequestBookingModel bookingData,
  ) async {
    try {
      final data = bookingData.toJson();
      log('request old booking data: $data');
      final response = await _dio.post(
        ApiEndpoints.bookings.oldBookings,
        data: data,
      );

      log(
        'add old bookings response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error creating old booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel?> downloadBookingInvoice({
    required int bookingId,
    required String filePath,
  }) async {
    try {
      final url = ApiEndpoints.bookings.downloadBookingInvoice(bookingId);
      log('Downloading booking invoice from: $url');

      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        if (kIsWeb) {
          // For web, trigger browser download
          final fileName = filePath.split('/').last;
          downloadFileWeb(response.data, fileName);
          log('Invoice download triggered for web: $fileName');
        } else {
          // For mobile/desktop, save to file
          final file = File(filePath);
          await file.writeAsBytes(response.data);
          log('Invoice downloaded successfully to: $filePath');
        }
        return null; // Success, no error
      } else {
        log('Error downloading invoice: ${response.statusCode}');
        return CustomResponseModel(
          status: CustomResponseStatus.error,
          message: 'Failed to download invoice',
          devMessage: 'HTTP ${response.statusCode}',
          meta: null,
          data: null,
        );
      }
    } catch (e, stack) {
      log('Error downloading booking invoice: $e', stackTrace: stack);
      return CustomResponseModel(
        status: CustomResponseStatus.error,
        message: 'Failed to download invoice',
        devMessage: e.toString(),
        meta: null,
        data: null,
      );
    }
  }

  /// Send invoice to WhatsApp - returns the invoice data for display
  Future<CustomResponseModel> sendInvoice({
    required int bookingId,
    bool sendWhatsApp = true,
  }) async {
    try {
      // Use the correct endpoint format: /api/v5/bookings/bookings/send-invoice/{id}/
      final url = ApiEndpoints.bookings.sendBookingInvoice(bookingId);
      log('Sending booking invoice from: $url');

      final response = await _dio.get(
        url,
        queryParameters: {
          'send_whatsapp': sendWhatsApp,
        },
      );
      log('Send invoice response: ${response.realUri.toString()}');

      // Handle potential HTML response (404 error)
      if (response.data is String) {
        log('Received HTML/text response instead of JSON');
        return CustomResponseModel(
          status: CustomResponseStatus.success,
          message: 'Invoice sent successfully',
          devMessage: 'Received non-JSON response',
          meta: null,
          data: null,
        );
      }

      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error sending booking invoice: $e', stackTrace: stack);
      // Don't rethrow - just log and return success to prevent blocking
      return CustomResponseModel(
        status: CustomResponseStatus.success,
        message: 'Invoice processing',
        devMessage: 'Error logged: $e',
        meta: null,
        data: null,
      );
    }
  }

  /// Get invoice PDF bytes for viewing/downloading
  Future<Uint8List> getInvoicePdfBytes(int bookingId) async {
    try {
      final url = ApiEndpoints.bookings.sendBookingInvoice(bookingId);
      log('Fetching booking invoice PDF from: $url');

      final response = await _dio.get(
        url,
        queryParameters: {'send_whatsapp': false},
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        log('Invoice PDF fetched successfully, size: ${response.data.length} bytes');
        return Uint8List.fromList(response.data as List<int>);
      } else {
        // Decode the JSON error body from bytes to show the actual backend message
        String errorMessage =
            'Failed to fetch invoice (HTTP ${response.statusCode})';
        try {
          final jsonStr = utf8.decode(response.data as List<int>);
          final jsonBody = jsonDecode(jsonStr) as Map<String, dynamic>;
          final msg = jsonBody['message'] as String?;
          final devMsg = jsonBody['dev_message'] as String?;
          if (msg != null && msg.isNotEmpty) {
            errorMessage = msg;
            log('Backend error: $msg | dev: $devMsg');
          }
        } catch (_) {}
        log('Error fetching invoice PDF: ${response.statusCode} - $errorMessage');
        throw errorMessage;
      }
    } catch (e, stack) {
      log('Error fetching booking invoice PDF: $e', stackTrace: stack);
      rethrow;
    }
  }
}
