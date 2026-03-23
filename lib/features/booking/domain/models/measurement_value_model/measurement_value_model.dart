import 'package:bookie_buddy_web/core/constants/enums/gender_type_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement_value_model.freezed.dart';
part 'measurement_value_model.g.dart';

@freezed
abstract class MeasurementValueModel with _$MeasurementValueModel {
  const factory MeasurementValueModel({
    required String name,
    required String key,
    required String value,
    GenderType? gender,
  }) = _MeasurementValueModel;

  // factory MeasurementValueModel.fromJson(Map<String, dynamic> json) {
  //   final first = json.entries.first;
  //   return MeasurementValueModel(
  //     name: first.key,
  //     key: first.key.toLowerCase().replaceAll(' ', '_'),
  //     value: first.value,
  //     gender: null,
  //   );
  // }
  factory MeasurementValueModel.fromJson(Map<String, dynamic> json) =>
      _$MeasurementValueModelFromJson(json);
}
