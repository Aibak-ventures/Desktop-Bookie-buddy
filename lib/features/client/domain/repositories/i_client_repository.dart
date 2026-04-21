import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';

abstract interface class IClientRepository {
  Future<PaginationModel<ClientEntity>> getClients({
    int page = 1,
    String? searchName,
    String? searchPhone,
  });

  Future<ClientEntity> getClientById(int clientId);

  Future<ClientEntity> addClient(
    ClientRequestEntity client, {
    bool allowExisting = true,
  });

  Future<ClientEntity> updateClient(ClientRequestEntity client);

  Future<void> deleteClient(int clientId);
}
