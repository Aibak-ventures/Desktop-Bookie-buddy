import 'package:bookie_buddy_shared/core/core/constants/measurement_constants.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_shared/core/features/booking/data/models/person_measurements_model/person_measurements_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_selected_model.freezed.dart';
part 'product_selected_model.g.dart';

@freezed
abstract class ProductSelectedModel with _$ProductSelectedModel {
  const factory ProductSelectedModel({
    required ProductInfoModel variant,
    required int amount,
    @JsonKey(
      name: MeasurementConstants.jsonKey,
      fromJson: PersonMeasurementsModel.fromCustomJson,
      toJson: PersonMeasurementsModel.toCustomJson,
    )
    @Default([])
    List<PersonMeasurementsModel> peopleMeasurements,
    required int quantity,
    String? runningKilometers, // For vehicles - start and end km
  }) = _ProductSelectedModel;

  factory ProductSelectedModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSelectedModelFromJson(json);

  factory ProductSelectedModel.fromEntity(ProductSelectedEntity entity) =>
      ProductSelectedModel(
        variant: ProductInfoModel.fromEntity(entity.variant),
        amount: entity.amount,
        peopleMeasurements: entity.peopleMeasurements
            .map(PersonMeasurementsModel.fromEntity)
            .toList(),
        quantity: entity.quantity,
        runningKilometers: entity.runningKilometers,
      );
}

extension ProductSelectedModelMapper on ProductSelectedModel {
  ProductSelectedEntity toEntity() => ProductSelectedEntity(
    variant: variant.toEntity(),
    amount: amount,
    peopleMeasurements: peopleMeasurements.map((e) => e.toEntity()).toList(),
    quantity: quantity,
    runningKilometers: runningKilometers,
  );
}

extension ProductSelectedEntityMapper on ProductSelectedEntity {
  ProductSelectedModel toModel() => ProductSelectedModel(
    variant: ProductInfoModel.fromEntity(variant),
    amount: amount,
    peopleMeasurements: peopleMeasurements
        .map(PersonMeasurementsModel.fromEntity)
        .toList(),
    quantity: quantity,
    runningKilometers: runningKilometers,
  );
}

extension ProductSelectedModelToJsonExtension on ProductSelectedModel {
  Map<String, dynamic> toCustomJson({bool includeMeasurement = true}) {
    final json = <String, dynamic>{
      'id': variant.variantId,
      'amount': amount * quantity,
      'quantity': quantity,
    };

    // Measurements and running kilometers are only sent when included and
    // not empty. Running kilometers travels beside the people.
    if (includeMeasurement) {
      final measurements = PersonMeasurementsModel.toCustomJson([
        for (final p in peopleMeasurements)
          if (p.measurements.isNotEmpty) p,
      ], runningKilometers: runningKilometers ?? '');
      if (measurements.isNotEmpty)
        json[MeasurementConstants.jsonKey] = measurements;
    }

    return json;
  }
}
