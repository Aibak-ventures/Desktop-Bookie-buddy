import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/search/domain/models/global_search_model.dart';

abstract interface class ISearchRepository {
  Future<PaginationModel<GlobalSearchModel>> getGlobalSearch({
    int page = 1,
    String? searchQuery,
    String? startDate,
    String? endDate,
  });
}
