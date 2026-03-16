import 'package:bookie_buddy_web/features/client/domain/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';

class AddClientUseCase {
  final IClientRepository _repository;

  AddClientUseCase(this._repository);

  Future<ClientModel> call(
    ClientRequestModel client, {
    bool allowExisting = true,
  }) async {
    return await _repository.addClient(
      client,
      allowExisting: allowExisting,
    );
  }
}
