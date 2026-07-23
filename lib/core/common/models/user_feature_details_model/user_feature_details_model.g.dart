// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feature_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserFeatureDetailsModel _$UserFeatureDetailsModelFromJson(
  Map<String, dynamic> json,
) => _UserFeatureDetailsModel(
  displayName: json['name'] as String? ?? '',
  feature: AppPremiumFeatures.fromJson(json['code'] as String?),
  status: FeatureSubscriptionStatus.fromJson(json['status'] as String?),
);

Map<String, dynamic> _$UserFeatureDetailsModelToJson(
  _UserFeatureDetailsModel instance,
) => <String, dynamic>{
  'name': instance.displayName,
  'code': AppPremiumFeatures.toJson(instance.feature),
  'status': FeatureSubscriptionStatus.toJson(instance.status),
};
