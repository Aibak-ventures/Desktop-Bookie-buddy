import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

class ClientRemoteDatasource {
  final Dio _dio;

  ClientRemoteDatasource({required Dio dio}) : _dio = dio;

  final String clientUrl = ApiEndpoints.bookings.clients;
  Future<CustomResponseModel> getClients({
    int page = 1,
    String? searchName,
    String? searchPhone,
  }) async {
    try {
      final response = await _dio.get(
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
      final response = await _dio.post(
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
      final response = await _dio.patch(
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
      final response = await _dio.delete('$clientUrl$clientId/');

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
