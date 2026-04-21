import 'package:bookie_buddy_web/features/product/data/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_selected_model.freezed.dart';
part 'product_selected_model.g.dart';

@freezed
abstract class ProductSelectedModel with _$ProductSelectedModel {
  const factory ProductSelectedModel({
    required ProductInfoModel variant,
    required int amount,
    @Default([]) List<MeasurementValueModel> measurements,
    required int quantity,
    String? runningKilometers, // For vehicles - start and end km
  }) = _ProductSelectedModel;

  factory ProductSelectedModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSelectedModelFromJson(json);

  factory ProductSelectedModel.fromEntity(ProductSelectedEntity entity) =>
      ProductSelectedModel(
        variant: ProductInfoModel.fromEntity(entity.variant),
        amount: entity.amount,
        measurements: entity.measurements.map((e) => e.toModel()).toList(),
        quantity: entity.quantity,
        runningKilometers: entity.runningKilometers,
      );
}

extension ProductSelectedModelMapper on ProductSelectedModel {
  ProductSelectedEntity toEntity() => ProductSelectedEntity(
    variant: variant.toEntity(),
    amount: amount,
    measurements: measurements.map((e) => e.toEntity()).toList(),
    quantity: quantity,
    runningKilometers: runningKilometers,
  );
}

extension ProductSelectedEntityMapper on ProductSelectedEntity {
  ProductSelectedModel toModel() => ProductSelectedModel(
    variant: ProductInfoModel.fromEntity(variant),
    amount: amount,
    measurements: measurements.map((e) => e.toModel()).toList(),
    quantity: quantity,
    runningKilometers: runningKilometers,
  );
}

extension ProductSelectedModelToJsonExtension on ProductSelectedModel {
  Map<String, dynamic> toCustomJson({bool includeMeasurement = true}) {
    final measurementMap = <String, dynamic>{};
    if (includeMeasurement)
      for (final m in measurements) {
        // Use m.key (snake_case backend key) not m.name (display label)
        if (m.key != 'running_kilometers') {
          measurementMap[m.key] = m.value;
        }
      }

    // Add running kilometers inside measurements — always include if present
    if (includeMeasurement &&
        runningKilometers != null &&
        runningKilometers!.isNotEmpty) {
      measurementMap['running_kilometers'] = runningKilometers;
    }

    final json = <String, dynamic>{
      'id': variant.variantId,
      'amount': amount * quantity,
      'quantity': quantity,
    };

    // Add measurements if included and not empty
    if (includeMeasurement && measurementMap.isNotEmpty) {
      json['measurements'] = measurementMap;
    }

    return json;
  }
}

// import 'dart:convert';

// import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
// import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';

// class ProductSelectedModel {
//   final ProductInfoModel variant;
//   final int amount;
//   final List<MeasurementValueModel> measurements;
//   final int quantity;
//   ProductSelectedModel({
//     required this.variant,
//     required this.amount,
//     this.measurements = const [],
//   });

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (measurements.isNotEmpty) {
//       measurements.forEach(
//         (m) {
//           map[m.name] = m.value;
//         },
//       );
//     }
//     return <String, dynamic>{
//       'id': variant.variantId,
//       'amount': amount,
//       'measurements': map,
//     };
//   }

//   factory ProductSelectedModel.fromMap(Map<String, dynamic> map) {
//     return ProductSelectedModel(
//       variant:
//           ProductInfoModel.fromJson(map['product'] as Map<String, dynamic>),
//       amount: map['amount'] as int,
//       // measurements: map['measurements'] is List<MeasurementValueModel>
//       //     ? map['measurements']
//       //     : [],
//     );
//   }

//   factory ProductSelectedModel.fromJson(String source) =>
//       ProductSelectedModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() =>
//       'ProductSelectedModel(variant: $variant, amount: $amount)';
// }
