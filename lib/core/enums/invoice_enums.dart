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

enum LedgerType {
  all,
  payments,
  expense,
  pendings,
  security,
  bookings,
  sales;

  String get name {
    switch (this) {
      case LedgerType.all:
        return 'All';
      case LedgerType.payments:
        return 'Payments';
      case LedgerType.expense:
        return 'Expenses';
      case LedgerType.pendings:
        return 'Pendings';
      case LedgerType.security:
        return 'Security';
      case LedgerType.bookings:
        return 'Bookings';
      case LedgerType.sales:
        return 'Sales';
    }
  }

  String get value {
    switch (this) {
      case LedgerType.all:
        return 'all';
      case LedgerType.payments:
        return 'payments';
      case LedgerType.expense:
        return 'expense';
      case LedgerType.pendings:
        return 'pendings';
      case LedgerType.security:
        return 'security';
      case LedgerType.bookings:
        return 'bookings';
      case LedgerType.sales:
        return 'sales';
    }
  }

  static LedgerType fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'payment':
        return LedgerType.payments;
      case 'expense':
        return LedgerType.expense;
      case 'pending':
        return LedgerType.pendings;
      case 'security':
        return LedgerType.security;
      case 'booking':
        return LedgerType.bookings;
      case 'sale':
        return LedgerType.sales;
      default:
        return LedgerType.all;
    }
  }

  bool get isAll => this == LedgerType.all;
  bool get isPayments => this == LedgerType.payments;
  bool get isExpense => this == LedgerType.expense;
  bool get isPendings => this == LedgerType.pendings;
  bool get isSecurity => this == LedgerType.security;
  bool get isBookings => this == LedgerType.bookings;
  bool get isSales => this == LedgerType.sales;
}
