import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/services/client_services.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';

class ClientRepository {
  final ClientServices _service;

  ClientRepository({required ClientServices service}) : _service = service;

  Future<PaginationModel<ClientModel>> getClients({
    int page = 1,
    String? searchName,
    String? searchPhone,
  }) =>
      _service.getClients(
        page: page,
        searchName: searchName,
        searchPhone: searchPhone,
      );

  Future<ClientModel> addClient(ClientRequestModel client) =>
      _service.addClient(client);

  Future<ClientModel> updateClient(ClientRequestModel client) =>
      _service.updateClient(client);

  Future<void> deleteClient(int clientId) => _service.deleteClient(clientId);
}
