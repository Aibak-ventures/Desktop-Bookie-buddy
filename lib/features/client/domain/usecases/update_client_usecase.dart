import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';

class UpdateClientUseCase {
  final IClientRepository _repository;

  UpdateClientUseCase(this._repository);

  Future<ClientEntity> call(ClientRequestEntity client) async {
    return await _repository.updateClient(client);
  }
}
