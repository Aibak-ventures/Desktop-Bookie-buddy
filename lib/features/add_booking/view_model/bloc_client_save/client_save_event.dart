part of 'client_save_bloc.dart';

@freezed
class ClientSaveEvent with _$ClientSaveEvent {
  const factory ClientSaveEvent.saveClient(ClientRequestModel client) =
      _SaveClient;
}
