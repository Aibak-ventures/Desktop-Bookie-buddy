part of 'client_cubit.dart';

@freezed
class ClientState with _$ClientState {
  const factory ClientState({
    required List<ClientModel> suggestions,
    required ClientModel? selectedClient,
    required String searchQuery,
    String? nextPageUrl,
    @Default(false) bool isLoading,
  }) = _ClientState;
}
