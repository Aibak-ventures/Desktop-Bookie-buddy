enum UserPasswordSettingRole {
  all('ALL', 'All'),
  none('NONE', 'None'),
  staff('STAFF', 'Staff'),
  managerAndStaff('MANAGER_AND_STAFF', 'Manager and Staff');

  const UserPasswordSettingRole(this.value, this.name);

  final String value;
  final String name;

  /// Convert from string to UserPasswordSettingRole enum
  static UserPasswordSettingRole fromString(String? value) {
    if (value == null) {
      return UserPasswordSettingRole.all;
    }
    return UserPasswordSettingRole.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => UserPasswordSettingRole.all,
    );
  }

  static UserPasswordSettingRole fromJson(String? value) {
    if (value == null) {
      return UserPasswordSettingRole.all;
    }
    return UserPasswordSettingRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => UserPasswordSettingRole.all,
    );
  }

  static String? toJson(UserPasswordSettingRole? role) => role?.value;

  bool get isAll => this == UserPasswordSettingRole.all;
  bool get isNone => this == UserPasswordSettingRole.none;
  bool get isStaff => this == UserPasswordSettingRole.staff;
  bool get isManagerAndStaff => this == UserPasswordSettingRole.managerAndStaff;
}

/// Extension methods for nullable UserPasswordSettingRole enum
// extension UserPasswordSettingRoleX on UserPasswordSettingRole? {
//   bool get isAll => this == UserPasswordSettingRole.all;
//   bool get isNone => this == UserPasswordSettingRole.none;
//   bool get isStaff => this == UserPasswordSettingRole.staff;
//   bool get isManagerAndStaff => this == UserPasswordSettingRole.managerAndStaff;
// }

enum ShopRole {
  owner('OWNER', 'Owner'),
  manager('MANAGER', 'Manager'),
  staff('STAFF', 'Staff');

  const ShopRole(this.value, this.name);

  final String value;
  final String name;

  /// Convert from string to ShopRole enum
  // static ShopRole fromString(String? value) {
  //   if (value == null) {
  //     return ShopRole.staff;
  //   }
  //   return ShopRole.values.firstWhere(
  //     (e) => e.value == value.toUpperCase(),
  //     orElse: () => ShopRole.staff,
  //   );
  // }

  static ShopRole fromJson(String? value) {
    if (value == null) {
      return ShopRole.staff;
    }
    return ShopRole.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => ShopRole.staff,
    );
  }

  String toJson() => value;

  bool get isStaff => this == ShopRole.staff;
  bool get isManager => this == ShopRole.manager;
  bool get isOwner => this == ShopRole.owner;
}

/// Extension methods for nullable ShopRole enum
// extension ShopRoleX on ShopRole? {
//   bool get isStaff => this == ShopRole.staff;
//   bool get isManager => this == ShopRole.manager;
//   bool get isOwner => this == ShopRole.owner;
// }

enum AppPremiumFeatures {
  analytics('ANALYTICS'),
  customizationWork('CUSTOMIZATION_WORK'),
  transferProduct('TRANSFER'),
  allShopSummary('SHOPS_REVENUE_TRACKER');

  const AppPremiumFeatures(this.name);

  final String name;

  /// Convert from string to AppPremiumFeatures enum
  static AppPremiumFeatures? fromString(String? name) {
    if (name == null) {
      return null;
    }
    return AppPremiumFeatures.values.cast<AppPremiumFeatures?>().firstWhere(
      (e) => e?.name == name,
      orElse: () => null,
    );
  }

  static AppPremiumFeatures? fromJson(String? value) {
    if (value == null) {
      return null;
    }
    return AppPremiumFeatures.values.cast<AppPremiumFeatures?>().firstWhere(
      (e) => e?.name == value,
      orElse: () => null,
    );
  }

  static String? toJson(AppPremiumFeatures? feature) => feature?.name;

  bool containsFeature(Set<String>? features) =>
      features?.contains(name) ?? false;

  bool get isAnalytics => this == AppPremiumFeatures.analytics;
  bool get isCustomizationWork => this == AppPremiumFeatures.customizationWork;
  bool get isTransferProduct => this == AppPremiumFeatures.transferProduct;
  bool get isAllShopSummary => this == AppPremiumFeatures.allShopSummary;
}

/// Extension methods for nullable AppPremiumFeatures enum
// extension AppPremiumFeaturesX on AppPremiumFeatures? {
//   bool get isAnalytics => this == AppPremiumFeatures.analytics;
//   bool get isCustomizationWork => this == AppPremiumFeatures.customizationWork;
//   bool get isTransferProduct => this == AppPremiumFeatures.transferProduct;
// }

enum AddButtonDefaultAction {
  booking('BOOKINGS', 'New Booking'),
  sales('SALES', 'New Sales'),
  customWork('CUSTOMIZATION', 'New Customization Work'),
  ask('ASK_EVERY_TIME', 'Ask every time');

  const AddButtonDefaultAction(this.value, this.label);

  final String value;
  final String label;

  /// Convert from string to AddButtonDefaultAction enum
  static AddButtonDefaultAction fromString(String? value) {
    if (value == null) {
      return AddButtonDefaultAction.booking;
    }
    return AddButtonDefaultAction.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => AddButtonDefaultAction.booking,
    );
  }

  static AddButtonDefaultAction fromJson(String? value) {
    if (value == null) {
      return AddButtonDefaultAction.booking;
    }
    return AddButtonDefaultAction.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AddButtonDefaultAction.booking,
    );
  }

  String toJson() => value;

  static List<AddButtonDefaultAction> without(AddButtonDefaultAction action) =>
      AddButtonDefaultAction.values.where((e) => e != action).toList();

  bool get isBooking => this == AddButtonDefaultAction.booking;
  bool get isSales => this == AddButtonDefaultAction.sales;
  bool get isCustomWork => this == AddButtonDefaultAction.customWork;
  bool get isAsk => this == AddButtonDefaultAction.ask;
}

/// Extension methods for nullable AddButtonDefaultAction enum
// extension AddButtonDefaultActionX on AddButtonDefaultAction? {
//   bool get isBooking => this == AddButtonDefaultAction.booking;
//   bool get isSales => this == AddButtonDefaultAction.sales;
//   bool get isCustomWork => this == AddButtonDefaultAction.customWork;
//   bool get isAsk => this == AddButtonDefaultAction.ask;
// }

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

/// Extension methods for nullable AppMainFeatureType enum
// extension AppMainFeatureTypeX on AppMainFeatureType? {
//   bool get isBookings => this == AppMainFeatureType.bookings;
//   bool get isSales => this == AppMainFeatureType.sales;
// }
