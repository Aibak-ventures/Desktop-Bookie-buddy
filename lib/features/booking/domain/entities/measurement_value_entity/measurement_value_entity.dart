import 'package:bookie_buddy_web/core/constants/enums/gender_type_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement_value_entity.freezed.dart';

@freezed
abstract class MeasurementValueEntity with _$MeasurementValueEntity {
  const factory MeasurementValueEntity({
    required String name,
    required String key,
    required String value,
    GenderType? gender,
  }) = _MeasurementValueEntity;
}
