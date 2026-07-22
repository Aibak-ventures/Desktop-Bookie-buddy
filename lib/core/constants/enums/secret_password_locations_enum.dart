import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:flutter/material.dart';

enum SecretPasswordLocations {
  ledgerView('LEDGER_VIEW', 'Ledger View'),
  bookingEdit('BOOKING_EDIT', 'Booking Edit'),
  bookingDelete('BOOKING_DELETE', 'Booking Delete'),
  bookingPayment('BOOKING_PAYMENT', 'Booking Payment'),
  monthlyGrossView('MONTHLY_GROSS_VIEW', 'Monthly Gross View'),
  transferProduct('TRANSFER_PRODUCT', 'Transfer Product'),
  productDeletion('PRODUCT_DELETION', 'Product Deletion'),
  productEdit('PRODUCT_EDIT', 'Product Edit'),
  shopPerformance('SHOP_PERFORMANCE', 'Shop Performance');

  const SecretPasswordLocations(this.value, this.name);

  final String value;
  final String name;

  //
  String getServiceSpecificName(MainServiceType? mainServiceType) {
    if (mainServiceType == null) return name;
    if (mainServiceType.isRoom) {
      final productNameLabel = mainServiceType.productNameLabel;
      return switch (this) {
        productEdit => '${productNameLabel} Edit',
        productDeletion => '${productNameLabel} Deletion',
        transferProduct => 'Transfer ${productNameLabel}',
        _ => name,
      };
    }
    return name;
  }

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
