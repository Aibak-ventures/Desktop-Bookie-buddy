import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/services/service_api.dart';

class ServiceRepository {
  Future<List<ServicesModel>> fetchServices() async {
    try {
      return await ServiceApi.fetchServices();
    } catch (e) {
      rethrow;
    }
  }
}
