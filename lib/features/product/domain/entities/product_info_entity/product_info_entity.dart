import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_info_entity.freezed.dart';

@freezed
abstract class ProductInfoEntity with _$ProductInfoEntity {
  const factory ProductInfoEntity({
    required int id,
    required int? productId,
    required int? variantId,
    required String name,
    required String? image,
    MainServiceType? mainServiceType,
    String? variantAttribute,
    String? color,
    String? category,
    String? model,
    required int quantity,
    required int amount,
    @Default([]) List<MeasurementValueEntity> measurements,
    int? stock,
    int? remainingStock,
  }) = _ProductInfoEntity;
}
