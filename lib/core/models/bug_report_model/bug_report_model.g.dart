// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bug_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BugReportModelImpl _$$BugReportModelImplFromJson(Map<String, dynamic> json) =>
    _$BugReportModelImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      moreDetails: json['moreDetails'] as Map<String, dynamic>? ?? const {},
      image1: json['image1'] as String?,
      image2: json['image2'] as String?,
    );

Map<String, dynamic> _$$BugReportModelImplToJson(
        _$BugReportModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'moreDetails': instance.moreDetails,
      'image1': instance.image1,
      'image2': instance.image2,
    };
