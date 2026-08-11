import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/global_search/domain/entities/global_search_entity/global_search_entity.dart';

abstract interface class IGlobalSearchRepository {
  Future<PaginationModel<GlobalSearchEntity>> getGlobalSearch({
    required int page,
    String? searchQuery,
    String? startDate,
    String? endDate,
  });
}
