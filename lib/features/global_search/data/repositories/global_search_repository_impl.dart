import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/global_search/data/datasources/global_search_remote_datasource.dart';
import 'package:bookie_buddy_web/features/global_search/data/models/global_search_model/global_search_model.dart';
import 'package:bookie_buddy_web/features/global_search/domain/entities/global_search_entity/global_search_entity.dart';
import 'package:bookie_buddy_web/features/global_search/domain/repositories/i_global_search_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class GlobalSearchRepositoryImpl implements IGlobalSearchRepository {
  final GlobalSearchRemoteDatasource _datasource;
  const GlobalSearchRepositoryImpl(this._datasource);

  /// get global search
  @override
  Future<PaginationModel<GlobalSearchEntity>> getGlobalSearch({
    required int page,
    String? searchQuery,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.fetchGlobalSearch(
          page: page,
          searchQuery: searchQuery,
          startDate: startDate,
          endDate: endDate,
        ),
      );

      if (response.status.isSuccess) {
        return PaginationModel<GlobalSearchEntity>.fromJson(
          response.data,
          (json) => GlobalSearchModel.fromJson(
            json as Map<String, dynamic>,
          ).toEntity(),
        );
      }

      log('Error fetching global search: ${response.devMessage}');
      throw response.message ?? 'Error fetching global search';
    } catch (e, stack) {
      log('Error fetching global search: $e', stackTrace: stack);
      rethrow;
    }
  }
}
