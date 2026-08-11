part of 'global_search_bloc.dart';

@freezed
class GlobalSearchState with _$GlobalSearchState {
  const factory GlobalSearchState.initial() = _Initial;
  const factory GlobalSearchState.loading() = _Loading;
  const factory GlobalSearchState.loaded({
    required List<GlobalSearchEntity> searchData,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
  }) = _Loaded;
  const factory GlobalSearchState.error(String error) = _Error;
}

/// Extensions to handle GlobalSearchState more easily
extension GlobalSearchStateX on GlobalSearchState {
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;
}
