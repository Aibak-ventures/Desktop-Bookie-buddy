import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_other_details_model/booking_other_details_model.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/security_summary_model/security_summary_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/client/data/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_model.freezed.dart';
part 'booking_details_model.g.dart';

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
    @JsonKey(name: 'cooling_period_type') String? coolingPeriodType,
    @JsonKey(name: 'total_amount') required int totalAmount,
    int? discountAmount,
    @JsonKey(name: 'advance_amount') required int paidAmount,
    @JsonKey(name: 'total_amount_with_security') int? totalAmountWithSecurity,
    @JsonKey(name: 'advance_amount_with_security') int? paidAmountWithSecurity,
    int? securityAmount,
    @JsonKey(
      fromJson: PurchaseMode.fromString,
      defaultValue: PurchaseMode.normal,
    )
    required PurchaseMode purchaseMode,
    @JsonKey(
      fromJson: BookingStatus.fromString,
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
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked,
    )
    required DeliveryStatus deliveryStatus,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'staff_id') int? staffId,
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
    @Default([]) List<dynamic> refunds,
    @JsonKey(name: 'total_refunded') @Default(0.0) double totalRefunded,
    @JsonKey(name: 'refundable_balance') @Default(0.0) double refundableBalance,
    @JsonKey(name: 'security_summary')
    @Default(SecuritySummaryModel.empty)
    SecuritySummaryModel securitySummary,
    @JsonKey(name: 'security_account_name') String? securityAccountName,
    @JsonKey(name: 'security_account_id') int? securityAccountId,
  }) = _BookingDetailsModel;

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailsModelFromJson(json);
}

extension BookingDetailsModelMapper on BookingDetailsModel {
  BookingDetailsEntity toEntity() => BookingDetailsEntity(
    id: id,
    invoiceId: invoiceId,
    pickupDate: pickupDate,
    returnDate: returnDate,
    pickupTime: pickupTime,
    returnTime: returnTime,
    coolingPeriodDate: coolingPeriodDate,
    coolingPeriodType: otherDetails.coolingPeriodType,
    totalAmount: totalAmount,
    discountAmount: discountAmount,
    paidAmount: paidAmount,
    securityAmount: securityAmount,
    purchaseMode: purchaseMode,
    bookingStatus: bookingStatus,
    paymentStatus: paymentStatus,
    paidAmountWithSecurity: paidAmountWithSecurity,
    totalAmountWithSecurity: totalAmountWithSecurity,
    deliveryStatus: deliveryStatus,
    staffName: staffName,
    staffId: staffId,
    otherDetails: otherDetails.toEntity(),
    bookedDate: bookedDate,
    bookingCompletedDate: bookingCompletedDate,
    address: address,
    client: client.toEntity(),
    description: description,
    documents: documents,
    bookedItems: bookedItems.map((e) => e.toEntity()).toList(),
    additionalCharges: additionalCharges.map((e) => e.toEntity()).toList(),
    payments: payments.map((e) => e.toEntity()).toList(),
    refunds: refunds,
    totalRefunded: totalRefunded,
    refundableBalance: refundableBalance,
    securitySummary: securitySummary.toEntity(),
    securityAccountId: securityAccountId,
    securityAccountName: securityAccountName,
  );
}
