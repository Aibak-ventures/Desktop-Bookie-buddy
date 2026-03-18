import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class ShopService {
  Future<CustomResponseModel> fetchShops() async {
    try {
      final response =
          await DioClient.dio.get(ApiEndpoints.shop.availableShops);
      // log("Fetch Shops Response: ${response.realUri.toString()} ,${response.data}");
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch Shops Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> getAllShopSummary({
    required int year,
    required int month,
    int? shopId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.shop.allShopSummary(
          year: year,
          month: month,
          shopId: shopId,
        ),
      );
      log(
        'Get All Shop Summary Response: ${response.realUri.toString()} ,${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Get All Shop Summary Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
