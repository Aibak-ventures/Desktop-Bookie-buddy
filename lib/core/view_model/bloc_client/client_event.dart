part of 'client_bloc.dart';

@freezed
class ClientEvent with _$ClientEvent {
  const factory ClientEvent.searchQueryChanged(String query) =
      _SearchQueryChanged;
  const factory ClientEvent.loadNextData() = _LoadNextData;

  const factory ClientEvent.clientSelected(ClientModel selectedClient) =
      _ClientSelected;
  const factory ClientEvent.clearSelected([void Function()? callback]) =
      _ClearSelected;
}
