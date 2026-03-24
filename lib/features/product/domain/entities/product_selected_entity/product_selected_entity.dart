import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_selected_entity.freezed.dart';

@freezed
abstract class ProductSelectedEntity with _$ProductSelectedEntity {
  const factory ProductSelectedEntity({
    required ProductInfoEntity variant,
    required int amount,
    @Default([]) List<MeasurementValueEntity> measurements,
    required int quantity,
    String? runningKilometers,
  }) = _ProductSelectedEntity;
}
