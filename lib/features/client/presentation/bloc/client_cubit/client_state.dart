part of 'client_cubit.dart';

@freezed
class ClientState with _$ClientState {
  const factory ClientState({
    required List<ClientEntity> suggestions,
    required ClientEntity? selectedClient,
    required String searchQuery,
    String? nextPageUrl,
    @Default(false) bool isLoading,
  }) = _ClientState;
}
