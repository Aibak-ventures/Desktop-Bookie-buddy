import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/enums.dart';

part 'booking_details_model.freezed.dart';
// part 'booking_details_model.g.dart';

@freezed
class BookingDetailsModel with _$BookingDetailsModel {
  const factory BookingDetailsModel({
    required int id,
    required ClientModel client,
    required int totalAmount,
    required int paidAmount,
    required String invoiceId,
    int? securityAmount,
    int? discountAmount,
    required String? pickupDate,
    required String returnDate,
    required PurchaseMode purchaseMode,
    required BookingStatus bookingStatus,
    required bool paymentStatus,
    required String staffName,
    required String bookedDate,
    String? bookingCompletedDate,
    required List<ProductInfoModel> bookedItems,
    String? description,
    String? address,
    @Default(DeliveryStatus.booked) DeliveryStatus deliveryStatus,
    @Default(const {}) Map<String, dynamic> otherDetails,
  }) = _BookingDetailsModel;

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    final booking = json['booking'] ?? {};
    final bookedItemsJson = json['booked_items'] as List? ?? [];

    return BookingDetailsModel(
      id: booking['id'] ?? 0,
      client: ClientModel.fromJson(booking['client'] ?? {}),
      totalAmount: _getIntFromJson(booking['total_amount']),
      paidAmount: _getIntFromJson(booking['advance_amount']),
      invoiceId: booking['shop_booking_id'] ?? '',
      securityAmount: _getIntFromJson(booking['security_amount']),
      discountAmount: _getIntFromJson(booking['discount_amount']),
      pickupDate: booking['pickup_date'],
      returnDate: booking['return_date'] ?? '',
      purchaseMode: PurchaseMode.fromString(booking['purchase_mode']),
      bookingStatus:
          BookingStatus.fromString(booking['booking_status'] ?? 'upcoming'),
      paymentStatus: booking['payment_status'] ?? false,
      staffName: booking['staff_name'] ?? 'Not Added',
      bookedDate: booking['created_at'] ?? '',
      bookingCompletedDate: booking['completed_at'],
      bookedItems: bookedItemsJson
          .map((item) => ProductInfoModel.fromJson(item))
          .toList(),
      address: booking['client_address'],
      description: json['client_requirements']?['description'] ?? '',
      deliveryStatus:
          DeliveryStatus.fromString(booking['delivery_status'] ?? 'booked'),
      otherDetails: booking['details'] ?? {},
    );
  }

  // factory BookingDetailsModel.fromJsonAuto(Map<String, dynamic> json) =>
  //     _$BookingDetailsModelFromJson(json);

  static int _getIntFromJson(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    return 0;
  }
}
