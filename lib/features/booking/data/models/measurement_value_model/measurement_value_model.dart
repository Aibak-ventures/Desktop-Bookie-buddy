import 'package:bookie_buddy_web/core/constants/enums/gender_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
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

extension MeasurementValueModelMapper on MeasurementValueModel {
  MeasurementValueEntity toEntity() => MeasurementValueEntity(
    name: name,
    key: key,
    value: value,
    gender: gender,
  );
}

extension MeasurementValueEntityMapper on MeasurementValueEntity {
  MeasurementValueModel toModel() => MeasurementValueModel(
    name: name,
    key: key,
    value: value,
    gender: gender,
  );
}
