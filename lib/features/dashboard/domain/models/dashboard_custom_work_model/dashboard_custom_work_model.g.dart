// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_custom_work_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardCustomWorkModelImpl _$$DashboardCustomWorkModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardCustomWorkModelImpl(
      id: (json['id'] as num).toInt(),
      tailorName: json['tailor_name'] as String,
      pickupDate: json['pickup_date'] as String,
      status: CustomizationWorkStatus.fromString(json['status'] as String?),
      products: json['products'] as String,
      staffColor: json['staff_color'] as String?,
    );

Map<String, dynamic> _$$DashboardCustomWorkModelImplToJson(
        _$DashboardCustomWorkModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tailor_name': instance.tailorName,
      'pickup_date': instance.pickupDate,
      'status': CustomizationWorkStatus.toJson(instance.status),
      'products': instance.products,
      'staff_color': instance.staffColor,
    };
