import 'package:bookie_buddy_web/core/common/entities/user_feature_details_entity/user_feature_details_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/common/entities/shop_settings_entity/shop_settings_entity.dart';
import 'package:bookie_buddy_web/core/common/entities/user_shop_entity/user_shop_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/subscription_status_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
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
}

@freezed
abstract class UserSubscriptionEntity with _$UserSubscriptionEntity {
  const factory UserSubscriptionEntity({
    required String plan,
    required SubscriptionStatus status,
    required String expiryDate,
    required int daysRemaining,
    required Set<AppPremiumFeatures> features,
    required Set<AppPremiumFeatures> userSpecificFeatures,
    required List<UserFeatureDetailsEntity> userFeatureDetails,
  }) = _UserSubscriptionEntity;
}

@freezed
abstract class UserPasswordSettingsEntity with _$UserPasswordSettingsEntity {
  const factory UserPasswordSettingsEntity({
    required SecretPasswordLocations? location,
    required UserPasswordSettingRole role,
    @Default('') String description,
  }) = _UserPasswordSettingsEntity;
}

extension UserPasswordSettingsEntityX on List<UserPasswordSettingsEntity> {
  Map<String, dynamic> toCustomJson() {
    final Map<String, dynamic> data = {};
    forEach((e) {
      if (e.location == null) return;
      data.addAll({e.location!.value: e.role.value});
    });
    return data;
  }
}
