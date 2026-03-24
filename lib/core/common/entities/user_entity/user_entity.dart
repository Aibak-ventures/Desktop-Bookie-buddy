import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart'
    show SecretPasswordLocations, UserPasswordSettingRole;
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart'
    hide UserPasswordSettingRole;
import 'package:bookie_buddy_web/core/common/entities/shop_settings_entity/shop_settings_entity.dart';
import 'package:bookie_buddy_web/core/common/entities/user_shop_entity/user_shop_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    ShopRole? role,
    ShopRole? shopRole,
    required bool block,
    required bool haveMultipleShops,
    required bool isNotificationActive,
    UserSubscriptionEntity? subscription,
    required List<UserPasswordSettingsEntity> passwordSettings,
    required ShopSettingsEntity shopSettings,
    required UserShopEntity shopDetails,
  }) = _UserEntity;
}

extension UserEntityX on UserEntity {
  String get userFullName => '$firstName $lastName'.trim();

  bool hasFeature(AppPremiumFeatures feature) {
    return subscription?.features.contains(feature) ?? false;
  }
}

@freezed
abstract class UserSubscriptionEntity with _$UserSubscriptionEntity {
  const factory UserSubscriptionEntity({
    required String plan,
    required String status,
    required String expiryDate,
    required Set<AppPremiumFeatures> features,
    required Set<AppPremiumFeatures> userSpecificFeatures,
  }) = _UserSubscriptionEntity;
}

@freezed
abstract class UserPasswordSettingsEntity with _$UserPasswordSettingsEntity {
  const factory UserPasswordSettingsEntity({
    required SecretPasswordLocations location,
    required UserPasswordSettingRole role,
  }) = _UserPasswordSettingsEntity;
}

extension UserPasswordSettingsEntityX on List<UserPasswordSettingsEntity> {
  Map<String, dynamic> toCustomJson() {
    final Map<String, dynamic> data = {};
    forEach((e) => data.addAll({e.location.value: e.role.value}));
    return data;
  }
}
