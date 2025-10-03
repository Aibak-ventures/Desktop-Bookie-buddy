import 'dart:developer';

import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/services/client_services.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';

class ClientRepository {
  final ClientServices _service;

  ClientRepository({required ClientServices service}) : _service = service;

  Future<PaginationModel<ClientModel>> getClients({
    int page = 1,
    String? searchName,
    String? searchPhone,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.getClients(
          page: page,
          searchName: searchName,
          searchPhone: searchPhone,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<ClientModel>.fromJson(
          response.data,
          (data) => ClientModel.fromJson(data as Map<String, dynamic>),
        );
      }
      log('Failed to fetch clients: ${response.devMessage}');
      throw response.message;
    } catch (e, stackTrace) {
      log('Error fetching clients: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ClientModel> addClient(
    ClientRequestModel client, {
    bool allowExisting = true,
  }) async {
    try {
      final response = await safeApiCall(() => _service.addClient(client));
      if (response.status.isSuccess) {
        return ClientModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.status.isValidationError &&
          response.devMessage is Map<String, dynamic> &&
          allowExisting) {
        final clientData =
            (response.devMessage as Map<String, dynamic>?)?['client'];
        if (clientData != null) {
          log(
            'Client already exists, returning existing client data from api $clientData',
          );
          return ClientModel.fromJson(clientData as Map<String, dynamic>);
        }
      }
      log('Failed to add client: ${response.devMessage}');
      throw response.message;
    } catch (e, stackTrace) {
      log('Error adding client: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<ClientModel> updateClient(ClientRequestModel client) async {
    try {
      final response = await safeApiCall(() => _service.updateClient(client));
      if (response.status.isSuccess) {
        return ClientModel.fromJson(response.data as Map<String, dynamic>);
      }
      log('Failed to update client: ${response.devMessage}');
      throw response.message;
    } catch (e, stackTrace) {
      log('Error updating client: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> deleteClient(int clientId) async {
    try {
      final response = await safeApiCall(() => _service.deleteClient(clientId));
      if (!response.status.isSuccess) {
        log('Failed to delete client: ${response.devMessage}');
        throw response.message;
      }
    } catch (e, stackTrace) {
      log('Error deleting client: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
