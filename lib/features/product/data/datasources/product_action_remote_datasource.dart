import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/utils/error/exceptions/product_exceptions.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_request_model/product_request_model.dart';

import 'package:dio/dio.dart';

class ProductActionRemoteDatasource {
  final Dio _dio;

  ProductActionRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<CustomResponseModel> addOrUpdateProduct({
    required ProductRequestModel product,
  }) async {
    try {
      final int? productId = product.productId;
      final bool isAdding = productId == null;

      print('\n🌐 === API CALL START ===');
      print('📍 Product ID: $productId');
      print('📍 Is Adding: $isAdding');
      print('📍 Product Name: ${product.name}');
      print('📍 Has Image: ${product.image != null}');

      final String url =
          "${ApiEndpoints.service.productsRoot}${isAdding ? '' : '$productId/'}";
      print('📍 URL: $url');
      print('📍 Method: ${isAdding ? 'POST' : 'PATCH'}');

      if (isAdding && product.variants == null) {
        throw 'Please add at least one variant';
      }

      // Prepare FormData
      print('📦 Preparing FormData...');
      final formData = FormData.fromMap(await product.toFormJson(isAdding));

      /// Log form data
      print('\n📋 Form Fields:');
      formData.fields.forEach((field) {
        log('   ${field.key} = ${field.value}');
      });

      print('\n📋 Form Files:');
      formData.files.forEach((file) {
        log('   ${file.key}: ${file.value.filename} (${file.value.length} bytes)');
      });

      final variant = product.variants?.firstOrNull;
      if (!isAdding && product.variants != null && variant != null) {
        print('🔄 Updating variant: ${variant.id}');
        await safeApiCall(
          () => updateVariant(
            productId: productId,
            variantId: variant.id,
            updatedAttribute: variant.attribute,
            updatedStock: variant.stock,
          ),
        );
      }

      print('🚀 Sending ${isAdding ? 'POST' : 'PATCH'} request...');
      final res = isAdding
          ? await _dio.post(url, data: formData)
          : await _dio.patch(url, data: formData);

      print('✅ Response Status: ${res.statusCode}');
      print('✅ Response Data: ${res.data}');
      print('🌐 === API CALL END ===\n');

      if (res.statusCode == 413) throw UnknownAppException('Image too large');
      return CustomResponseModel.fromJson(res.data);

      // final res = response[(!isAdding && product.variants != null) ? 1 : 0];

      //   if (res.statusCode == 200 || res.statusCode == 201) {
      //     return;
      //   } else if (res.statusCode == 413) {
      //     throw "Image too large";
      //   } else {
      //     throw res.data['message'] ??
      //         res.data['error'] ??
      //         "Failed to create product";
      //   }
      // } on DioException catch (e, stack) {
      //   log("Dio error: $e", stackTrace: stack);
      //   if (e.response?.statusCode == 413) throw "Image too large";
      //   throw e.response?.data['error'] ??
      //       e.response?.data['message'] ??
      //       "Failed to create product";
    } catch (e, stack) {
      log('Unexpected error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> addProductVariants({
    required int productId,
    required String attribute,
    required int stock,
  }) async {
    try {
      final res = await _dio.post(
        '${ApiEndpoints.service.productsRoot}$productId/variants/',
        data: {
          'attribute': attribute,
          'stock': stock,
          // "price": 250001,
        },
      );
      log(
        'add variant status: ${res.realUri.toString()}, ${res.statusCode}, data: ${res.data}',
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('add variant error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateVariant({
    required int productId,
    required int variantId,
    required String? updatedAttribute,
    required int? updatedStock,
    String? externalQrCode,
  }) async {
    try {
      final res = await _dio.patch(
        '${ApiEndpoints.service.productsRoot}$productId/variants/$variantId/',
        data: {
          if (updatedAttribute != null) 'attribute': updatedAttribute,
          // "price": 250001,
          if (updatedStock != null) 'stock': updatedStock,
          if (externalQrCode != null) 'external_qr_code': externalQrCode,
        },
      );
      log(
        'update variant status: ${res.realUri.toString()}, ${res.statusCode}, data: ${res.data}',
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('update variant error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> deleteProduct({
    required int productId,
    int? variantId,
  }) async {
    try {
      final res = await _dio.delete(
        '${ApiEndpoints.service.productsRoot}$productId/${variantId == null ? '' : 'variants/$variantId/'}',
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('Delete product error: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Future<CustomResponseModel> deleteExpense(int expenseId) async {
  //   try {
  //     // final res = await _dio.delete("/expenses/product_expenses/$expenseId");
  //     final res = await _dio.delete(
  //       '${ApiEndpoints.expenses.variantExpenses}$expenseId/',
  //     );

  //     return CustomResponseModel.fromJson(res.data);
  //   } catch (e, stack) {
  //     log('delete expense error: $e', stackTrace: stack);
  //     rethrow;
  //   }
  // }

  Future<CustomResponseModel> transferProductToAnotherShop({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) async {
    try {
      final res = await _dio.post(
        ApiEndpoints.service.transferStock,
        data: {
          'from_variant_id': fromVariantId,
          'to_shop_id': toShopId,
          if (toProductId != null)
            'to_product_id':
                toProductId, //destination product id, if null, a new product will create in the destination
          'transfer_quantity': transferQuantity,
        },
      );

      log(
        'transfer product status: ${res.realUri.toString()}, ${res.statusCode}, data: ${res.data}',
      );

      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('transfer product error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
