part of 'client_list_bloc.dart';

@freezed
class ClientListEvent with _$ClientListEvent {
  const factory ClientListEvent.loadClients({
    String? searchQuery,
  }) = _LoadClients;
  const factory ClientListEvent.loadNextPageClients() = _LoadNextPageClients;
  const factory ClientListEvent.deleteClient(ClientModel client) =
      _DeleteClient;
  const factory ClientListEvent.editClient(ClientRequestModel client) =
      _EditClient;
  const factory ClientListEvent.addClient(ClientRequestModel client) =
      _AddClient;
}
