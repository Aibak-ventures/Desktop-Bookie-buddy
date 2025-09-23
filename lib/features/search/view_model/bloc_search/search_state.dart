part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded({
    required List<BookingsModel> bookings,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
  }) = _Loaded;
  const factory SearchState.error(String error) = _Error;
}

/// Extensions to handle SearchState more easily
extension SearchStateX on SearchState {
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;
}
