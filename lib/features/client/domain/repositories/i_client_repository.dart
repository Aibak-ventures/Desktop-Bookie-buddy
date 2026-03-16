import 'package:bookie_buddy_web/features/client/domain/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_model/client_model.dart';

abstract interface class IClientRepository {
  Future<PaginationModel<ClientModel>> getClients({
    int page = 1,
    String? searchName,
    String? searchPhone,
  });

  Future<ClientModel> addClient(
    ClientRequestModel client, {
    bool allowExisting = true,
  });

  Future<ClientModel> updateClient(ClientRequestModel client);

  Future<void> deleteClient(int clientId);
}
