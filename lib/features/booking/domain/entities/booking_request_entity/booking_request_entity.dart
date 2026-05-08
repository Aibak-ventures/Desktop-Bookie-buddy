import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_other_details_entity/booking_other_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_request_entity/booking_payment_request_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_request_entity.freezed.dart';

@freezed
abstract class BookingRequestEntity with _$BookingRequestEntity {
  const factory BookingRequestEntity({
    int? clientId,
    int? staffId,
    ClientRequestEntity? client,
    String? address,
    String? bookedDate,
    String? pickupDate,
    String? returnDate,
    String? coolingPeriodDate,
    int? advanceAmount,
    int? securityAmount,
    int? discountAmount,
    String? purchaseMode,
    String? description,
    DeliveryStatus? deliveryStatus,
    BookingStatus? bookingStatus,
    List<ProductSelectedEntity>? products,
    BookingOtherDetailsEntity? otherDetails,
    List<AdditionalChargesEntity>? additionalCharges,
    int? serviceId,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
    @Default(false) bool sendPdfToWhatsApp,
    String? runningKilometers,
    String? coolingPeriodType,
    int? securityPaymentAccountId,
    List<BookingPaymentRequestEntity>? payments,
    int? oldBookingAccountId,
  }) = _BookingRequestEntity;
}

extension BookingRequestEntityX on BookingRequestEntity {
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
      securityPaymentAccountId != null ||
      deliveryStatus != null ||
      bookingStatus != null ||
      (products != null && products!.isNotEmpty) ||
      otherDetails != null ||
      (additionalCharges != null && additionalCharges!.isNotEmpty);
}
