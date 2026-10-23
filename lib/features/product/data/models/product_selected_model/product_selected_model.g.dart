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
  peopleMeasurements: json['measurements'] == null
      ? const []
      : PersonMeasurementsModel.fromCustomJson(json['measurements']),
  quantity: (json['quantity'] as num).toInt(),
  runningKilometers: json['runningKilometers'] as String?,
);

Map<String, dynamic> _$ProductSelectedModelToJson(
  _ProductSelectedModel instance,
) => <String, dynamic>{
  'variant': instance.variant,
  'amount': instance.amount,
  'measurements': PersonMeasurementsModel.toCustomJson(
    instance.peopleMeasurements,
  ),
  'quantity': instance.quantity,
  'runningKilometers': instance.runningKilometers,
};
