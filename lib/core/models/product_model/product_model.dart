import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String name,
    required String? description,
    @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
    MainServiceType? mainServiceType,
    String? color,
    String? model,
    String? image,
    @JsonKey(name: 'thumbnail_image') String? thumbnailImage,
    String? category,
    @JsonKey(name: 'purchase_price') int? purchaseAmount,
    @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'variants') required List<ProductVariantModel> variants,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
