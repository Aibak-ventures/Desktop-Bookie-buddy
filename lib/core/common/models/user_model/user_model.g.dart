// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num).toInt(),
  firstName: json['full_name'] as String,
  lastName: json['last_name'] as String? ?? '',
  phone: json['phone'] as String,
  email: json['email'] as String? ?? '',
  block: json['block'] as bool? ?? false,
  haveMultipleShops: json['multiple_shops'] as bool? ?? false,
  isNotificationActive: json['has_active_notification'] as bool? ?? false,
  subscription: json['subscription'] == null
      ? null
      : UserSubscriptionModel.fromJson(
          json['subscription'] as Map<String, dynamic>,
        ),
  passwordSettings: _passwordSettingsFromJson(
    json['password_settings'] as List,
  ),
  shopSettings: ShopSettingsModel.fromJson(
    json['shop_settings'] as Map<String, dynamic>,
  ),
  shopDetails: UserShopModel.fromJson(json['shop'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'block': instance.block,
      'multiple_shops': instance.haveMultipleShops,
      'has_active_notification': instance.isNotificationActive,
      'subscription': instance.subscription,
      'password_settings': instance.passwordSettings,
      'shop_settings': instance.shopSettings,
      'shop': instance.shopDetails,
    };

_UserSubscriptionModel _$UserSubscriptionModelFromJson(
  Map<String, dynamic> json,
) => _UserSubscriptionModel(
  plan: json['plan'] as String,
  status: SubscriptionStatus.fromJson(json['status'] as String?),
  expiryDate: json['expiry_date'] as String? ?? '',
  daysRemaining: (json['days_remaining'] as num?)?.toInt() ?? 0,
  userSpecificFeatures: json['user_features'] == null
      ? {}
      : AppPremiumFeatures.fromList(json['user_features'] as List?),
  userFeatureDetails:
      (json['features_details'] as List<dynamic>?)
          ?.map(
            (e) => UserFeatureDetailsModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$UserSubscriptionModelToJson(
  _UserSubscriptionModel instance,
) => <String, dynamic>{
  'plan': instance.plan,
  'status': SubscriptionStatus.toJson(instance.status),
  'expiry_date': instance.expiryDate,
  'days_remaining': instance.daysRemaining,
  'user_features': AppPremiumFeatures.toJsonList(instance.userSpecificFeatures),
  'features_details': instance.userFeatureDetails,
};

_UserPasswordSettingsModel _$UserPasswordSettingsModelFromJson(
  Map<String, dynamic> json,
) => _UserPasswordSettingsModel(
  location: SecretPasswordLocations.fromString(json['setting_name'] as String?),
  role: UserPasswordSettingRole.fromString(
    json['requires_password_for'] as String?,
  ),
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$UserPasswordSettingsModelToJson(
  _UserPasswordSettingsModel instance,
) => <String, dynamic>{
  'setting_name': SecretPasswordLocations.toJson(instance.location),
  'requires_password_for': UserPasswordSettingRole.toJson(instance.role),
  'description': instance.description,
};
