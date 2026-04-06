import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';

class AddClientUseCase {
  final IClientRepository _repository;

  AddClientUseCase(this._repository);

  Future<ClientEntity> call(
    ClientRequestEntity client, {
    bool allowExisting = true,
  }) async {
    return await _repository.addClient(
      client,
      allowExisting: allowExisting,
    );
  }
}
