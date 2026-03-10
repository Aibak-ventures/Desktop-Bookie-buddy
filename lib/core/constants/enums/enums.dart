import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

/// This file contains all the enums used in the app
/// export newly created enums from this folder like below

// export 'availability_status_enums.dart';
// export 'booking_status_enums.dart';
// export 'gender_type_enums.dart';
// export 'invoice_enums.dart';
// export 'payment_method_enums.dart';
// export 'service_type_enums.dart';

enum UserPasswordSettingRole {
  all,
  none,
  staff,
  managerAndStaff;

  /// Get the display name of the enum value.
  ///
  /// Example: UserPasswordSettingRole.managerAndStaff.name => "Manager and Staff"
  String get name {
    switch (this) {
      case UserPasswordSettingRole.all:
        return 'All';
      case UserPasswordSettingRole.none:
        return 'None';
      case UserPasswordSettingRole.staff:
        return 'Staff';
      case UserPasswordSettingRole.managerAndStaff:
        return 'Manager and Staff';
    }
  }

  /// Get the string representation of the enum value.
  ///
  /// Example: UserPasswordSettingRole.managerAndStaff.value => "MANAGER_AND_STAFF"
  String get value {
    switch (this) {
      case UserPasswordSettingRole.all:
        return 'ALL';
      case UserPasswordSettingRole.none:
        return 'NONE';
      case UserPasswordSettingRole.staff:
        return 'STAFF';
      case UserPasswordSettingRole.managerAndStaff:
        return 'MANAGER_AND_STAFF';
    }
  }

  /// Convert a string representation to the enum value.
  ///
  /// Example: UserPasswordSettingRole.fromString("MANAGER_AND_STAFF") => UserPasswordSettingRole.managerAndStaff
  static UserPasswordSettingRole fromString(String value) {
    switch (value.toUpperCase()) {
      case 'NONE':
        return UserPasswordSettingRole.none;
      case 'STAFF':
        return UserPasswordSettingRole.staff;
      case 'MANAGER_AND_STAFF':
        return UserPasswordSettingRole.managerAndStaff;
      case 'ALL':
        return UserPasswordSettingRole.all;
      default:
        return UserPasswordSettingRole.all;
    }
  }
}

enum ShopRole {
  owner,
  manager,
  staff;

  /// Get the display name of the enum value.
  ///
  /// Example: ShopRole.manager.name => "Manager"
  String get name {
    switch (this) {
      case ShopRole.owner:
        return 'OWNER';
      case ShopRole.manager:
        return 'Manager';
      case ShopRole.staff:
        return 'Staff';
    }
  }

  /// Get the string representation of the enum value.
  ///
  /// Example: ShopRole.manager.value => "MANAGER"
  String get value {
    switch (this) {
      case ShopRole.owner:
        return 'OWNER';
      case ShopRole.manager:
        return 'MANAGER';
      case ShopRole.staff:
        return 'STAFF';
    }
  }

  /// Convert a string representation to the enum value.
  ///
  /// Example: ShopRole.fromString("MANAGER") => ShopRole.manager
  static ShopRole fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'OWNER':
        return ShopRole.owner;
      case 'MANAGER':
        return ShopRole.manager;
      case 'STAFF':
        return ShopRole.staff;
      default:
        return ShopRole.staff;
    }
  }

  bool get isStaff => this == ShopRole.staff;
  bool get isManager => this == ShopRole.manager;
  bool get isOwner => this == ShopRole.owner;
}

enum SecretPasswordLocations {
  ledgerView,
  bookingEdit,
  bookingDelete,
  bookingPayment,
  transferProduct,
  monthlyGrossView,
  productDeletion,
  productEdit;

  static const _LEDGER_VIEW = 'LEDGER_VIEW';
  static const _BOOKING_EDIT = 'BOOKING_EDIT';
  static const _BOOKING_DELETE = 'BOOKING_DELETE';
  static const _BOOKING_PAYMENT = 'BOOKING_PAYMENT';
  static const _TRANSFER_PRODUCT = 'TRANSFER_PRODUCT';
  static const _MONTHLY_GROSS_VIEW = 'MONTHLY_GROSS_VIEW';
  static const _PRODUCT_DELETION = 'PRODUCT_DELETION';
  static const _PRODUCT_EDIT = 'PRODUCT_EDIT';

  String get name {
    switch (this) {
      case SecretPasswordLocations.ledgerView:
        return 'Ledger View';
      case SecretPasswordLocations.bookingEdit:
        return 'Booking Edit';
      case SecretPasswordLocations.bookingDelete:
        return 'Booking Delete';
      case SecretPasswordLocations.bookingPayment:
        return 'Booking Payment';
      case SecretPasswordLocations.transferProduct:
        return 'Transfer Product';
      case SecretPasswordLocations.monthlyGrossView:
        return 'Monthly Gross View';
      case SecretPasswordLocations.productDeletion:
        return 'Product Deletion';
      case SecretPasswordLocations.productEdit:
        return 'Product Edit';
    }
  }

  String get value {
    switch (this) {
      case SecretPasswordLocations.ledgerView:
        return _LEDGER_VIEW;
      case SecretPasswordLocations.bookingEdit:
        return _BOOKING_EDIT;
      case SecretPasswordLocations.bookingDelete:
        return _BOOKING_DELETE;
      case SecretPasswordLocations.bookingPayment:
        return _BOOKING_PAYMENT;
      case SecretPasswordLocations.transferProduct:
        return _TRANSFER_PRODUCT;
      case SecretPasswordLocations.monthlyGrossView:
        return _MONTHLY_GROSS_VIEW;
      case SecretPasswordLocations.productDeletion:
        return _PRODUCT_DELETION;
      case SecretPasswordLocations.productEdit:
        return _PRODUCT_EDIT;
    }
  }

  static SecretPasswordLocations? fromString(String value) {
    switch (value.toUpperCase()) {
      case _LEDGER_VIEW:
        return SecretPasswordLocations.ledgerView;
      case _BOOKING_EDIT:
        return SecretPasswordLocations.bookingEdit;
      case _BOOKING_DELETE:
        return SecretPasswordLocations.bookingDelete;
      case _BOOKING_PAYMENT:
        return SecretPasswordLocations.bookingPayment;
      case _TRANSFER_PRODUCT:
        return SecretPasswordLocations.transferProduct;
      case _MONTHLY_GROSS_VIEW:
        return SecretPasswordLocations.monthlyGrossView;
      case _PRODUCT_DELETION:
        return SecretPasswordLocations.productDeletion;
      case _PRODUCT_EDIT:
        return SecretPasswordLocations.productEdit;
      default:
        debugPrint('Unknown SecretPasswordLocations value: $value');
        return null;
    }
  }
}

enum AppFeatures {
  transferProduct;

  String get name {
    switch (this) {
      case AppFeatures.transferProduct:
        return 'TRANSFER';
    }
  }

  bool containsFeature(List<String>? features) =>
      features?.contains(name.toUpperCase()) ?? false;
}

enum AddButtonDefaultAction {
  booking,
  sales,
  ask;

  static const _BOOKINGS = 'BOOKINGS';
  static const _SALES = 'SALES';
  static const _ASK = 'ASK_EVERY_TIME';

  String get label {
    switch (this) {
      case booking:
        return 'New Booking';
      case sales:
        return 'New Sales';
      case ask:
        return 'Ask every time';
    }
  }

  static AddButtonDefaultAction fromString(String value) {
    switch (value.toUpperCase()) {
      case _BOOKINGS:
        return booking;
      case _SALES:
        return sales;
      case _ASK:
        return ask;
      default:
        return booking;
    }
  }

  String toJson() {
    switch (this) {
      case booking:
        return _BOOKINGS;
      case sales:
        return _SALES;
      case ask:
        return _ASK;
    }
  }
}

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  int get number => index + 1;

  String get value => name.capitalizeFirstLetter();

  static Month fromInt(int month) => Month.values[month - 1];
}

enum AppMainFeatureType {
  bookings,
  sales;

  // expenses,
  // ledger,
  // notifications,
  // staff,

  String get value => name;
}
