import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart'
    show SecretPasswordLocations, UserPasswordSettingRole;
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart' hide UserPasswordSettingRole;
import 'package:bookie_buddy_web/core/models/shop_settings_model/shop_settings_model.dart';
import 'package:bookie_buddy_web/core/models/user_shop_model/user_shop_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

List<UserPasswordSettingsModel> _passwordSettingsFromJson(
  Map<dynamic, dynamic> json,
) {
  final List<UserPasswordSettingsModel> settings = [];
  if (json.isEmpty) {
    return settings;
  }

  json.forEach((key, value) {
    final location = SecretPasswordLocations.fromString(key);
    if (location == null) return; // Skip unknown locations
    settings.add(
      UserPasswordSettingsModel(
        location: location,
        role: UserPasswordSettingRole.fromString(value),
      ),
    );
  });
  return settings;
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    @JsonKey(name: 'full_name') required String firstName,
    @JsonKey(name: 'last_name', defaultValue: '') required String lastName,
    required String phone,
    @JsonKey(name: 'role', fromJson: ShopRole.fromJson) ShopRole? role,
    @JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson)
    ShopRole? shopRole,
    @JsonKey(defaultValue: false) required bool block,
    @JsonKey(name: 'multiple_shops', defaultValue: false)
    required bool haveMultipleShops,
    @JsonKey(name: 'has_active_notification', defaultValue: false)
    required bool isNotificationActive,
    @JsonKey(name: 'subscription') UserSubscriptionModel? subscription,
    @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
    required List<UserPasswordSettingsModel> passwordSettings,
    @JsonKey(name: 'shop_settings') required ShopSettingsModel shopSettings,
    @JsonKey(name: 'shop') required UserShopModel shopDetails,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  String get userFullName => '$firstName $lastName'.trim();

  /// Check if user has a specific premium feature
  bool hasFeature(AppPremiumFeatures feature) {
    return subscription?.features.contains(feature.name.toUpperCase()) ??
        false;
  }
}

@freezed
class UserSubscriptionModel with _$UserSubscriptionModel {
  const factory UserSubscriptionModel({
    required String plan,
    required String status,
    @JsonKey(name: 'expiry_date', defaultValue: '') required String expiryDate,
    @JsonKey(
      name: 'features',
      defaultValue: const {},
      fromJson: AppPremiumFeatures.fromList,
      toJson: AppPremiumFeatures.toJsonList,
    )
    required Set<AppPremiumFeatures> features,
    @JsonKey(
      name: 'user_features',
      defaultValue: const {},
      fromJson: AppPremiumFeatures.fromList,
      toJson: AppPremiumFeatures.toJsonList,
    )
    required Set<AppPremiumFeatures> userSpecificFeatures,
  }) = _UserSubscriptionModel;

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionModelFromJson(json);
}

@freezed
class UserPasswordSettingsModel with _$UserPasswordSettingsModel {
  const factory UserPasswordSettingsModel({
    required SecretPasswordLocations location,
    required UserPasswordSettingRole role,
  }) = _UserPasswordSettingsModel;

  factory UserPasswordSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserPasswordSettingsModelFromJson(json);
}

extension UserPasswordSettingsModelX on List<UserPasswordSettingsModel> {
  /// Converts the list of UserPasswordSettingsModel to a custom JSON format.
  ///
  /// Example:
  /// ```
  /// {
  ///    "LEDGER_VIEW": "ALL",
  ///    "BOOKING_DELETE": "ALL",
  ///    "BOOKING_EDIT": "NONE",
  ///    "BOOKING_PAYMENT": "ALL",
  ///    "TRANSFER_PRODUCT": "ALL"
  /// }
  /// ```
  ///
  Map<String, dynamic> toCustomJson() {
    final Map<String, dynamic> data = {};
    forEach((e) => data.addAll({e.location.value: e.role.value}));
    return data;
  }
}
