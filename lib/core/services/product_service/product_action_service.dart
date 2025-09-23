import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/features/product/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:dio/dio.dart';

class ProductActionService {
  static final Dio _dio = DioClient.dio;

  Future<void> addOrUpdateProduct({
    required ProductRequestModel product,
  }) async {
    try {
      final int? productId = product.productId;
      final bool isAdding = productId == null;

      final String url = isAdding
          ? "/api/v1/service/products/"
          : "/api/v1/service/products/$productId/";

      if (isAdding && product.variants == null) {
        throw "Please add at least one variant";
      }

      // Prepare FormData
      final formData = FormData.fromMap(
        await product.toFormJson(isAdding),
      );

      /// Log form data
      formData.fields.forEach((field) {
        log('Form field: ${field.key} = ${field.value}');
      });

      formData.files.forEach((file) {
        log('File field: ${file.key}, File name: ${file.value.filename}');
      });
      final variant = product.variants?.firstOrNull;
      if (!isAdding && product.variants != null && variant != null)
        await updateVariant(
          productId: productId,
          variantId: variant.id,
          updatedAttribute: variant.attribute,
          updatedStock: variant.stock,
        );

      final res = isAdding
          ? await _dio.post(url, data: formData)
          : await _dio.patch(url, data: formData);

      // final res = response[(!isAdding && product.variants != null) ? 1 : 0];

      log('status code: ${res.statusCode}, data: ${res.data}');
      if (res.statusCode == 200 || res.statusCode == 201) {
        return;
      } else if (res.statusCode == 413) {
        throw "Image too large";
      } else {
        throw res.data['message'] ??
            res.data['error'] ??
            "Failed to create product";
      }
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      if (e.response?.statusCode == 413) throw "Image too large";
      throw e.response?.data['error'] ??
          e.response?.data['message'] ??
          "Failed to create product";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw e.toString();
    }
  }

  Future<void> addProductVariants({
    required int productId,
    required String attribute,
    required int stock,
  }) async {
    try {
      final res = await _dio.post(
        '/api/v1/service/products/$productId/variants/',
        data: {
          "attribute": attribute,
          // "price": 250001,
          "stock": stock,
        },
      );

      log("add variant status: ${res.statusCode}, data: ${res.data}");
      if (res.statusCode == 200 || res.statusCode == 201) return;
      if (res.statusCode == 400)
        throw res.data['message'] ?? "Failed to create product variant";

      throw "Failed to create product variant";
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to create product variant";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw "Error creating product: $e";
    }
  }

  Future<Response> updateVariant({
    required int productId,
    required int variantId,
    required String? updatedAttribute,
    required int? updatedStock,
  }) async {
    try {
      final res = await _dio.patch(
        '/api/v1/service/products/$productId/variants/$variantId/',
        data: {
          if (updatedAttribute != null) "attribute": updatedAttribute,
          // "price": 250001,
          if (updatedStock != null) "stock": updatedStock,
        },
      );

      log("update variant status: ${res.statusCode}, data: ${res.data}");
      if (res.statusCode == 200) return res;

      if (res.statusCode == 400)
        throw res.data['message'] ?? "Failed to update product variant";

      throw "Failed to update product variant";
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to update product variant";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw "Error updating product: $e";
    }
  }

  Future<bool> deleteProduct({
    required int productId,
    int? variantId,
  }) async {
    try {
      // final res = await _dio.delete("/api/product_crud/$productId");
      final res = await _dio.delete(
        variantId != null
            ? '/api/v1/service/products/$productId/variants/$variantId/'
            : '/api/v1/service/products/$productId/',
      );

      log("Delete status: ${res.statusCode}, data: ${res.data}");
      if (res.statusCode == 200 || res.statusCode == 204) return true;

      throw "Failed to delete product";
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to delete product";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw "Error deleting product: $e";
    }
  }

  Future<void> addOrUpdateProductExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final bool isAdding = expense.expenseId == null;
      final String url = isAdding
          ? '/api/v1/expenses/variant-expenses/'
          : '/api/v1/expenses/variant-expenses/${expense.expenseId}/';

      final Map<String, dynamic> body = expense.toJson();

      final res = isAdding
          ? await _dio.post(url, data: body)
          : await _dio.patch(url, data: body);

      log("new expense: ${res.data}");
      if (res.statusCode != 200 && res.statusCode != 201)
        throw res.data['error'] ?? "Operation failed";
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Operation failed";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw e.toString();
    }
  }

  Future<ProductModel> fetchProductInfo(int productId) async {
    try {
      final res = await _dio.get('/api/v1/service/products/$productId/');
      if (res.statusCode == 200) {
        return ProductModel.fromJson(res.data);
      } else if (res.statusCode == 404) {
        log("Failed to load data, ${res.statusCode}, data: ${res.data}");
        throw res.data['error'] ?? "Product not found";
      } else {
        log("Failed to load data, ${res.statusCode}, data: ${res.data}");
        throw "Failed to load data";
      }
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to fetch data";
    } catch (e, stack) {
      log("fetch product info error: $e", stackTrace: stack);
      rethrow;
    }
  }

  Future<void> deleteExpense(int expenseId) async {
    try {
      final res = await _dio.delete("/expenses/product_expenses/$expenseId");
      if (res.statusCode == 200) {
        CustomSnackBar(message: "Expense deleted successfully", isError: false);
      } else {
        throw "Error deleting expense";
      }
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.message ?? "Error deleting expense";
    }
  }

  Future<void> transferProductToAnotherShop({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) async {
    try {
      final res = await _dio.post(
        '/api/v1/service/transfer-product/transfer-stock/',
        data: {
          "from_variant_id": fromVariantId,
          "to_shop_id": toShopId,
          if (toProductId != null)
            "to_product_id":
                toProductId, //destination product id, if null, a new product will create in the destination
          "transfer_quantity": transferQuantity,
        },
      );

      if (res.statusCode == 200) {
        return;
      } else {
        log("status code: ${res.statusCode}, data: ${res.data}");

        throw res.data['detail'] ?? res.data['error'] ?? "Transfer failed";
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
