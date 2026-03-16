import 'package:bookie_buddy_web/features/client/domain/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';

class UpdateClientUseCase {
  final IClientRepository _repository;

  UpdateClientUseCase(this._repository);

  Future<ClientModel> call(ClientRequestModel client) async {
    return await _repository.updateClient(client);
  }
}
