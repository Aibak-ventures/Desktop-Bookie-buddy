import 'package:bookie_buddy_web/features/search/repositories/search_repository.dart';
import 'package:bookie_buddy_web/features/search/services/search_service.dart';
import 'package:get_it/get_it.dart';

/// Search module for dependency injection
/// 
/// Registers:
/// - SearchService
/// - SearchRepository
class SearchModule {
  static Future<void> init(GetIt getIt) async {
    // Register SearchService as singleton
    getIt.registerLazySingleton<SearchService>(
      () => const SearchService(),
    );

    // Register SearchRepository as singleton
    getIt.registerLazySingleton<SearchRepository>(
      () => SearchRepository(getIt()),
    );
  }
}
