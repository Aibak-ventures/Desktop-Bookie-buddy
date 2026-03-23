import 'package:bookie_buddy_web/features/product/domain/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/measurement_value_model/measurement_value_model.dart';
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
}

extension ProductSelectedModelToJsonExtension on ProductSelectedModel {
  Map<String, dynamic> toCustomJson({bool includeMeasurement = true}) {
    final measurementMap = <String, dynamic>{};
    if (includeMeasurement)
      for (final m in measurements) {
        measurementMap[m.name] = m.value;
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

    // Add running kilometers for vehicles if present
    if (runningKilometers != null && runningKilometers!.isNotEmpty) {
      json['running_kilometers'] = runningKilometers;
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
