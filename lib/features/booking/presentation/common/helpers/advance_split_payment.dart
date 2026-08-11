import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_request_entity/booking_payment_request_entity.dart';

/// Cash + bank/UPI split of a single payment amount (advance, security, …),
/// each leg carrying its own account.
///
/// Pure data — no [BuildContext], no controllers — so it can be built by any
/// screen (new booking, sales, old booking, edit booking) from whatever
/// controllers/state that screen already owns, and then handed to
/// [BookingFormValidator.validatePayment] and [BookingRequestBuilder] without
/// each call site re-deriving totals or the `payments` breakdown itself.
class AdvanceSplitPayment {
  final bool isSplit;

  /// Cash leg amount. When [isSplit] is false, this doubles as the plain,
  /// unsplit amount.
  final int cashAmount;

  /// Bank/UPI leg amount. Ignored when [isSplit] is false.
  final int bankAmount;

  final AccountEntity? cashAccount;
  final AccountEntity? bankAccount;

  const AdvanceSplitPayment({
    required this.isSplit,
    required this.cashAmount,
    this.bankAmount = 0,
    this.cashAccount,
    this.bankAccount,
  });

  /// A non-split payment of [amount] — convenience for call sites that
  /// haven't opted into split mode.
  const AdvanceSplitPayment.single(int amount)
    : isSplit = false,
      cashAmount = amount,
      bankAmount = 0,
      cashAccount = null,
      bankAccount = null;

  /// Combined total across both legs (or just [cashAmount] when not split).
  int get total => isSplit ? cashAmount + bankAmount : cashAmount;

  bool get hasAmount => total > 0;

  /// True once every leg with a positive amount has an account attached —
  /// i.e. the split is ready to submit. Non-split payments are considered
  /// complete as long as they have no amount (account requirement is the
  /// caller's [singleAccount] concern, checked separately).
  bool get isComplete {
    if (!isSplit) return true;
    if (cashAmount > 0 && cashAccount == null) return false;
    if (bankAmount > 0 && bankAccount == null) return false;
    return true;
  }

  /// Builds the `payments` breakdown for the API. [singleAccount] is used
  /// when this payment isn't split. Returns null when there is nothing to pay
  /// or a required account is missing.
  List<BookingPaymentRequestEntity>? buildPayments({
    required AccountEntity? singleAccount,
  }) {
    if (!hasAmount) return null;
    if (!isSplit) {
      if (singleAccount == null) return null;
      return [
        BookingPaymentRequestEntity(accountId: singleAccount.id, amount: total),
      ];
    }
    if (!isComplete) return null;
    return [
      if (cashAmount > 0)
        BookingPaymentRequestEntity(
          accountId: cashAccount!.id,
          amount: cashAmount,
        ),
      if (bankAmount > 0)
        BookingPaymentRequestEntity(
          accountId: bankAccount!.id,
          amount: bankAmount,
        ),
    ];
  }
}
