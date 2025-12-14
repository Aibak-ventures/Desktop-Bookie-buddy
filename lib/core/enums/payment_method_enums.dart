enum PaymentMethod {
  gPay,
  cash;

  static const GPAY = 'gpay';
  static const CASH = 'cash';

  /// UI label
  String get name {
    switch (this) {
      case PaymentMethod.gPay:
        return 'UPI';
      case PaymentMethod.cash:
        return 'Cash';
    }
  }

  /// API value
  String toValue() {
    switch (this) {
      case PaymentMethod.gPay:
        return GPAY;
      case PaymentMethod.cash:
        return CASH;
    }
  }

  /// String → enum
  static PaymentMethod fromString(String status) {
    final v = status.toLowerCase().replaceAll(' ', '');
    if (v.contains(GPAY)) return PaymentMethod.gPay;
    if (v.contains(CASH)) return PaymentMethod.cash;
    return PaymentMethod.cash;
  }

  /// ✅ USED WHEN API SENDS **LIST**
  static List<PaymentMethod> fromList(List<dynamic> list) =>
      list.map((e) => fromString(e.toString())).toList();

  static List<String> toList(List<PaymentMethod> list) =>
      list.map((e) => e.toValue()).toList();

  bool get isUpi => this == PaymentMethod.gPay;
  bool get isCash => this == PaymentMethod.cash;
}

/// 🔥 THIS IS THE MISSING PART (IMPORTANT)
/// API sends `"payment_methods": "GPay"`
/// Model expects `List<PaymentMethod>`
class PaymentMethodJsonConverter {
  static List<PaymentMethod> fromJson(dynamic value) {
    if (value == null) return [];

    // API sends STRING
    if (value is String) {
      return [PaymentMethod.fromString(value)];
    }

    // API sends LIST (safety)
    if (value is List) {
      return PaymentMethod.fromList(value);
    }

    return [];
  }

  static dynamic toJson(List<PaymentMethod> methods) {
    if (methods.isEmpty) return null;
    return methods.first.toValue();
  }
}


enum PaymentStatus {
  pending,
  completed;

  /// Converts [PaymentStatus] enum to a string label to display in the UI.
  String get name {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.completed:
        return 'Completed';
    }
  }

  /// Converts the [PaymentStatus] enum to its corresponding string value
  /// for use in API requests or data storage.
  ///
  /// Returns:
  ///   The string value associated with the enum.
  String toValue() {
    switch (this) {
      case PaymentStatus.pending:
        return 'pending';
      case PaymentStatus.completed:
        return 'completed';
    }
  }

  /// Converts a string representation of a payment status to its corresponding enum value.
  ///
  /// Supported string representations:
  ///
  /// - "pending"
  /// - "completed"
  ///
  /// Returns [PaymentStatus.pending] if the given string is not recognized.
  static PaymentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return PaymentStatus.pending;
      case 'completed':
        return PaymentStatus.completed;
      default:
        return PaymentStatus.pending;
    }
  }

  static PaymentStatus fromBool(bool? status) {
    if (status == true) {
      return PaymentStatus.completed;
    } else {
      return PaymentStatus.pending;
    }
  }

  static String toJson(PaymentStatus status) => status.toValue();
}

enum PurchaseMode {
  normal,
  package;

  /// Converts [PurchaseMode] enum to a string label to display in the UI.
  String get name {
    switch (this) {
      case PurchaseMode.normal:
        return 'Normal';
      case PurchaseMode.package:
        return 'Package';
    }
  }

  /// Converts the [PurchaseMode] enum to its corresponding string value
  /// for use in API requests or data storage.
  ///
  /// Returns:
  ///   The string value associated with the enum.
  String toValue() {
    switch (this) {
      case PurchaseMode.normal:
        return 'normal';
      case PurchaseMode.package:
        return 'package';
    }
  }

  /// Converts a string representation of a purchase mode to its corresponding enum value.
  ///
  /// Supported string representations:
  ///
  /// - "normal"
  /// - "package"
  ///
  /// Returns [PurchaseMode.normal] if the given string is not recognized.
  static PurchaseMode fromString(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return PurchaseMode.normal;
      case 'package':
        return PurchaseMode.package;
      default:
        return PurchaseMode.normal;
    }
  }
}
