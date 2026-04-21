import 'dart:developer';

import 'package:bookie_buddy_web/features/client/data/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/client/data/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/client/data/datasources/client_remote_datasource.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class ClientRepositoryImpl implements IClientRepository {
  final ClientRemoteDatasource _datasource;

  ClientRepositoryImpl(this._datasource);

  @override
  Future<PaginationModel<ClientEntity>> getClients({
    int page = 1,
    String? searchName,
    String? searchPhone,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.getClients(
          page: page,
          searchName: searchName,
          searchPhone: searchPhone,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<ClientEntity>.fromJson(
          response.data,
          (data) =>
              ClientModel.fromJson(data as Map<String, dynamic>).toEntity(),
        );
      }
      log('Failed to fetch clients: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stackTrace) {
      log('Error fetching clients: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<ClientEntity> getClientById(int clientId) async {
    try {
      final response = await safeApiCall(
        () => _datasource.getClientById(clientId),
      );
      if (response.status.isSuccess) {
        return ClientModel.fromJson(response.data as Map<String, dynamic>)
            .toEntity();
      }
      log('Failed to fetch client by id: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stackTrace) {
      log('Error fetching client by id: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<ClientEntity> addClient(
    ClientRequestEntity client, {
    bool allowExisting = true,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.addClient(ClientRequestModel.fromEntity(client)),
      );
      if (response.status.isSuccess) {
        return ClientModel.fromJson(response.data as Map<String, dynamic>)
            .toEntity();
      } else if (response.status.isValidationError &&
          response.devMessage is Map<String, dynamic> &&
          allowExisting) {
        final clientData =
            (response.devMessage as Map<String, dynamic>?)?['client'];
        if (clientData != null) {
          log(
            'Client already exists, returning existing client data from api $clientData',
          );
          return ClientModel.fromJson(clientData as Map<String, dynamic>)
              .toEntity();
        }
      }
      log('Failed to add client: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stackTrace) {
      log('Error adding client: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<ClientEntity> updateClient(ClientRequestEntity client) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateClient(ClientRequestModel.fromEntity(client)),
      );
      if (response.status.isSuccess) {
        return ClientModel.fromJson(response.data as Map<String, dynamic>)
            .toEntity();
      }
      log('Failed to update client: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stackTrace) {
      log('Error updating client: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteClient(int clientId) async {
    try {
      final response =
          await safeApiCall(() => _datasource.deleteClient(clientId));
      if (!response.status.isSuccess) {
        log('Failed to delete client: ${response.devMessage}');
        throw response.message ?? 'Failed to complete operation';
      }
    } catch (e, stackTrace) {
      log('Error deleting client: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
