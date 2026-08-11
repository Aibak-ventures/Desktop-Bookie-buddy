import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_text_field_builder.dart';
import 'package:flutter/material.dart';

/// Reusable "cash + bank/UPI split" fields for a payment amount: a cash
/// account selector plus a bank/UPI amount + account pair when [isSplit] is
/// true, falling back to [singlePaymentSelector] otherwise.
///
/// UI-only and stateless — the amount field itself (which doubles as the
/// cash amount when split) and the split on/off toggle stay with the caller,
/// since their placement/label/hint differ per screen. This widget only owns
/// the fields that appear below the amount, so it can be dropped into new
/// booking, sales, old booking, or edit-booking screens alike without
/// duplicating this layout or its account filtering.
class SplitAdvancePaymentFields extends StatelessWidget {
  final bool isSplit;

  final TextEditingController bankAmountController;

  final AccountEntity? cashAccount;
  final ValueChanged<AccountEntity?> onCashAccountChanged;

  final AccountEntity? bankAccount;
  final ValueChanged<AccountEntity?> onBankAccountChanged;

  /// Shown instead of the cash/bank fields when [isSplit] is false — pass the
  /// screen's existing single `AccountSelectionField`.
  final Widget singlePaymentSelector;

  final String cashAccountLabel;
  final String bankAmountHint;
  final String bankAmountLabel;
  final String bankAccountLabel;
  final double spacing;
  final double spacingBetweenBankAccount;

  const SplitAdvancePaymentFields({
    super.key,
    required this.isSplit,
    required this.bankAmountController,
    required this.cashAccount,
    required this.onCashAccountChanged,
    required this.bankAccount,
    required this.onBankAccountChanged,
    required this.singlePaymentSelector,
    this.cashAccountLabel = 'Cash Account',
    this.bankAmountHint = 'Enter advance Bank/UPI amount',
    this.bankAmountLabel = 'Advance amount (Bank/UPI)',
    this.bankAccountLabel = 'Bank/UPI Account',
    this.spacing = 12,
    this.spacingBetweenBankAccount = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (!isSplit) return singlePaymentSelector;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AccountSelectionField(
          selectedAccount: cashAccount,
          onChanged: onCashAccountChanged,
          label: cashAccountLabel,
          filterType: AccountFilterType.cashOnly,
        ),
        SizedBox(height: spacing),
        BookingTextFieldBuilder.buildRightPanelTextField(
          controller: bankAmountController,
          hint: bankAmountHint,
          label: bankAmountLabel,
          isNumber: true,
        ),
        SizedBox(height: spacingBetweenBankAccount),
        AccountSelectionField(
          selectedAccount: bankAccount,
          onChanged: onBankAccountChanged,
          label: bankAccountLabel,
          filterType: AccountFilterType.bankOnly,
          width: double.infinity,
        ),
      ],
    );
  }
}
