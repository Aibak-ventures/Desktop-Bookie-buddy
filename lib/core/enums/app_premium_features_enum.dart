enum AppPremiumFeatures {
  /// Enables customization work feature including:
  /// - Custom work management
  /// - Custom work profile menu item
  /// - Custom Work entry in bottom sheet (Home Add button)
  /// - Customization work entry in settings add button default actions
  customizationWork('CUSTOMIZATION_WORK'),

  /// Enables product transfer feature including:
  /// - Transfer product between shops
  /// - View transfer history
  /// - Transfer Product History profile menu item
  transferProduct('TRANSFER'),

  /// Enables all shop summary features including:
  /// - Revenue tracker
  /// - Expense tracker
  /// - Booking summary
  /// - Sales summary
  /// - Shop performance profile menu item or card
  allShopSummary('SHOPS_REVENUE_TRACKER'),

  /// Enables WhatsApp messaging feature including:
  /// - Sharing invoices via WhatsApp for booking and sales
  whatsappMessage('WHATSAPP_MESSAGE'),

  /// Enables sales management features including:
  /// - Sales ledger tab
  /// - Sales entry in bottom sheet (Home Add button)
  /// - Sales profile menu item
  /// - Sales entry in settings add button default actions
  sales('SALES'),

  /// Enables staff analytics feature including:
  /// - Staff performance reports
  /// - staff analytics option in dropdown in staff list screen
  staffAnalytics('STAFF_ANALYTICS'),

  /// Fallback for unknown / future features
  unknown('UNKNOWN');

  const AppPremiumFeatures(this.name);

  final String name;

  static AppPremiumFeatures fromJson(String? value) {
    if (value == null) {
      return unknown;
    }
    return AppPremiumFeatures.values.firstWhere(
      (e) => e.name == value,
      orElse: () => unknown,
    );
  }

  static AppPremiumFeatures? tryFromJson(String? value) {
    if (value == null) {
      return null;
    }
    return AppPremiumFeatures.values.cast<AppPremiumFeatures?>().firstWhere(
      (e) => e?.name == value,
      orElse: () => null,
    );
  }

  static Set<AppPremiumFeatures> fromList(List<dynamic>? featuresList) {
    if (featuresList == null) {
      return {};
    }
    final Set<AppPremiumFeatures> featureSet = {};
    for (final feature in featuresList) {
      if (feature is! String) continue;
      final appFeature = AppPremiumFeatures.tryFromJson(feature);
      if (appFeature != null) {
        featureSet.add(appFeature);
      }
    }
    return featureSet;
  }

  static String? toJson(AppPremiumFeatures? feature) => feature?.name;

  static List<String> toJsonList(Set<AppPremiumFeatures>? features) =>
      features?.map((e) => e.name).toList() ?? [];

  bool containsFeature(Set<AppPremiumFeatures>? features) =>
      features?.contains(this) ?? false;

  bool get isCustomizationWork => this == AppPremiumFeatures.customizationWork;
  bool get isTransferProduct => this == AppPremiumFeatures.transferProduct;
  bool get isAllShopSummary => this == AppPremiumFeatures.allShopSummary;
  bool get isUnknown => this == AppPremiumFeatures.unknown;
  bool get isKnown => this != AppPremiumFeatures.unknown;
}

enum AppMainFeatureType {
  bookings('bookings'),
  sales('sales'),
  customization('customization');

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
  bool get isCustomization => this == AppMainFeatureType.customization;
}