import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';

class DeleteClientUseCase {
  final IClientRepository _repository;

  DeleteClientUseCase(this._repository);

  Future<void> call(int clientId) async {
    return await _repository.deleteClient(clientId);
  }
}
