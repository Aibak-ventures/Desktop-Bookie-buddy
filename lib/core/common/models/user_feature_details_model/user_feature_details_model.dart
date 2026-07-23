import 'package:bookie_buddy_web/core/common/entities/user_feature_details_entity/user_feature_details_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/feature_subscription_status_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_feature_details_model.freezed.dart';
part 'user_feature_details_model.g.dart';

@freezed
abstract class UserFeatureDetailsModel with _$UserFeatureDetailsModel {
  const factory UserFeatureDetailsModel({
    @JsonKey(name: 'name', defaultValue: '') required String displayName,
    @JsonKey(
      name: 'code',
      fromJson: AppPremiumFeatures.fromJson,
      toJson: AppPremiumFeatures.toJson,
    )
    required AppPremiumFeatures feature,
    @JsonKey(
      name: 'status',
      fromJson: FeatureSubscriptionStatus.fromJson,
      toJson: FeatureSubscriptionStatus.toJson,
    )
    required FeatureSubscriptionStatus status,
  }) = _UserFeatureDetailsModel;

  factory UserFeatureDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserFeatureDetailsModelFromJson(json);
}

extension UserFeatureDetailsModelMapper on UserFeatureDetailsModel {
  UserFeatureDetailsEntity toEntity() => UserFeatureDetailsEntity(
    displayName: displayName,
    feature: feature,
    status: status,
  );
}
