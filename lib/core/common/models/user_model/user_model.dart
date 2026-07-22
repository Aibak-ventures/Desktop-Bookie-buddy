import 'package:bookie_buddy_web/core/common/models/user_feature_details_model/user_feature_details_model.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/core/common/models/shop_settings_model/shop_settings_model.dart';
import 'package:bookie_buddy_web/core/common/models/user_shop_model/user_shop_model.dart';
import 'package:bookie_buddy_web/core/constants/enums/subscription_status_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

List<UserPasswordSettingsModel> _passwordSettingsFromJson(List<dynamic> json) {
  final List<UserPasswordSettingsModel> passwordSettings = [];
  if (json.isEmpty) {
    return passwordSettings;
  }

  for (final s in json) {
    final settings = UserPasswordSettingsModel.fromJson(
      s as Map<String, dynamic>,
    );
    if (settings.location == null) continue; // Skip unknown locations
    passwordSettings.add(settings);
  }

  return passwordSettings;
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    @JsonKey(name: 'full_name') required String firstName,
    @JsonKey(name: 'last_name', defaultValue: '') required String lastName,
    required String phone,
    @JsonKey(defaultValue: '') required String email,
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

@freezed
abstract class UserSubscriptionModel with _$UserSubscriptionModel {
  const factory UserSubscriptionModel({
    required String plan,
    @JsonKey(
      name: 'status',
      fromJson: SubscriptionStatus.fromJson,
      toJson: SubscriptionStatus.toJson,
    )
    required SubscriptionStatus status,
    @JsonKey(name: 'expiry_date', defaultValue: '') required String expiryDate,
    @JsonKey(name: 'days_remaining', defaultValue: 0)
    required int daysRemaining,
    @JsonKey(
      name: 'user_features',
      defaultValue: const {},
      fromJson: AppPremiumFeatures.fromList,
      toJson: AppPremiumFeatures.toJsonList,
    )
    required Set<AppPremiumFeatures> userSpecificFeatures,
    @JsonKey(name: 'features_details', defaultValue: const [])
    required List<UserFeatureDetailsModel> userFeatureDetails,
  }) = _UserSubscriptionModel;

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionModelFromJson(json);
}

@freezed
abstract class UserPasswordSettingsModel with _$UserPasswordSettingsModel {
  const factory UserPasswordSettingsModel({
    @JsonKey(
      name: 'setting_name',
      fromJson: SecretPasswordLocations.fromString,
      toJson: SecretPasswordLocations.toJson,
    )
    SecretPasswordLocations? location,
    @JsonKey(
      name: 'requires_password_for',
      fromJson: UserPasswordSettingRole.fromString,
      toJson: UserPasswordSettingRole.toJson,
    )
    required UserPasswordSettingRole role,
    @JsonKey(name: 'description') @Default('') String description,
  }) = _UserPasswordSettingsModel;

  factory UserPasswordSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserPasswordSettingsModelFromJson(json);
}

extension UserPasswordSettingsModelMapper on UserPasswordSettingsModel {
  UserPasswordSettingsEntity toEntity() =>
      UserPasswordSettingsEntity(location: location, role: role);
}

extension UserSubscriptionModelMapper on UserSubscriptionModel {
  UserSubscriptionEntity toEntity() => UserSubscriptionEntity(
    plan: plan,
    status: status,
    expiryDate: expiryDate,
    daysRemaining: daysRemaining,
    features: userFeatureDetails.map((e) => e.feature).toSet(),
    userSpecificFeatures: userSpecificFeatures,
    userFeatureDetails: userFeatureDetails.map((e) => e.toEntity()).toList(),
  );
}

extension UserModelMapper on UserModel {
  UserEntity toEntity() => UserEntity(
    id: id,
    firstName: firstName,
    lastName: lastName,
    phone: phone,
    email: email,
    block: block,
    haveMultipleShops: haveMultipleShops,
    isNotificationActive: isNotificationActive,
    subscription: subscription?.toEntity(),
    passwordSettings: passwordSettings.map((e) => e.toEntity()).toList(),
    shopSettings: shopSettings.toEntity(),
    shopDetails: shopDetails.toEntity(),
  );
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
    forEach((e) {
      if (e.location != null) {
        data.addAll({e.location!.value: e.role.value});
      }
    });
    return data;
  }
}
