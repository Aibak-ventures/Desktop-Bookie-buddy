import 'package:flutter/material.dart';

enum SecretPasswordLocations {
  ledgerView('LEDGER_VIEW', 'Ledger View'),
  bookingEdit('BOOKING_EDIT', 'Booking Edit'),
  bookingDelete('BOOKING_DELETE', 'Booking Delete'),
  bookingPayment('BOOKING_PAYMENT', 'Booking Payment'),
  transferProduct('TRANSFER_PRODUCT', 'Transfer Product'),
  monthlyGrossView('MONTHLY_GROSS_VIEW', 'Monthly Gross View'),
  productDeletion('PRODUCT_DELETION', 'Product Deletion'),
  productEdit('PRODUCT_EDIT', 'Product Edit');

  const SecretPasswordLocations(this.value, this.name);

  final String value;
  final String name;

  /// Convert from string to SecretPasswordLocations enum
  static SecretPasswordLocations? fromString(String? value) {
    if (value == null) {
      return null;
    }
    return SecretPasswordLocations.values
        .cast<SecretPasswordLocations?>()
        .firstWhere(
          (e) => e?.value == value.toUpperCase(),
          orElse: () {
            debugPrint('Unknown SecretPasswordLocations value: $value');
            return null;
          },
        );
  }

  static SecretPasswordLocations? fromJson(String? value) {
    if (value == null) {
      return null;
    }
    return SecretPasswordLocations.values
        .cast<SecretPasswordLocations?>()
        .firstWhere((e) => e?.value == value, orElse: () => null);
  }

  static String? toJson(SecretPasswordLocations? location) => location?.value;
}

/// Extension methods for nullable SecretPasswordLocations enum
extension SecretPasswordLocationsX on SecretPasswordLocations? {
  bool get isLedgerView => this == SecretPasswordLocations.ledgerView;
  bool get isBookingEdit => this == SecretPasswordLocations.bookingEdit;
  bool get isBookingDelete => this == SecretPasswordLocations.bookingDelete;
  bool get isBookingPayment => this == SecretPasswordLocations.bookingPayment;
  bool get isTransferProduct => this == SecretPasswordLocations.transferProduct;
  bool get isMonthlyGrossView =>
      this == SecretPasswordLocations.monthlyGrossView;
  bool get isProductDeletion => this == SecretPasswordLocations.productDeletion;
  bool get isProductEdit => this == SecretPasswordLocations.productEdit;
}
