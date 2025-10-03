import 'dart:developer';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/api_paths.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';

class ServiceApi {
  Future<CustomResponseModel> fetchServices() async {
    try {
      final response = await DioClient.dio.get(ApiPaths.service.selected);

      return CustomResponseModel.fromJson(response.data);
    } catch (e, stackTrace) {
      log('Failed to load services', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
