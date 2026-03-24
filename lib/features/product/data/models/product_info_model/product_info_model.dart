import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/booking/data/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_info_model.freezed.dart';
part 'product_info_model.g.dart';

dynamic _idCustomRead(Map json, String key) => json[key] ?? json['product_id'];

List<MeasurementValueModel> _parseMeasurements(dynamic json) {
  if (json is Map<String, dynamic>) {
    return json.entries
        .map(
          (entry) => MeasurementValueModel(
            name: entry.key.capitalizeFirstLetter(), // optional
            key: entry.key.toLowerCase().replaceAll(' ', '_'),
            value: entry.value.toString(),
          ),
        )
        .toList();
  }
  return [];
}

@freezed
abstract class ProductInfoModel with _$ProductInfoModel {
  const factory ProductInfoModel({
    @JsonKey(name: 'id', readValue: _idCustomRead) required int id,
    @JsonKey(name: 'product_id') required int? productId,
    @JsonKey(name: 'variant_id') required int? variantId,
    @JsonKey(name: 'product_name') required String name,
    @JsonKey(name: 'product_thumbnail', defaultValue: '')
    required String? image,
    @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
    MainServiceType? mainServiceType,
    @JsonKey(name: 'variant_attribute') String? variantAttribute,
    String? color,
    String? category,
    String? model,
    required int quantity,
    @JsonKey(defaultValue: 0) required int amount,
    @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
    @Default(const [])
    List<MeasurementValueModel> measurements,
    // Available stock from the variant
    int? stock,
    @JsonKey(name: 'remaining_stock') int? remainingStock,
  }) = _ProductInfoModel;

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoModelFromJson(json);

  factory ProductInfoModel.fromEntity(ProductInfoEntity entity) =>
      ProductInfoModel(
        id: entity.id,
        productId: entity.productId,
        variantId: entity.variantId,
        name: entity.name,
        image: entity.image,
        mainServiceType: entity.mainServiceType,
        variantAttribute: entity.variantAttribute,
        color: entity.color,
        category: entity.category,
        model: entity.model,
        quantity: entity.quantity,
        amount: entity.amount,
        measurements: entity.measurements.map((e) => e.toModel()).toList(),
        stock: entity.stock,
        remainingStock: entity.remainingStock,
      );
}

extension ProductInfoModelMapper on ProductInfoModel {
  ProductInfoEntity toEntity() => ProductInfoEntity(
    id: id,
    productId: productId,
    variantId: variantId,
    name: name,
    image: image,
    mainServiceType: mainServiceType,
    variantAttribute: variantAttribute,
    color: color,
    category: category,
    model: model,
    quantity: quantity,
    amount: amount,
    measurements: measurements.map((e) => e.toEntity()).toList(),
    stock: stock,
    remainingStock: remainingStock,
  );
}
