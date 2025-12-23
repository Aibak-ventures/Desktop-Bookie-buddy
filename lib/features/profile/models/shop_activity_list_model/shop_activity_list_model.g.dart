// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_activity_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopActivityListModelImpl _$$ShopActivityListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ShopActivityListModelImpl(
      activities: (json['activities'] as List<dynamic>)
          .map((e) => ShopActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ShopActivityListModelImplToJson(
        _$ShopActivityListModelImpl instance) =>
    <String, dynamic>{
      'activities': instance.activities,
      'next': instance.nextPageUrl,
      'count': instance.count,
    };
