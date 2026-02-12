import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/search/models/global_search_model.dart';
import 'package:bookie_buddy_web/features/search/services/search_service.dart';
// import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class SearchRepository {
  final SearchService _service;
  const SearchRepository(this._service);

  /// get global search

  Future<PaginationModel<GlobalSearchModel>> getGlobalSearch({
    int page = 1,
    String? searchQuery,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchGlobalSearch(
          page: page,
          searchQuery: searchQuery,
          startDate: startDate,
          endDate: endDate,
        ),
      );

      if (response.status.isSuccess) {
        return PaginationModel.fromJson(
          response.data,
          (json) => GlobalSearchModel.fromJson(json as Map<String, dynamic>),
        );
      }

      log('Error fetching global search: ${response.devMessage}');
      throw response.message ?? 'Failed to fetch search results';
    } catch (e, stack) {
      log('Error fetching global search: $e', stackTrace: stack);
      rethrow;
    }
  }
}
