/// Type of an existing security-deposit history entry, as returned by the API.
enum SecurityPaymentHistoryType {
  refund('refund'),
  deduction('deduction');

  const SecurityPaymentHistoryType(this.value);

  final String value;

  static SecurityPaymentHistoryType fromJson(String? value) {
    return SecurityPaymentHistoryType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SecurityPaymentHistoryType.refund,
    );
  }

  bool get isRefund => this == SecurityPaymentHistoryType.refund;
  bool get isDeduction => this == SecurityPaymentHistoryType.deduction;
}

/// Action chosen by the user when adding a new security-deposit transaction.
enum SecurityTransactionAction {
  refund('Refund'),
  deduction('Deduction');

  const SecurityTransactionAction(this.label);

  final String label;

  bool get isRefund => this == SecurityTransactionAction.refund;
  bool get isDeduction => this == SecurityTransactionAction.deduction;
}
