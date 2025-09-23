import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_booking_model.freezed.dart';
part 'add_booking_model.g.dart';

@freezed
class AddBookingModel with _$AddBookingModel {
  const factory AddBookingModel({
    @JsonKey(name: 'service_id') int? serviceId,
    @JsonKey(name: 'advance_amount') int? advanceAmount,
    @JsonKey(name: 'security_amount') int? securityAmount,
    @JsonKey(name: 'discount_amount') int? discountAmount,
    @JsonKey(name: 'sub_services') List<ProductSelectedModel>? products,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'booked_date') String? bookedDate,
    @JsonKey(name: 'event_date') String? pickupDate,
    @JsonKey(name: 'return_date') String? returnDate,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'purchase_mode') String? purchaseMode,
    @JsonKey(name: 'delivery_status') String? deliveryStatus,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'location_start') String? locationStart,
    @JsonKey(name: 'location_from') String? locationFrom,
    @JsonKey(name: 'location_to') String? locationTo,
    @JsonKey(name: 'client_address') String? address,
    @JsonKey(name: 'client_id') int? clientId,
    @JsonKey(name: 'booking_status') String? bookingStatus,
    @JsonKey(
      name: 'pickup_time',
      includeToJson: false,
      includeFromJson: false,
    )
    TimeOfDay? pickupTime,
    @JsonKey(
      name: 'return_time',
      includeToJson: false,
      includeFromJson: false,
    )
    TimeOfDay? returnTime,
  }) = _AddBookingModel;

  factory AddBookingModel.fromJson(Map<String, dynamic> json) =>
      _$AddBookingModelFromJson(json);
}

extension AddBookingModelX on AddBookingModel {
  Map<String, dynamic> toCustomJson() => {
        "client_id": clientId,
        if (bookedDate != null) "booked_date": bookedDate,
        "pickup_date": pickupDate,
        "return_date": returnDate,
        if (advanceAmount != null) "advance_amount": advanceAmount,
        if (securityAmount != null) "security_amount": securityAmount,
        if (discountAmount != null) "discount_amount": discountAmount,
        "purchase_mode": purchaseMode,
        if (staffName != null) "staff_name": staffName,
        "description": description,
        "payment_method": paymentMethod,
        "client_address": address,
        "delivery_status": deliveryStatus,
        if (bookingStatus != null) "booking_status": bookingStatus,
        "variants": products?.map((e) => e.toCustomJson()).toList(),
        "details": {
          //Location for vehicle
          if (locationFrom != null && locationFrom != '')
            "location_from": locationFrom,

          if (locationTo != null && locationTo != '') "location_to": locationTo,

          if (locationStart != null && locationStart != '')
            "location_start": locationStart
        }
      };
}
