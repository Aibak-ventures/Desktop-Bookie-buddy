import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_other_details_entity/booking_other_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/security_summary_entity/security_summary_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_info_model/product_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_entity.freezed.dart';

@freezed
abstract class BookingDetailsEntity with _$BookingDetailsEntity {
  const factory BookingDetailsEntity({
    required int id,
    required String invoiceId,
    required String? pickupDate,
    required String returnDate,
    String? coolingPeriodDate,
    required int totalAmount,
    int? discountAmount,
    required int paidAmount,
    int? securityAmount,
    required PurchaseMode purchaseMode,
    required BookingStatus bookingStatus,
    required PaymentStatus paymentStatus,
    required DeliveryStatus deliveryStatus,
    String? staffName,
    int? staffId,
    required BookingOtherDetailsEntity otherDetails,
    required String bookedDate,
    String? bookingCompletedDate,
    String? address,
    required ClientEntity client,
    String? description,
    @Default([]) List<dynamic> documents,
    required List<ProductInfoModel> bookedItems,
    @Default([]) List<AdditionalChargesEntity> additionalCharges,
    @Default([]) List<BookingPaymentHistoryEntity> payments,
    @Default([]) List<dynamic> refunds,
    @Default(0.0) double totalRefunded,
    @Default(0.0) double refundableBalance,
    @Default(SecuritySummaryEntity.empty) SecuritySummaryEntity securitySummary,
  }) = _BookingDetailsEntity;
}

extension BookingDetailsEntityX on BookingDetailsEntity {
  int get actualPaidAmount {
    if (payments.isEmpty) return paidAmount;
    return payments.fold<int>(0, (sum, payment) => sum + payment.amount);
  }

  double get remainingSecurityBalance => securitySummary.remainingBalance;

  double get totalSecurityDeducted => securitySummary.totalDeducted;

  double get totalSecurityRefunded => securitySummary.totalRefunded;

  bool get hasPartialSecurityRefund => securitySummary.totalDeducted > 0;

  int get netBalance {
    return totalAmount - actualPaidAmount - (discountAmount ?? 0);
  }
}
