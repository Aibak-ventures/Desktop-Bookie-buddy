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
  role: ShopRole.fromJson(json['role'] as String?),
  shopRole: ShopRole.fromJson(json['shop_role'] as String?),
  block: json['block'] as bool? ?? false,
  haveMultipleShops: json['multiple_shops'] as bool? ?? false,
  isNotificationActive: json['has_active_notification'] as bool? ?? false,
  subscription: json['subscription'] == null
      ? null
      : UserSubscriptionModel.fromJson(
          json['subscription'] as Map<String, dynamic>,
        ),
  passwordSettings: _passwordSettingsFromJson(json['password_settings'] as Map),
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
      'role': instance.role,
      'shop_role': instance.shopRole,
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
  status: json['status'] as String,
  expiryDate: json['expiry_date'] as String? ?? '',
  features: json['features'] == null
      ? {}
      : AppPremiumFeatures.fromList(json['features'] as List?),
  userSpecificFeatures: json['user_features'] == null
      ? {}
      : AppPremiumFeatures.fromList(json['user_features'] as List?),
);

Map<String, dynamic> _$UserSubscriptionModelToJson(
  _UserSubscriptionModel instance,
) => <String, dynamic>{
  'plan': instance.plan,
  'status': instance.status,
  'expiry_date': instance.expiryDate,
  'features': AppPremiumFeatures.toJsonList(instance.features),
  'user_features': AppPremiumFeatures.toJsonList(instance.userSpecificFeatures),
};

_UserPasswordSettingsModel _$UserPasswordSettingsModelFromJson(
  Map<String, dynamic> json,
) => _UserPasswordSettingsModel(
  location: $enumDecode(_$SecretPasswordLocationsEnumMap, json['location']),
  role: $enumDecode(_$UserPasswordSettingRoleEnumMap, json['role']),
);

Map<String, dynamic> _$UserPasswordSettingsModelToJson(
  _UserPasswordSettingsModel instance,
) => <String, dynamic>{
  'location': _$SecretPasswordLocationsEnumMap[instance.location]!,
  'role': _$UserPasswordSettingRoleEnumMap[instance.role]!,
};

const _$SecretPasswordLocationsEnumMap = {
  SecretPasswordLocations.ledgerView: 'ledgerView',
  SecretPasswordLocations.bookingEdit: 'bookingEdit',
  SecretPasswordLocations.bookingDelete: 'bookingDelete',
  SecretPasswordLocations.bookingPayment: 'bookingPayment',
  SecretPasswordLocations.transferProduct: 'transferProduct',
  SecretPasswordLocations.monthlyGrossView: 'monthlyGrossView',
  SecretPasswordLocations.productDeletion: 'productDeletion',
  SecretPasswordLocations.productEdit: 'productEdit',
};

const _$UserPasswordSettingRoleEnumMap = {
  UserPasswordSettingRole.all: 'all',
  UserPasswordSettingRole.none: 'none',
  UserPasswordSettingRole.staff: 'staff',
  UserPasswordSettingRole.managerAndStaff: 'managerAndStaff',
};
