import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();
  
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
    @JsonKey(name: 'sale_price') String? salePrice,
    // Vehicle-specific fields (for direct API responses or request models)
    @JsonKey(name: 'registration_number') String? registrationNumber,
    @JsonKey(name: 'pollution_expiry') String? pollutionExpiry,
    @JsonKey(name: 'insurance_expiry') String? insuranceExpiry,
    @JsonKey(name: 'fitness_expiry') String? fitnessExpiry,
    @JsonKey(name: 'barcode') String? barcode,
    // Attributes map for nested vehicle data from list API
    @Default({}) Map<String, dynamic> attributes,
    @JsonKey(name: 'variants') required List<ProductVariantModel> variants,
  }) = _ProductModel;

  // Custom getters to read from attributes if direct fields are null
  String? get effectiveRegistrationNumber =>
      registrationNumber ?? attributes['registration_number'] as String?;
  
  String? get effectivePollutionExpiry =>
      pollutionExpiry ?? attributes['pollution_expiry'] as String?;
  
  String? get effectiveInsuranceExpiry =>
      insuranceExpiry ?? attributes['insurance_expiry'] as String?;
  
  // API uses 'permit_expiry' but we call it fitness/permit expiry
  String? get effectiveFitnessExpiry =>
      fitnessExpiry ?? attributes['permit_expiry'] as String? ?? attributes['fitness_expiry'] as String?;
  
  String? get effectiveBarcode =>
      barcode ?? attributes['barcode'] as String?;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
