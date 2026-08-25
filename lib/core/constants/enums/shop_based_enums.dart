// UserPasswordSettingRole, ShopRole, AddButtonDefaultAction, and
// CoolingPeriodMode all moved into bookie_buddy_core — see
// docs/shared-packages-plan.md in the mobile app repo. AppMainFeatureType
// stays local: web-only, mobile has no equivalent concept.
export 'package:bookie_buddy_core/core/constants/enums/shop_based_enums.dart';
export 'package:bookie_buddy_core/core/constants/enums/cooling_period_mode_enum.dart';

enum AppMainFeatureType {
  bookings('bookings'),
  sales('sales');

  const AppMainFeatureType(this.value);

  final String value;

  /// Convert from string to AppMainFeatureType enum
  static AppMainFeatureType fromString(String? value) {
    if (value == null) {
      return AppMainFeatureType.bookings;
    }
    return AppMainFeatureType.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => AppMainFeatureType.bookings,
    );
  }

  static AppMainFeatureType fromJson(String? value) {
    if (value == null) {
      return AppMainFeatureType.bookings;
    }
    return AppMainFeatureType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AppMainFeatureType.bookings,
    );
  }

  static String? toJson(AppMainFeatureType? type) => type?.value;

  bool get isBookings => this == AppMainFeatureType.bookings;
  bool get isSales => this == AppMainFeatureType.sales;
}
