import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_other_details_model/booking_other_details_model.dart';
import 'package:bookie_buddy_web/features/client/data/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_request_model.freezed.dart';
part 'booking_request_model.g.dart';

Map<String, dynamic>? _clientToJson(ClientRequestModel? client) =>
    client?.toCustomJson() ?? null;

List<Map<String, dynamic>>? _productsToJson(
  List<ProductSelectedModel>? products,
) => products?.map((e) => e.toCustomJson()).toList();

String? _pickupTimeToJson(TimeOfDay? time) => time?.formatToTime();

String? _returnTimeToJson(TimeOfDay? time) => time?.formatToTime();

@freezed
abstract class BookingRequestModel with _$BookingRequestModel {
  @JsonSerializable(includeIfNull: false)
  const factory BookingRequestModel({
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
    @JsonKey(name: 'payment_method') PaymentMethod? paymentMethod,
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
    @JsonKey(
      name: 'pickup_time',
      toJson: _pickupTimeToJson,
      includeFromJson: false,
    )
    TimeOfDay? pickupTime,
    @JsonKey(
      name: 'return_time',
      toJson: _returnTimeToJson,
      includeFromJson: false,
    )
    TimeOfDay? returnTime,
    @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
    @Default(false)
    bool sendPdfToWhatsApp,
    @JsonKey(name: 'cooling_period_type') String? coolingPeriodType,
    @JsonKey(name: 'security_payment_method')
    PaymentMethod? securityPaymentMethod,
  }) = _BookingRequestModel;

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestModelFromJson(json);

  factory BookingRequestModel.fromEntity(BookingRequestEntity entity) =>
      BookingRequestModel(
        clientId: entity.clientId,
        staffId: entity.staffId,
        client: entity.client != null
            ? ClientRequestModel.fromEntity(entity.client!)
            : null,
        address: entity.address,
        bookedDate: entity.bookedDate,
        pickupDate: entity.pickupDate,
        returnDate: entity.returnDate,
        coolingPeriodDate: entity.coolingPeriodDate,
        advanceAmount: entity.advanceAmount,
        securityAmount: entity.securityAmount,
        discountAmount: entity.discountAmount,
        purchaseMode: entity.purchaseMode,
        description: entity.description,
        paymentMethod: entity.paymentMethod,
        deliveryStatus: entity.deliveryStatus,
        bookingStatus: entity.bookingStatus,
        products: entity.products?.map((e) => e.toModel()).toList(),
        otherDetails: entity.otherDetails?.toModel(),
        additionalCharges: entity.additionalCharges
            ?.map((e) => e.toModel())
            .toList(),
        serviceId: entity.serviceId,
        pickupTime: entity.pickupTime,
        returnTime: entity.returnTime,
        sendPdfToWhatsApp: entity.sendPdfToWhatsApp,
        coolingPeriodType: entity.coolingPeriodType,
        securityPaymentMethod: entity.securityPaymentMethod,
      );
}

extension BookingRequestModelX on BookingRequestModel {
  /// Returns the full booking JSON with time embedded in date fields.
  /// - pickup_date default: 00:00, return_date default: 23:59 when no time selected
  /// - pickup_time / return_time sent as separate fields ONLY when user selected them
  ///
  /// Use this instead of `toJson()` when POSTing/PATCHing to the booking API.
  Map<String, dynamic> toBookingJson() {
    final json = toJson();

    if (pickupDate != null) {
      if (pickupTime != null) {
        json['pickup_date'] = pickupDate!.appendTimeToDate(time: pickupTime);
        json['pickup_time'] = _pickupTimeToJson(pickupTime);
      } else {
        json['pickup_date'] = pickupDate!.appendTimeToDate(time24HourAsString: '00:00:00');
        json.remove('pickup_time');
      }
    }

    if (returnDate != null) {
      if (returnTime != null) {
        json['return_date'] = returnDate!.appendTimeToDate(time: returnTime);
        json['return_time'] = _returnTimeToJson(returnTime);
      } else {
        json['return_date'] = returnDate!.appendTimeToDate(time24HourAsString: '23:59:00');
        json.remove('return_time');
      }
    }

    if (coolingPeriodDate != null) {
      final isBefore = coolingPeriodType == 'BEFORE';
      if (isBefore) {
        json['cooling_period_end'] = coolingPeriodDate!.appendTimeToDate(time24HourAsString: '00:00:00');
      } else if (returnTime != null) {
        json['cooling_period_end'] = coolingPeriodDate!.appendTimeToDate(time: returnTime);
      } else {
        json['cooling_period_end'] = coolingPeriodDate!.appendTimeToDate(time24HourAsString: '23:59:00');
      }
    }

    return json;
  }

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
