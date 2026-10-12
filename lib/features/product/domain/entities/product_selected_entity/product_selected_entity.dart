import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_shared/core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_selected_entity.freezed.dart';

@freezed
abstract class ProductSelectedEntity with _$ProductSelectedEntity {
  const factory ProductSelectedEntity({
    required ProductInfoEntity variant,
    required int amount,

    /// Who the measurements were taken for: one entry per person, up to
    /// [quantity]. A single unnamed entry is the plain, one-set case.
    @Default([]) List<PersonMeasurementsEntity> peopleMeasurements,
    required int quantity,
    String? runningKilometers,
  }) = _ProductSelectedEntity;
}
