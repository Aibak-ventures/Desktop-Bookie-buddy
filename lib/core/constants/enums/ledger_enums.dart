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
  pdf('PDF', 'pdf'),
  excel('Excel', 'excel');

  final String name;
  final String value;

  const InvoiceType(this.name, this.value);
}

// enum LedgerType {
//   all,
//   payments,
//   expense,
//   pendings,
//   security,
//   bookings,
//   sales;

//   String get name {
//     switch (this) {
//       case LedgerType.all:
//         return 'All';
//       case LedgerType.payments:
//         return 'Payments';
//       case LedgerType.expense:
//         return 'Expenses';
//       case LedgerType.pendings:
//         return 'Pendings';
//       case LedgerType.security:
//         return 'Security';
//       case LedgerType.bookings:
//         return 'Bookings';
//       case LedgerType.sales:
//         return 'Sales';
//     }
//   }

//   String get value {
//     switch (this) {
//       case LedgerType.all:
//         return 'all';
//       case LedgerType.payments:
//         return 'payments';
//       case LedgerType.expense:
//         return 'expense';
//       case LedgerType.pendings:
//         return 'pendings';
//       case LedgerType.security:
//         return 'security';
//       case LedgerType.bookings:
//         return 'bookings';
//       case LedgerType.sales:
//         return 'sales';
//     }
//   }

//   static LedgerType fromString(String? value) {
//     switch (value?.toLowerCase()) {
//       case 'payment':
//         return LedgerType.payments;
//       case 'expense':
//         return LedgerType.expense;
//       case 'pending':
//         return LedgerType.pendings;
//       case 'security':
//         return LedgerType.security;
//       case 'booking':
//         return LedgerType.bookings;
//       case 'sale':
//         return LedgerType.sales;
//       default:
//         return LedgerType.all;
//     }
//   }

//   bool get isAll => this == LedgerType.all;
//   bool get isPayments => this == LedgerType.payments;
//   bool get isExpense => this == LedgerType.expense;
//   bool get isPendings => this == LedgerType.pendings;
//   bool get isSecurity => this == LedgerType.security;
//   bool get isBookings => this == LedgerType.bookings;
//   bool get isSales => this == LedgerType.sales;
// }

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
