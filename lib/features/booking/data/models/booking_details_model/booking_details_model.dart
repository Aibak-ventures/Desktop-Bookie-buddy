import 'package:bookie_buddy_web/core/common/models/applied_tax_model/applied_tax_model.dart';
import 'package:bookie_buddy_core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_core/core/constants/enums/booking_rental_unit_enum.dart';
import 'package:bookie_buddy_core/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_other_details_model/booking_other_details_model.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/security_summary_model/security_summary_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/client/data/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_details_refund_history_model/booking_details_refund_history_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_details_security_refund_history_model/booking_details_security_refund_history_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_security_payment_model/booking_security_payment_model.dart';
import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_model.freezed.dart';
part 'booking_details_model.g.dart';

// The `refunds` JSON array has never actually been exercised — nothing
// parsed it before this. Field names below match
// BookingDetailsRefundHistoryModel's existing (also-never-verified) shape;
// if the backend's real keys differ, this comes back empty rather than
// throwing (see the try/catch), a safe failure to notice and fix later
// rather than crashing the booking-details screen. Logged so a shape
// mismatch leaves a trace instead of just silently showing "no refunds".
List<BookingDetailsRefundHistoryModel> _refundsFromJson(List? json) {
  if (json == null) return const [];
  return json
      .whereType<Map<String, dynamic>>()
      .map((e) {
        try {
          return BookingDetailsRefundHistoryModel.fromJson(e);
        } catch (error, stackTrace) {
          log(
            'Failed to parse a refund history entry — check it against '
            "BookingDetailsRefundHistoryModel's expected JSON keys: $e",
            error: error,
            stackTrace: stackTrace,
            name: 'BookingDetailsModel',
          );
          return null;
        }
      })
      .whereType<BookingDetailsRefundHistoryModel>()
      .toList();
}

@freezed
abstract class BookingDetailsModel with _$BookingDetailsModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BookingDetailsModel({
    required int id,
    @JsonKey(name: 'shop_booking_id') required String invoiceId,
    required String? pickupDate,
    required String returnDate,
    @JsonKey(name: 'pickup_time') String? pickupTime,
    @JsonKey(name: 'return_time') String? returnTime,
    @JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,
    // Unused by toEntity() below — otherDetails.coolingPeriodType is the
    // one actually wired to the entity, same as before this migration.
    // Left in place since it's harmless and removing a JSON field is a
    // separate, unrelated change.
    @JsonKey(name: 'cooling_period_type') String? coolingPeriodType,
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'total_payable') int? totalPayable,
    @JsonKey(name: 'balance', defaultValue: 0) required int balanceAmount,
    int? discountAmount,
    @JsonKey(name: 'advance_amount') required int paidAmount,
    @JsonKey(name: 'total_amount_with_security') int? totalAmountWithSecurity,
    @JsonKey(name: 'advance_amount_with_security') int? paidAmountWithSecurity,
    int? securityAmount,
    @JsonKey(
      fromJson: PurchaseMode.fromJson,
      toJson: PurchaseMode.toJson,
      defaultValue: PurchaseMode.normal,
    )
    required PurchaseMode purchaseMode,
    @JsonKey(
      fromJson: BookingStatus.fromJson,
      toJson: BookingStatus.toJson,
      defaultValue: BookingStatus.upcoming,
    )
    required BookingStatus bookingStatus,
    @JsonKey(
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson,
      defaultValue: PaymentStatus.pending,
    )
    required PaymentStatus paymentStatus,
    @JsonKey(
      fromJson: DeliveryStatus.fromJson,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked,
    )
    required DeliveryStatus deliveryStatus,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'staff_id') int? staffId,
    // A json field that store frontend defined fields. mainly to store extra details
    @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
    required BookingOtherDetailsModel otherDetails,
    @JsonKey(name: 'created_at') required String bookedDate,
    @JsonKey(name: 'completed_at') String? bookingCompletedDate,
    @JsonKey(name: 'client_address') String? address,
    required ClientModel client,
    String? description,
    @Default([]) List<dynamic> documents,
    required List<ProductInfoModel> bookedItems,
    @JsonKey(name: 'additional_charges')
    @Default([])
    List<AdditionalChargesModel> additionalCharges,
    @JsonKey(name: 'payments')
    @Default([])
    List<BookingDetailsPaymentHistoryModel> payments,
    @JsonKey(name: 'refunds', fromJson: _refundsFromJson)
    @Default([])
    List<BookingDetailsRefundHistoryModel> refunds,
    @JsonKey(name: 'total_refunded') @Default(0.0) double totalRefunded,
    @JsonKey(name: 'refundable_balance') @Default(0.0) double refundableBalance,
    @JsonKey(name: 'security_summary')
    @Default(SecuritySummaryModel.empty)
    SecuritySummaryModel securitySummary,
    @JsonKey(name: 'security_adjustments')
    @Default([])
    List<BookingDetailsSecurityRefundHistoryModel> securityTransactionHistory,
    @JsonKey(name: 'security_amount_is_paid')
    @Default(false)
    bool isSecurityPaid,
    @JsonKey(name: 'security') BookingSecurityPaymentModel? securityPayment,
    @JsonKey(name: 'security_account_name') String? securityAccountName,
    @JsonKey(name: 'security_account_id') int? securityAccountId,
    // API currently sends a single `tax` object; modeled as a list so that
    // if the backend later sends multiple applied taxes, only
    // AppliedTaxModel.listFromJson needs to change — the entity and every
    // screen that reads `appliedTaxes` already iterate a list.
    @JsonKey(name: 'tax', fromJson: AppliedTaxModel.listFromJson)
    @Default([])
    List<AppliedTaxModel> appliedTaxes,
  }) = _BookingDetailsModel;

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailsModelFromJson(json);
}

extension BookingDetailsModelMapper on BookingDetailsModel {
  // securityAmount/securityAccountName/securityAccountId (the flat fields
  // above) aren't on the shared entity — mobile already gets the same data
  // via securityPayment.amount/accountName, so this maps there instead of
  // extending the entity for something redundant. See
  // docs/shared-packages-plan.md in the mobile repo.
  BookingDetailsEntity toEntity() => BookingDetailsEntity(
    id: id,
    invoiceId: invoiceId,
    // No separate concept on web — reuse bookedDate, same as mobile's own
    // model does when its `created_at`/`recorded_at` distinction collapses.
    createdAt: bookedDate,
    pickupDate: pickupDate,
    returnDate: returnDate,
    pickupTime: pickupTime,
    returnTime: returnTime,
    coolingPeriodDate: coolingPeriodDate,
    coolingPeriodType: otherDetails.coolingPeriodType,
    totalAmount: totalAmount,
    totalAmountWithSecurity: totalAmountWithSecurity ?? totalAmount,
    totalPayable: totalPayable ?? totalAmount,
    balanceAmount: balanceAmount,
    discountAmount: discountAmount,
    paidAmount: paidAmount,
    paidAmountWithSecurity: paidAmountWithSecurity ?? paidAmount,
    purchaseMode: purchaseMode,
    bookingStatus: bookingStatus,
    paymentStatus: paymentStatus,
    deliveryStatus: deliveryStatus,
    staffName: staffName,
    staffId: staffId,
    otherDetails: otherDetails.toEntity(),
    bookedDate: bookedDate,
    bookingCompletedDate: bookingCompletedDate,
    address: address,
    client: client.toEntity(),
    description: description,
    documents: documents.map((e) => e.toString()).toList(),
    bookedItems: bookedItems.map((e) => e.toEntity()).toList(),
    additionalCharges: additionalCharges.map((e) => e.toEntity()).toList(),
    paymentHistory: payments.map((e) => e.toEntity()).toList(),
    refundHistory: refunds.map((e) => e.toEntity()).toList(),
    refundTotal: totalRefunded.round(),
    refundableBalance: refundableBalance.round(),
    securityTransactionSummary: securitySummary.toEntity(),
    securityTransactionHistory: securityTransactionHistory
        .map((e) => e.toEntity())
        .toList(),
    isSecurityPaid: isSecurityPaid,
    securityPayment: securityPayment?.toEntity(),
    // Web has no rental-unit concept (see ProductInfoEntity's
    // hourlyRentPrice/deliveryStatus vs. stock/remainingStock split) —
    // .daily is the same default mobile itself falls back to when absent.
    rentalUnit: BookingRentalUnit.daily,
    // Web has no document-upload concept on bookings yet.
    documentsDetails: null,
    appliedTaxes: appliedTaxes.map((e) => e.toEntity()).toList(),
  );
}
