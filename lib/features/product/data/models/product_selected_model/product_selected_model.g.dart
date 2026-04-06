// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_selected_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductSelectedModel _$ProductSelectedModelFromJson(
  Map<String, dynamic> json,
) => _ProductSelectedModel(
  variant: ProductInfoModel.fromJson(json['variant'] as Map<String, dynamic>),
  amount: (json['amount'] as num).toInt(),
  measurements:
      (json['measurements'] as List<dynamic>?)
          ?.map(
            (e) => MeasurementValueModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  quantity: (json['quantity'] as num).toInt(),
  runningKilometers: json['runningKilometers'] as String?,
);

Map<String, dynamic> _$ProductSelectedModelToJson(
  _ProductSelectedModel instance,
) => <String, dynamic>{
  'variant': instance.variant,
  'amount': instance.amount,
  'measurements': instance.measurements,
  'quantity': instance.quantity,
  'runningKilometers': instance.runningKilometers,
};
