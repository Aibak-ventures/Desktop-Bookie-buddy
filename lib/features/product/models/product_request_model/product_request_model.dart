import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'product_request_model.freezed.dart';
part 'product_request_model.g.dart';

List<Map<String, dynamic>>? _variantsToJson(
        List<ProductVariantModel>? variants) =>
    variants
        ?.map(
          (e) => e.toJsonOnly(),
        )
        .toList();

@freezed
class ProductRequestModel with _$ProductRequestModel {
  const factory ProductRequestModel({
    @JsonKey(includeIfNull: false) int? productId,
    @JsonKey(name: 'shop_service_id', includeIfNull: false) int? serviceId,
    @JsonKey(includeIfNull: false) String? name,
    @JsonKey(includeIfNull: false) String? description,
    @JsonKey(includeIfNull: false) String? color,
    @JsonKey(name: 'purchase_price', includeIfNull: false) int? purchasePrice,
    @JsonKey(includeIfNull: false) int? price,
    @JsonKey(includeIfNull: false) String? category,
    @JsonKey(includeIfNull: false) String? model,
    @JsonKey(toJson: _variantsToJson, includeIfNull: false)
    List<ProductVariantModel>? variants,

    // Don't include this in auto-generated JSON
    @JsonKey(includeFromJson: false, includeToJson: false) XFile? image,
  }) = _ProductRequestModel;

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestModelFromJson(json);
}

extension ProductRequestModelExtension on ProductRequestModel {
  Future<Map<String, dynamic>> toFormJson([bool isAdding = true]) async {
    final json = toJson(); // generated JSON without image
    if (image != null) {
      final bytes = await image!.readAsBytes();
      json['image'] = MultipartFile.fromBytes(
        bytes,
        filename: image!.name,
      );
    }
    if (!isAdding) json.remove('variants');
    return json;
  }
}
