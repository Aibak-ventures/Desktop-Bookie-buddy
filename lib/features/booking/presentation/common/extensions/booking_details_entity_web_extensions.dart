import 'package:bookie_buddy_shared/bookie_buddy_shared.dart';

// BookingDetailsEntity now comes from bookie_buddy_core (see
// docs/shared-packages-plan.md in the mobile repo). These getters were on
// web's own local entity file and have no mobile equivalent, so they stay
// here rather than moving into the shared package. Field names updated to
// match the shared entity: payments -> paymentHistory, securitySummary ->
// securityTransactionSummary (now int-based, matching every other amount
// on this entity, not double).
extension BookingDetailsEntityWebX on BookingDetailsEntity {
  int get actualPaidAmount {
    if (paymentHistory.isEmpty) return paidAmount;
    return paymentHistory.fold<int>(0, (sum, payment) => sum + payment.amount);
  }

  /// The booking's service type, taken from its items — web has no shop-level
  /// service selection to read it from, so service-specific wording (Return vs
  /// Check-Out, Product vs Room) is derived per booking.
  MainServiceType? get mainServiceType => bookedItems
      .map((e) => e.mainServiceType)
      .firstWhere((type) => type != null, orElse: () => null);

  int get remainingSecurityBalance => securityTransactionSummary.pendingDeposit;

  int get totalSecurityDeducted => securityTransactionSummary.totalDeducted;

  int get totalSecurityRefunded => securityTransactionSummary.totalRefunded;

  bool get hasPartialSecurityRefund =>
      securityTransactionSummary.totalDeducted > 0;

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
    if (securityTransactionSummary.totalSecurityAmount <= 0) return false;

    // Only show the security deposit if the booking is still active
    return deliveryStatus != DeliveryStatus.cancelled &&
        deliveryStatus != DeliveryStatus.returned;
  }

  /// Whether the dedicated security refund/deduction section should render.
  bool get showSecurityRefundSection =>
      !showSecurityInPayments && isSecurityPaid;
}
