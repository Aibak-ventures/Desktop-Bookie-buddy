import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';

class GetClientByIdUseCase {
  final IClientRepository _repository;

  GetClientByIdUseCase(this._repository);

  Future<ClientEntity> call(int clientId) =>
      _repository.getClientById(clientId);
}
