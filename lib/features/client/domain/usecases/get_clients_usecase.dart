import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';

class GetClientsUseCase {
  final IClientRepository _repository;

  GetClientsUseCase(this._repository);

  Future<PaginationModel<ClientModel>> call({
    int page = 1,
    String? searchName,
    String? searchPhone,
  }) async {
    return await _repository.getClients(
      page: page,
      searchName: searchName,
      searchPhone: searchPhone,
    );
  }
}
