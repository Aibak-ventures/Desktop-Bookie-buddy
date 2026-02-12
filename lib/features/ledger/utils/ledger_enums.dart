
/// Helper enum to represent different types of ledger list items which can be
/// associated with bookings, sales, or custom work.
enum LedgerListType {
  booking('booking'),
  sales('sale'),
  customWork('tailor_order');

  final String value;

  const LedgerListType(this.value);

  static LedgerListType fromJson(String? type) {
    if (type == null) {
      return LedgerListType.booking;
    }

    return LedgerListType.values.firstWhere(
      (e) => e.value == type.toLowerCase(),
      orElse: () => LedgerListType.booking,
    );
  }

  static String toJson(LedgerListType type) => type.name;

  /// Returns the corresponding navigation route name for each LedgerListType
  // String get getNavigationRouteName {
  //   switch (this) {
  //     case LedgerListType.booking:
  //       return AppRoutes.bookingDetails.name;
  //     case LedgerListType.sales:
  //       return AppRoutes.saleDetails.name;
  //     case LedgerListType.customWork:
  //       return AppRoutes.customWorkDetails.name;
  //   }
  // }
  //

  bool get isBooking => this == booking;
  bool get isSales => this == sales;
  bool get isCustomWork => this == customWork;
}

enum InvoiceType {
  pdf('pdf', 'PDF'),
  excel('excel', 'Excel');

  final String name;
  final String value;

  const InvoiceType(this.value, this.name);
}

enum LedgerType {
  all('All', 'all', 'all'),
  payments('Payments', 'payments', 'payment'),
  expense('Expenses', 'expense', 'expense'),
  pendings('Pendings', 'pendings', 'pending'),
  security('Security', 'security', 'security'),
  bookings('Bookings', 'bookings', 'booking'),
  sales('Sales', 'sales', 'sales');

  final String name;
  final String value;
  final String valueFromJson;

  const LedgerType(this.name, this.value, this.valueFromJson);

  static LedgerType fromString(String? value) {
    if (value == null) {
      return LedgerType.all;
    }

    return LedgerType.values.firstWhere(
      (e) => e.valueFromJson == value.toLowerCase(),
      orElse: () => LedgerType.all,
    );
  }

  bool get isAll => this == LedgerType.all;
  bool get isPayments => this == LedgerType.payments;
  bool get isExpense => this == LedgerType.expense;
  bool get isPendings => this == LedgerType.pendings;
  bool get isSecurity => this == LedgerType.security;
  bool get isBookings => this == LedgerType.bookings;
  bool get isSales => this == LedgerType.sales;
}
