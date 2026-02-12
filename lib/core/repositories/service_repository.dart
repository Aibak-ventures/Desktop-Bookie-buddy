import 'dart:developer';

import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/services/service_api.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';

class ServiceRepository {
  final ServiceApi _serviceApi;

  ServiceRepository({required ServiceApi serviceApi})
      : _serviceApi = serviceApi;

  Future<List<ServicesModel>> fetchServices() async {
    try {
      final response = await safeApiCall(_serviceApi.fetchServices);
      if (response.status.isSuccess) {
        return (response.data as List)
            .map((json) => ServicesModel.fromJson(json))
            .toList();
      } else if (response.status.isPermissionDenied) {
        log('Permission denied: ${response.devMessage}');
        throw 'You do not have permission to access these services. Please contact your administrator.';
      }
      log('Failed to fetch services: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}
