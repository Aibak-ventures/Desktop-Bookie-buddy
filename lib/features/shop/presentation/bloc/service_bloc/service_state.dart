part of 'service_bloc.dart';

@freezed
class ServiceState with _$ServiceState {
  const factory ServiceState.loading() = _Loading;
  const factory ServiceState.loaded(List<ServicesModel> services) = _Loaded;
  const factory ServiceState.error(String error) = _Error;
}
