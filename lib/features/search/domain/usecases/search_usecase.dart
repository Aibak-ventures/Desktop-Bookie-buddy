import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/search/domain/repositories/i_search_repository.dart';
import 'package:bookie_buddy_web/features/search/domain/models/global_search_model.dart';

class SearchUseCase {
  final ISearchRepository _repository;
  const SearchUseCase(this._repository);

  Future<PaginationModel<GlobalSearchModel>> call({
    int page = 1,
    String? searchQuery,
    String? startDate,
    String? endDate,
  }) async {
    return await _repository.getGlobalSearch(
      page: page,
      searchQuery: searchQuery,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
