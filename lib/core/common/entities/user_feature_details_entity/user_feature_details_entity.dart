import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/feature_subscription_status_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_feature_details_entity.freezed.dart';

@freezed
abstract class UserFeatureDetailsEntity with _$UserFeatureDetailsEntity {
  const factory UserFeatureDetailsEntity({
    required String displayName,
    required AppPremiumFeatures feature,
    required FeatureSubscriptionStatus status,
  }) = _UserFeatureDetailsEntity;
}
