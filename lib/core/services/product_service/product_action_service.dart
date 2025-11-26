import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/api_paths.dart';
import 'package:bookie_buddy_web/core/error/exceptions/product_exceptions.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/product/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';

import 'package:dio/dio.dart';

class ProductActionService {
  static final Dio _dio = DioClient.dio;

  Future<CustomResponseModel> addOrUpdateProduct({
    required ProductRequestModel product,
  }) async {
    try {
      final int? productId = product.productId;
      final bool isAdding = productId == null;

      final String url =
          "${ApiPaths.service.productsRoot}${isAdding ? '' : '$productId/'}";

      if (isAdding && product.variants == null) {
        throw 'Please add at least one variant';
      }

      // Prepare FormData
      final formData = FormData.fromMap(await product.toFormJson(isAdding));

      /// Log form data
      formData.fields.forEach((field) {
        log('Form field: ${field.key} = ${field.value}');
      });

      formData.files.forEach((file) {
        log('File field: ${file.key}, File name: ${file.value.filename}');
      });
      final variant = product.variants?.firstOrNull;
      if (!isAdding && product.variants != null && variant != null)
        await safeApiCall(
          () => updateVariant(
            productId: productId,
            variantId: variant.id,
            updatedAttribute: variant.attribute,
            updatedStock: variant.stock,
          ),
        );

      final res = isAdding
          ? await _dio.post(url, data: formData)
          : await _dio.patch(url, data: formData);
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
        '${ApiPaths.service.productsRoot}$productId/variants/',
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
  }) async {
    try {
      final res = await _dio.patch(
        '${ApiPaths.service.productsRoot}$productId/variants/$variantId/',
        data: {
          if (updatedAttribute != null) 'attribute': updatedAttribute,
          // "price": 250001,
          if (updatedStock != null) 'stock': updatedStock,
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
        '${ApiPaths.service.productsRoot}$productId/${variantId == null ? '' : 'variants/$variantId/'}',
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('Delete product error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> addOrUpdateProductExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final bool isAdding = expense.expenseId == null;
      final String url =
          '${ApiPaths.expenses.variantExpenses}${expense.expenseId == null ? '' : '${expense.expenseId}/'}';

      final body = expense.toJson();

      final res = isAdding
          ? await _dio.post(url, data: body)
          : await _dio.patch(url, data: body);

      log(
        'add or update expense status: ${res.realUri.toString()}, ${res.statusCode}, data: ${res.data}',
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('add or update expense error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> deleteExpense(int expenseId) async {
    try {
      // final res = await _dio.delete("/expenses/product_expenses/$expenseId");
      final res = await _dio.delete(
        '${ApiPaths.expenses.variantExpenses}$expenseId/',
      );

      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('delete expense error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> transferProductToAnotherShop({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) async {
    try {
      final res = await _dio.post(
        ApiPaths.service.transferStock,
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
