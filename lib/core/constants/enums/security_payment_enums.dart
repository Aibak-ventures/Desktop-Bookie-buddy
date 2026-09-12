/// Action chosen by the user when adding a new security-deposit transaction.
enum SecurityTransactionAction {
  refund('Refund'),
  deduction('Deduction');

  const SecurityTransactionAction(this.label);

  final String label;

  bool get isRefund => this == SecurityTransactionAction.refund;
  bool get isDeduction => this == SecurityTransactionAction.deduction;
}
