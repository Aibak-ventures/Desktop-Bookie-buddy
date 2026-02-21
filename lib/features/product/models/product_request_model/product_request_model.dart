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
    @JsonKey(name: 'sale_price', includeIfNull: false) int? salePrice,
    @JsonKey(includeIfNull: false) String? category,
    @JsonKey(includeIfNull: false) String? model,
    
    // Vehicle-specific fields - these won't be in JSON, handled separately in toFormJson
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? registrationNumber,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? pollutionExpiry,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? insuranceExpiry,
    @JsonKey(includeFromJson: false, includeToJson: false)
    String? fitnessExpiry,
    @JsonKey(includeFromJson: false, includeToJson: false) String? barcode,
    
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
    final json = toJson(); // generated JSON without image and vehicle fields

    print('🔧 toFormJson - isAdding: $isAdding');
    print('🔧 toFormJson - productId: $productId');
    print('🔧 toFormJson - image is null: ${image == null}');

    // Add vehicle-specific fields as attributes[field_name]
    if (registrationNumber != null && registrationNumber!.isNotEmpty) {
      json['attributes[registration_number]'] = registrationNumber;
      print('🔧 toFormJson - Added registration_number to attributes');
    }
    if (pollutionExpiry != null && pollutionExpiry!.isNotEmpty) {
      json['attributes[pollution_expiry]'] = _convertDateFormat(pollutionExpiry!);
      print('🔧 toFormJson - Added pollution_expiry to attributes: ${_convertDateFormat(pollutionExpiry!)}');
    }
    if (insuranceExpiry != null && insuranceExpiry!.isNotEmpty) {
      json['attributes[insurance_expiry]'] = _convertDateFormat(insuranceExpiry!);
      print('🔧 toFormJson - Added insurance_expiry to attributes: ${_convertDateFormat(insuranceExpiry!)}');
    }
    if (fitnessExpiry != null && fitnessExpiry!.isNotEmpty) {
      json['attributes[permit_expiry]'] = _convertDateFormat(fitnessExpiry!);
      print('🔧 toFormJson - Added permit_expiry to attributes: ${_convertDateFormat(fitnessExpiry!)}');
    }
    // Note: barcode is NOT added because it's not valid for Car Rentals service

    if (image != null) {
      try {
        final bytes = await image!.readAsBytes();
        print('🔧 toFormJson - Image bytes length: ${bytes.length}');
        print('🔧 toFormJson - Image filename: ${image!.name}');

        // Ensure we have a valid filename, fallback to timestamp if empty
        String filename = image!.name;
        if (filename.isEmpty || filename.trim().isEmpty) {
          filename = 'product_${DateTime.now().millisecondsSinceEpoch}.jpg';
          print('⚠️ toFormJson - Empty filename, using: $filename');
        }

        json['image'] = MultipartFile.fromBytes(
          bytes,
          filename: filename,
        );
        print(
            '✅ toFormJson - Image added to FormData with filename: $filename');
      } catch (e) {
        print('❌ toFormJson - Error reading image: $e');
      }
    } else {
      print('⚠️ toFormJson - No image provided');
    }

    if (!isAdding) {
      json.remove('variants');
      print('🔧 toFormJson - Removed variants (edit mode)');
    }

    print('🔧 toFormJson - Final JSON keys: ${json.keys.join(", ")}');
    return json;
  }

  /// Convert date from DD/MM/YYYY or DD-MM-YYYY to YYYY-MM-DD
  String _convertDateFormat(String date) {
    try {
      // Remove any whitespace
      final trimmed = date.trim();
      
      // Check if already in YYYY-MM-DD format
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(trimmed)) {
        return trimmed;
      }
      
      // Try DD/MM/YYYY or DD-MM-YYYY format
      final parts = trimmed.split(RegExp(r'[/-]'));
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];
        
        // If year is 2 digits, assume 20xx
        final fullYear = year.length == 2 ? '20$year' : year;
        
        return '$fullYear-$month-$day';
      }
      
      // If format is unrecognized, return as-is
      return trimmed;
    } catch (e) {
      print('⚠️ Date conversion error: $e, returning original: $date');
      return date;
    }
  }
}
