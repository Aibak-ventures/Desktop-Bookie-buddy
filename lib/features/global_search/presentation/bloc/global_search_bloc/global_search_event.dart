part of 'global_search_bloc.dart';

@freezed
abstract class GlobalSearchEvent with _$GlobalSearchEvent {
  const factory GlobalSearchEvent.search(
    String query, {
    String? startDate,
    String? endDate,
  }) = _Search;

  const factory GlobalSearchEvent.loadNextSearchResults(
    String query, {
    String? startDate,
    String? endDate,
  }) = _LoadNextSearchResults;
  const factory GlobalSearchEvent.reset() = _Reset;
}
