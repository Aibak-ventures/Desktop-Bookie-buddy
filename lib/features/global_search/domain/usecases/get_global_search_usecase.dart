import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/global_search/domain/entities/global_search_entity/global_search_entity.dart';
import 'package:bookie_buddy_web/features/global_search/domain/repositories/i_global_search_repository.dart';

class GetGlobalSearchUseCase {
  final IGlobalSearchRepository _repository;
  const GetGlobalSearchUseCase(this._repository);

  Future<PaginationModel<GlobalSearchEntity>> call({
    int page = 1,
    String? searchQuery,
    String? startDate,
    String? endDate,
  }) => _repository.getGlobalSearch(
    page: page,
    searchQuery: searchQuery,
    startDate: startDate,
    endDate: endDate,
  );
}
