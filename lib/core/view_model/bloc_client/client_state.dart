part of 'client_bloc.dart';

@freezed
class ClientState with _$ClientState {
  const factory ClientState.initial({
    required List<ClientModel> suggestions,
    required ClientModel? selectedClient,
    required String searchQuery,
    String? nextPageUrl,
    @Default(false) bool isLoading,
  }) = _Initial;
}
