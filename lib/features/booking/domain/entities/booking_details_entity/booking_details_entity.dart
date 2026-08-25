import 'package:bookie_buddy_core/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_other_details_entity/booking_other_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/security_summary_entity/security_summary_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_security_refund_history_entity/booking_security_refund_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_security_payment_entity/booking_security_payment_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_entity.freezed.dart';

@freezed
abstract class BookingDetailsEntity with _$BookingDetailsEntity {
  const factory BookingDetailsEntity({
    required int id,
    required String invoiceId,
    required String? pickupDate,
    required String returnDate,
    String? pickupTime,
    String? returnTime,
    String? coolingPeriodDate,
    CoolingPeriodMode? coolingPeriodType,
    required int totalAmount,
    required int totalPayable,
    required int balanceAmount,
    int? discountAmount,
    required int paidAmount,
    int? securityAmount,
    int? totalAmountWithSecurity,
    int? paidAmountWithSecurity,
    String? securityAccountName,
    int? securityAccountId,
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
    required List<ProductInfoEntity> bookedItems,
    @Default([]) List<AdditionalChargesEntity> additionalCharges,
    @Default([]) List<BookingPaymentHistoryEntity> payments,
    @Default([]) List<dynamic> refunds,
    @Default(0.0) double totalRefunded,
    @Default(0.0) double refundableBalance,
    @Default(SecuritySummaryEntity.empty) SecuritySummaryEntity securitySummary,
    @Default([])
    List<BookingSecurityRefundHistoryEntity> securityTransactionHistory,
    @Default(false) bool isSecurityPaid,
    BookingSecurityPaymentEntity? securityPayment,
    @Default([]) List<AppliedTaxEntity> appliedTaxes,
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

  /// Whether the security deposit should be surfaced inside the normal
  /// payment details section instead of the dedicated security refund
  /// section — true only while the booking is still active, i.e. items
  /// haven't been returned or cancelled yet. Once items are returned (or
  /// the booking is cancelled), the deposit needs to be refunded/deducted,
  /// so it always moves to the dedicated security refund section — even if
  /// nothing has been refunded/deducted yet.
  bool get showSecurityInPayments {
    if (securitySummary.securityAmount <= 0) return false;

    // Only show the security deposit if the booking is still active
    return deliveryStatus != DeliveryStatus.cancelled &&
        deliveryStatus != DeliveryStatus.returned;
  }

  /// Whether the dedicated security refund/deduction section should render.
  bool get showSecurityRefundSection =>
      !showSecurityInPayments && isSecurityPaid;
}
