// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CarouselDataModel _$CarouselDataModelFromJson(Map<String, dynamic> json) =>
    _CarouselDataModel(
      upComingCount: (json['upcoming_count'] as num?)?.toInt() ?? 0,
      completedCount: (json['completed_count'] as num?)?.toInt() ?? 0,
      expiredCount: (json['expired_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CarouselDataModelToJson(_CarouselDataModel instance) =>
    <String, dynamic>{
      'upcoming_count': instance.upComingCount,
      'completed_count': instance.completedCount,
      'expired_count': instance.expiredCount,
    };
