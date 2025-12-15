import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_other_details_model/booking_other_details_model.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_booking_model.freezed.dart';
part 'request_booking_model.g.dart';

Map<String, dynamic>? _clientToJson(ClientRequestModel? client) =>
    client?.toCustomJson() ?? null;

List<Map<String, dynamic>>? _productsToJson(
  List<ProductSelectedModel>? products,
) =>
    products?.map((e) => e.toCustomJson()).toList();

@freezed
class RequestBookingModel with _$RequestBookingModel {
  @JsonSerializable(includeIfNull: false)
  const factory RequestBookingModel({
    @JsonKey(name: 'client_id') int? clientId,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
    ClientRequestModel? client,
    @JsonKey(name: 'client_address') String? address,
    @JsonKey(name: 'booked_date') String? bookedDate,
    @JsonKey(name: 'pickup_date') String? pickupDate,
    @JsonKey(name: 'return_date') String? returnDate,
    @JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,
    @JsonKey(name: 'advance_amount') int? advanceAmount,
    @JsonKey(name: 'security_amount') int? securityAmount,
    @JsonKey(name: 'discount_amount') int? discountAmount,
    @JsonKey(name: 'purchase_mode') String? purchaseMode,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'payment_method')
    PaymentMethod? paymentMethod,
    @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
    DeliveryStatus? deliveryStatus,
    @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
    BookingStatus? bookingStatus,
    @JsonKey(name: 'variants', toJson: _productsToJson)
    List<ProductSelectedModel>? products,
    @JsonKey(name: 'details') BookingOtherDetailsModel? otherDetails,
    @JsonKey(name: 'additional_charges')
    List<AdditionalChargesModel>? additionalCharges,
    @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
    int? serviceId,
    @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
    TimeOfDay? pickupTime,
    @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
    TimeOfDay? returnTime,
    @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
    @Default(false)
    bool sendPdfToWhatsApp,
  }) = _RequestBookingModel;

  factory RequestBookingModel.fromJson(Map<String, dynamic> json) =>
      _$RequestBookingModelFromJson(json);
}

extension RequestBookingModelX on RequestBookingModel {
  bool get hasChanges =>
      clientId != null ||
      staffId != null ||
      address != null ||
      bookedDate != null ||
      pickupDate != null ||
      returnDate != null ||
      coolingPeriodDate != null ||
      advanceAmount != null ||
      securityAmount != null ||
      discountAmount != null ||
      purchaseMode != null ||
      description != null ||
      paymentMethod != null ||
      deliveryStatus != null ||
      bookingStatus != null ||
      (products != null && products!.isNotEmpty) ||
      otherDetails != null ||
      (additionalCharges != null && additionalCharges!.isNotEmpty);
}
