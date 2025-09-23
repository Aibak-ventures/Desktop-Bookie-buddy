import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';

class ClientServices {
  static const String clientUrl = "/api/v2/bookings/clients/";
  Future<PaginationModel<ClientModel>> getClients({
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

      if (response.statusCode == 200) {
        final data = (response.data['results'] as List)
            .map(
              (e) => ClientModel.fromJson(e),
            )
            .toList();

        return PaginationModel<ClientModel>(
          data: data,
          totalData: response.data['count'],
          nextPageUrl: response.data['next'],
        );
      } else {
        if (response.statusCode == 400) {
          return PaginationModel<ClientModel>(
            data: [],
            totalData: 0,
            nextPageUrl: null,
          );
        }
        log('status code: ${response.statusCode}, data: ${response.data}');
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to fetch clients';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<ClientModel> addClient(ClientRequestModel client) async {
    try {
      final response = await DioClient.dio.post(
        clientUrl,
        data: client.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ClientModel.fromJson(response.data['data']);
      } else {
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to add client';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<ClientModel> updateClient(ClientRequestModel client) async {
    try {
      final response = await DioClient.dio.patch(
        '$clientUrl${client.id}/',
        data: client.toJson(),
      );

      if (response.statusCode == 200) {
        return ClientModel.fromJson(response.data['data']);
      } else {
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to edit client';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<void> deleteClient(int clientId) async {
    try {
      final response = await DioClient.dio.delete('$clientUrl$clientId/');

      if (response.statusCode == 204 || response.statusCode == 200) {
        return;
      } else {
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to delete client';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
