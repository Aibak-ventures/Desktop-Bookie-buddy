import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';

enum PaymentMethod {
  upi('upi', 'UPI', 'upi'),
  cash('cash', 'Cash', 'cash');

  const PaymentMethod(this.value, this.name, this.upiValue);

  final String value;
  final String name;
  final String upiValue;

  /// Convert from string to PaymentMethod enum
  // static PaymentMethod fromString(String? status) {
  //   if (status == null) {
  //     return PaymentMethod.cash;
  //   }
  //   return PaymentMethod.values.firstWhere(
  //     (e) =>
  //         e.value == status.toLowerCase() || e.upiValue == status.toLowerCase(),
  //     orElse: () => PaymentMethod.cash,
  //   );
  // }

  static PaymentMethod? tryFromJson(String? value) {
    if (value == null) {
      return null;
    }
    return PaymentMethod.values.firstWhereOrNull((e) => e.value == value);
  }

  static PaymentMethod fromJson(String? value) {
    if (value == null) {
      return PaymentMethod.cash;
    }
    return PaymentMethod.values.firstWhere(
      (e) =>
          e.value == value.toLowerCase() || e.upiValue == value.toLowerCase(),
      orElse: () => PaymentMethod.cash,
    );
  }

  static List<PaymentMethod> fromList(List<dynamic> list) =>
      list.map((e) => fromJson(e.toString())).toList();

  static List<String> toList(List<PaymentMethod> list) =>
      list.map((e) => e.value).toList();

  // static String? toJson(PaymentMethod? method) => method?.value;
  String toJson() => value;
  static String? toUpiJson(PaymentMethod? method) => method?.upiValue;

  bool get isUpi => this == PaymentMethod.upi;
  bool get isCash => this == PaymentMethod.cash;
}

/// Extension methods for nullable PaymentMethod enum
// extension PaymentMethodX on PaymentMethod? {
//   bool get isUpi => this == PaymentMethod.upi;
//   bool get isCash => this == PaymentMethod.cash;
// }

enum PaymentStatus {
  pending('pending'),
  completed('completed');

  const PaymentStatus(this.value);

  final String value;

  String get name => value.capitalizeFirstLetter();

  /// Convert from string to PaymentStatus enum
  static PaymentStatus fromString(String? status) {
    if (status == null) {
      return PaymentStatus.pending;
    }
    return PaymentStatus.values.firstWhere(
      (e) => e.value == status.toLowerCase(),
      orElse: () => PaymentStatus.pending,
    );
  }

  static PaymentStatus fromJson(String? value) {
    if (value == null) {
      return PaymentStatus.pending;
    }
    return PaymentStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PaymentStatus.pending,
    );
  }

  static PaymentStatus fromBool(bool? status) {
    if (status == true) {
      return PaymentStatus.completed;
    } else {
      return PaymentStatus.pending;
    }
  }

  static String? toJson(PaymentStatus? status) => status?.value;

  bool get isPending => this == PaymentStatus.pending;
  bool get isCompleted => this == PaymentStatus.completed;
}

/// Extension methods for nullable PaymentStatus enum
// extension PaymentStatusX on PaymentStatus? {
//   bool get isPending => this == PaymentStatus.pending;
//   bool get isCompleted => this == PaymentStatus.completed;
// }

enum PurchaseMode {
  normal('normal'),
  package('package');

  const PurchaseMode(this.value);

  final String value;

  String get name => value.capitalizeFirstLetter();

  /// Convert from string to PurchaseMode enum
  static PurchaseMode fromString(String? status) {
    if (status == null) {
      return PurchaseMode.normal;
    }
    return PurchaseMode.values.firstWhere(
      (e) => e.value == status.toLowerCase(),
      orElse: () => PurchaseMode.normal,
    );
  }

  static PurchaseMode fromJson(String? value) {
    if (value == null) {
      return PurchaseMode.normal;
    }
    return PurchaseMode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PurchaseMode.normal,
    );
  }

  static String? toJson;

  bool get isNormal => this == PurchaseMode.normal;
  bool get isPackage => this == PurchaseMode.package;
}

/// Extension methods for nullable PurchaseMode enum
// extension PurchaseModeX on PurchaseMode? {
//   bool get isNormal => this == PurchaseMode.normal;
//   bool get isPackage => this == PurchaseMode.package;
// }
