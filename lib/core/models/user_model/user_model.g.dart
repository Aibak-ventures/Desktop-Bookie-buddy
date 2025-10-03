// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      firstName: json['full_name'] as String,
      lastName: json['last_name'] as String? ?? '',
      phone: json['phone'] as String,
      shopRole: ShopRole.fromString(json['shop_role'] as String?),
      block: json['block'] as bool? ?? false,
      haveMultipleShops: json['multiple_shops'] as bool? ?? false,
      isNotificationActive: json['has_active_notification'] as bool? ?? false,
      subscription: json['subscription'] == null
          ? null
          : UserSubscriptionModel.fromJson(
              json['subscription'] as Map<String, dynamic>,
            ),
      passwordSettings: _passwordSettingsFromJson(
        json['password_settings'] as Map,
      ),
      shopSettings: ShopSettingsModel.fromJson(
        json['shop_settings'] as Map<String, dynamic>,
      ),
      shopDetails: UserShopModel.fromJson(json['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'shop_role': _$ShopRoleEnumMap[instance.shopRole],
      'block': instance.block,
      'multiple_shops': instance.haveMultipleShops,
      'has_active_notification': instance.isNotificationActive,
      'subscription': instance.subscription,
      'password_settings': instance.passwordSettings,
      'shop_settings': instance.shopSettings,
      'shop': instance.shopDetails,
    };

const _$ShopRoleEnumMap = {
  ShopRole.owner: 'owner',
  ShopRole.manager: 'manager',
  ShopRole.staff: 'staff',
};

_$UserSubscriptionModelImpl _$$UserSubscriptionModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserSubscriptionModelImpl(
  plan: json['plan'] as String,
  status: json['status'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$UserSubscriptionModelImplToJson(
  _$UserSubscriptionModelImpl instance,
) => <String, dynamic>{
  'plan': instance.plan,
  'status': instance.status,
  'features': instance.features,
};

_$UserPasswordSettingsModelImpl _$$UserPasswordSettingsModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserPasswordSettingsModelImpl(
  location: $enumDecode(_$SecretPasswordLocationsEnumMap, json['location']),
  role: $enumDecode(_$UserPasswordSettingRoleEnumMap, json['role']),
);

Map<String, dynamic> _$$UserPasswordSettingsModelImplToJson(
  _$UserPasswordSettingsModelImpl instance,
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
};

const _$UserPasswordSettingRoleEnumMap = {
  UserPasswordSettingRole.all: 'all',
  UserPasswordSettingRole.none: 'none',
  UserPasswordSettingRole.staff: 'staff',
  UserPasswordSettingRole.managerAndStaff: 'managerAndStaff',
};
