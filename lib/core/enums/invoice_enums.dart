enum InvoiceType {
  pdf,
  excel;

  String get name {
    switch (this) {
      case InvoiceType.pdf:
        return 'PDF';
      case InvoiceType.excel:
        return 'Excel';
    }
  }
}

enum InvoiceIncludeType {
  all,
  payments,
  expense,
  pendings,
  security;

  String get name {
    switch (this) {
      case InvoiceIncludeType.all:
        return 'All';
      case InvoiceIncludeType.payments:
        return 'Payments';
      case InvoiceIncludeType.expense:
        return 'Expenses';
      case InvoiceIncludeType.pendings:
        return 'Pendings';
      case InvoiceIncludeType.security:
        return 'Security';
    }
  }

  String get value {
    switch (this) {
      case InvoiceIncludeType.all:
        return 'all';
      case InvoiceIncludeType.payments:
        return 'payments';
      case InvoiceIncludeType.expense:
        return 'expense';
      case InvoiceIncludeType.pendings:
        return 'pendings';
      case InvoiceIncludeType.security:
        return 'security';
    }
  }

  static InvoiceIncludeType fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'payment':
        return InvoiceIncludeType.payments;
      case 'expense':
        return InvoiceIncludeType.expense;
      case 'pending':
        return InvoiceIncludeType.pendings;
      case 'security':
        return InvoiceIncludeType.security;
      default:
        return InvoiceIncludeType.all;
    }
  }

  bool get isAll => this == InvoiceIncludeType.all;
  bool get isPayments => this == InvoiceIncludeType.payments;
  bool get isExpense => this == InvoiceIncludeType.expense;
  bool get isPendings => this == InvoiceIncludeType.pendings;
  bool get isSecurity => this == InvoiceIncludeType.security;
}
