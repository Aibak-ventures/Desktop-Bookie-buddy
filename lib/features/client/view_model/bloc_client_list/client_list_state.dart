part of 'client_list_bloc.dart';

@freezed
class ClientListState with _$ClientListState {
  const factory ClientListState.loading() = _Loading;
  const factory ClientListState.loaded({
    required List<ClientModel> clients,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    @Default(false) bool isLoading,
    String? searchQuery,
  }) = _Loaded;

  const factory ClientListState.error(String error) = _Error;

  const factory ClientListState.failure(String message) = _Failure;

  const factory ClientListState.success(
    String message, {
    @Default(false) bool didPop,
    @Default(true) bool needRefresh,
  }) = _Success;
}

extension ClientListStateX on ClientListState {
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;
}
