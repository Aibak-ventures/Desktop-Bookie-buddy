part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.search(
    String query, {
    String? startDate,
    String? endDate,
  }) = _Search;

  const factory SearchEvent.loadNextSearchResults(
    String query, {
    String? startDate,
    String? endDate,
  }) = _LoadNextSearchResults;
  const factory SearchEvent.reset() = _Reset;
}
