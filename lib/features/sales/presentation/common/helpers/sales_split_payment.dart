

import 'package:bookie_buddy_shared/core/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_shared/core/features/sales/domain/entities/sales_payment_request_entity/sales_payment_request_entity.dart';

/// Cash + bank/UPI split of a sale's payable total, each leg carrying its
/// own account. Mirrors booking's `AdvanceSplitPayment`, adapted for sales:
///
/// - There is no partial-payment concept here — a sale is always paid in
///   full, so [total] always represents the *entire* payable amount, not an
///   advance, and callers are expected to keep the two legs balanced to it
///   themselves (see the auto-balance logic in
///   `AddOrEditSalesFormStateController`/`NewBookingScreenState`).
/// - Each leg tracks the id of the payment record it corresponds to when
///   editing an existing sale (`cashPaymentId`/`bankPaymentId`), so
///   [buildPayments] can update that exact record instead of creating a
///   duplicate.
/// - Each leg also accepts a fallback account id
///   (`cashAccountIdFallback`/`bankAccountIdFallback`/
///   `singleAccountIdFallback`) resolved from the sale's original payment —
///   used only when the corresponding [AccountEntity] picker still holds no
///   selection because the user never touched it. This is what lets
///   [buildPayments] always send `account_id` for every entry, even an
///   unchanged one, which the backend requires.
class SalesSplitPayment {
  final bool isSplit;

  /// Cash leg amount. When [isSplit] is false, this doubles as the plain,
  /// unsplit amount (the full payable total).
  final int cashAmount;

  /// Bank/UPI leg amount. Ignored when [isSplit] is false.
  final int bankAmount;

  final AccountEntity? cashAccount;
  final AccountEntity? bankAccount;

  final int? cashPaymentId;
  final int? bankPaymentId;
  final int? singlePaymentId;

  const SalesSplitPayment({
    required this.isSplit,
    required this.cashAmount,
    this.bankAmount = 0,
    this.cashAccount,
    this.bankAccount,
    this.cashPaymentId,
    this.bankPaymentId,
    this.singlePaymentId,
  });

  /// Combined total across both legs (or just [cashAmount] when not split).
  int get total => isSplit ? cashAmount + bankAmount : cashAmount;

  bool get hasAmount => total > 0;

  /// Builds the sale's `payments` breakdown for the API.
  ///
  /// [singleAccount] and [singleAccountIdFallback] resolve the non-split
  /// leg's account_id; [cashAccountIdFallback]/[bankAccountIdFallback] do
  /// the same for each split leg. Returns null when there's nothing to pay
  /// or a required account can't be resolved at all.
  List<SalesPaymentRequestEntity>? buildPayments({
    required AccountEntity? singleAccount,
    int? singleAccountIdFallback,
    int? cashAccountIdFallback,
    int? bankAccountIdFallback,
  }) {
    if (!hasAmount) return null;

    if (!isSplit) {
      final resolvedAccountId = singleAccount?.id ?? singleAccountIdFallback;
      if (resolvedAccountId == null) return null;
      return [
        SalesPaymentRequestEntity(
          id: singlePaymentId,
          accountId: resolvedAccountId,
          amount: total,
        ),
      ];
    }

    final resolvedCashAccountId = cashAccount?.id ?? cashAccountIdFallback;
    final resolvedBankAccountId = bankAccount?.id ?? bankAccountIdFallback;
    if (cashAmount > 0 && resolvedCashAccountId == null) return null;
    if (bankAmount > 0 && resolvedBankAccountId == null) return null;

    return [
      if (cashAmount > 0)
        SalesPaymentRequestEntity(
          id: cashPaymentId,
          accountId: resolvedCashAccountId!,
          amount: cashAmount,
        ),
      if (bankAmount > 0)
        SalesPaymentRequestEntity(
          id: bankPaymentId,
          accountId: resolvedBankAccountId!,
          amount: bankAmount,
        ),
    ];
  }
}
