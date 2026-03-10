import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';

class ClientServices {
  static final String clientUrl = ApiEndpoints.bookings.clients;
  Future<CustomResponseModel> getClients({
    int page = 1,
    String? searchName,
    String? searchPhone,
  }) async {
    try {
      final response = await DioClient.dio.get(
        clientUrl,
        queryParameters: {
          'page': page,
          if (searchName != null) 'name': searchName,
          if (searchPhone != null) 'phone': searchPhone,
        },
      );
      log(response.realUri.toString());
      // log('get clients response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching clients: ${e.toString()}', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> addClient(ClientRequestModel client) async {
    try {
      final response = await DioClient.dio.post(
        clientUrl,
        data: client.toJson(),
      );

      log(
        'add client response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error adding client: ${e.toString()}', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateClient(ClientRequestModel client) async {
    try {
      final response = await DioClient.dio.patch(
        '$clientUrl${client.id}/',
        data: client.toJson(),
      );
      log(
        'update client response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating client: ${e.toString()}', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> deleteClient(int clientId) async {
    try {
      final response = await DioClient.dio.delete('$clientUrl$clientId/');

      log(
        'delete client response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error deleting client: ${e.toString()}', stackTrace: stack);
      rethrow;
    }
  }
}
